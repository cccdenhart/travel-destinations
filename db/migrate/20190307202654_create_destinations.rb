class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
