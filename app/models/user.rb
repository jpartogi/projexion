class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ADMIN = 'admin'
  MEMBER = 'member'
  REPORTER = 'reporter'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :oauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :account_id, :account_role, :full_name

  field :account_role, :default => REPORTER
  field :full_name

  referenced_in :account
  references_and_referenced_in_many :projects, :inverse_of => :users
  references_many :tasks
  references_many :project_members

  validates_uniqueness_of :email, :scope => :account_id
  
  def name
    full_name.blank? ? truncate_email : full_name
  end

  def user_id
    id
  end

  def truncate_email
    self.email.partition('@').first
  end

  def admin?
    self.account_role.eql? ADMIN
  end

  def member?
    self.account_role.eql? MEMBER
  end

  def reporter?
    self.account_role.eql? REPORTER
  end
end
