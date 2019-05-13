class ChangeFeatureClassesToClass < ActiveRecord::Migration[4.2]

  def change
    remove_column :features, :classes
    add_column :features, :class, :text, array: true, default: []

  end

end
