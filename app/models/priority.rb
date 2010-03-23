class Priority < ActiveRecord::Base
  def hash_color
    '#'+self.color
  end
end
