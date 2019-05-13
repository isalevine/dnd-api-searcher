class CreateFeaturesTable < ActiveRecord::Migration[4.2]

  def change
    create_table :features do |t|
      t.string :api_id
      t.integer :api_index
      t.string :name
      t.text :desc, array: true, default: []
      t.integer :level
      t.text :classes, array: true, default: []

    end
  end

end
