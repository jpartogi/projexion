class CreateBacklogs < ActiveRecord::Migration
  def self.up
    create_table :backlogs do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :backlogs
  end
end
