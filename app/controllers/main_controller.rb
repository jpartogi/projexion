class MainController < ApplicationController
    respond_to :html, :json # class level
    before_filter :require_user, :only => :index

    def index
    end

    def show
    end
end
