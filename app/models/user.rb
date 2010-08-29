class User
  include Mongoid::Document
  include Mongoid::Timestamps

  ADMIN = 'admin'
  MEMBER = 'member'
  VIEWER = 'viewer'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :oauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :account_id, :account_role

  field :account_role, :default => VIEWER

  referenced_in :account
  references_many :projects, :stored_as => :array, :inverse_of => :users
  references_many :tasks
  references_many :project_members
  
#  has_many :project_members
#  has_many :projects, :through => :project_members
#  has_many :tasks

  def admin?
    account_role.eql? ADMIN
  end

  def member?
    account_role.eql? MEMBER
  end

  def viewer?
    account_role.eql? VIEWER
  end
end
