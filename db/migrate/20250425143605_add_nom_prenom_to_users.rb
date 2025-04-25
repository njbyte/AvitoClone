class AddNomPrenomToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :nom, :string
    add_column :users, :prenom, :string
  end
end
