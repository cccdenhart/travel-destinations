class AddKeywordsToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :keywords, :string
  end
end
