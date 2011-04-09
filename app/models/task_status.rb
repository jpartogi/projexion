class TaskStatus
  include Mongoid::Document
  include Mongoid::Timestamps

  field :display_name
  field :key
  field :color
  field :position, :type => Integer, :default => 1

  referenced_in :account
  
  references_many :tasks

  scope :ordered, asc(:position)

  validates_presence_of :display_name, :color

  before_create :set_position, :set_key
  before_destroy :check_only_record

  def set_key
    self.key = self.display_name.downcase.gsub(/\?|!|@|#|%|&|\*|\(|\)|>|<|\\|\||\{|\}|\[|\]|'|"|\.|,/, '').gsub(/\s+/, '-').strip.slice(0,100)
  end

  def hash_color
    '#'+self.color  
  end

  def set_position
    unless last_status.nil?
      self.position = last_status.position + 1
    end
  end

  def last_status
    account.task_statuses.ordered.last
  end

  def check_only_record
    if self.account.task_statuses.length == 1
      errors.add(:base, "cannot delete the only status")
      false
    end
  end

  def update_position(direction)
    position = self.position

    if direction.eql? 'up'
      status = TaskStatus.find_by_position(position.to_i - 1)
    else
      status = TaskStatus.find_by_position(position.to_i + 1)
    end

    self.position = status.position
    status.position = position

    TaskStatus.transaction do
      @bypass = true
      self.save
      status.save
    end

    return self
  end

end