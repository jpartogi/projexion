class Feature
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::Userstamps
  include Mongoid::Eventable

  include Rails.application.routes.url_helpers

  field :user_story
  field :business_value, :type => Float
  field :story_points, :type => Integer
  field :keywords, :type => Array

  referenced_in :sprint
  referenced_in :release
  referenced_in :priority
  referenced_in :project
  referenced_in :feature_statuses # mongoid bug.
  references_many :tasks
  references_many :acceptances

  validates_presence_of :user_story, :business_value, :story_points, :priority
  validates_numericality_of :business_value, :story_points

  before_create :set_default_status
  before_save :set_keywords

  def set_default_status
    self.feature_statuses = self.project.account.feature_statuses.ordered.first
  end

  def set_keywords
    self.keywords = self.user_story.downcase.split(KEYWORD_FILTER_MATCHER)
  end

  def slug
    project_feature_path(self.project.code, self)
  end

  def title
    id.to_s.slice(0,7).concat('...')
  end

  def account
    self.project.account
  end
end