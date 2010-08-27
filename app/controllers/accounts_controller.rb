class AccountsController < SiteController
  
  layout 'site'

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html do
          host = request.protocol + @account.subdomain + '.' + request.host_with_port
          redirect_to host
        end
      else
        format.html { render :new }
      end
    end
  end
end