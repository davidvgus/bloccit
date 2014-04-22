class AddRankToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :rake, :float
  end
end
