class AccountsController < SiteController
  layout 'site'

  def new
    @account = Account.new
    @user = User.new
    @company = Company.new
  end

  def create
    # Hack because mongoid nested attributes only works with EmbeddedDocument
    @user = User.new(params[:account][:users])
    @user.account_role = User::ADMIN

    @company = Company.new(params[:account][:companies])

    params[:account].delete :users
    params[:account].delete :companies

    @account = Account.create(params[:account])
    @account.company = @company
    @account.users << @user
    @account.companies << @company

    respond_to do |format|
      if @account.save and @user.save
        format.html do
          redirect_to (request.protocol + @account.subdomain + '.' + request.host_with_port)
        end
      else
        format.html { render :new }
      end
    end
  end
end