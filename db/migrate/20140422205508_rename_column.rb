
class RenameColumn < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.rename :rake, :upc_code
    end
  end
end
