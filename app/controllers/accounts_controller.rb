class AccountsController < SiteController
  
  layout 'site'

  def new
    @account = Account.new
    @user = User.new
  end

  def create
    @user = User.new(params[:account][:users_attributes])
    @user.account_role = User::ADMIN
    params[:account].delete :users_attributes
    @account = Account.create(params[:account])
    @account.users << @user

    respond_to do |format|
      if @account.save
        format.html do
          redirect_to (request.protocol + @account.subdomain + '.' + request.host_with_port)
        end
      else
        format.html { render :new }
      end
    end
  end
end