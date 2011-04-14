module Mongoid
  module Eventable
    extend ActiveSupport::Concern

    included do
      after_create :create_event, :unless => :test?
      after_update :update_event, :unless => :test?
      after_destroy :delete_event, :unless => :test?

      include InstanceMethods
      include ApplicationHelper
      include Rails.application.routes.url_helpers
    end

    module InstanceMethods
      def test?
        Rails.env.eql? 'test'
      end

      def update_event
        type = self.class.to_s.pluralize.underscore

        desc = "<a href='#{user_path(self.updater.user_id)}'>#{self.updater.name}</a> updated "
        desc << "#{self.class.to_s.humanize} <a href='#{self.slug}'>#{self.title}</a>"

        _event(desc, self.updater)
      end

      def create_event
        type = self.class.to_s.pluralize.underscore

        desc = "<a href='#{user_path(self.creator.user_id)}'>#{self.creator.name}</a> created "
        desc << "#{self.class.to_s.humanize} <a href='#{self.slug}'>#{self.title}</a>"

        _event(desc, self.creator)
      end

      def delete_event
        desc = "<a href='#{user_path(self.creator.user_id)}'>#{self.creator.name}</a> deleted "
        desc << "#{self.class.to_s.humanize} #{self.title}"

        _event(desc, self.creator)
      end

      private
        def _event(desc, user)
          type = self.class.to_s.pluralize.underscore

          Event.create(:description => desc, :account => self.account,
                       :user_email => user.email, :user => user, :account => account)
        end
    end
  end
end

class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_email
  field :description

  referenced_in :account
  referenced_in :user

  Account.send(:references_many, :events)
  User.send(:references_many, :events)

  index [[:created_at, Mongo::DESCENDING]], :background => true
end