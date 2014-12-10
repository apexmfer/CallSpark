class FixLinkColumnName < ActiveRecord::Migration
  def self.up
    rename_column :supportlinks, :order, :sortorder
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
