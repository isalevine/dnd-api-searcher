class ChangeFeatureClassToClasses < ActiveRecord::Migration[4.2]

  def change
    remove_column :features, :class
    add_column :features, :classes, :text, array: true, default: []

  end

end

# reverse change from migraton 003
