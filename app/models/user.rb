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
  attr_accessible :email, :password, :password_confirmation, :remember_me, :account_id, :account_role

  field :account_role, :default => REPORTER

  referenced_in :account
  references_and_referenced_in_many :projects, :inverse_of => :users
  references_many :tasks
  references_many :project_members
  
#  has_many :project_members
#  has_many :projects, :through => :project_members
#  has_many :tasks

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
