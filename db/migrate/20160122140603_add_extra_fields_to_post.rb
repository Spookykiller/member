class AddExtraFieldsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :portfolio_condition, :boolean
  end
end
