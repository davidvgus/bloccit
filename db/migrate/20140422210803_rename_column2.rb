
class RenameColumn2 < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.rename :upc_code, :rank
    end
  end
end
