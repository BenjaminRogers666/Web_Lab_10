class AddDeviseToUsers < ActiveRecord::Migration[8.0]
  def change
    # Cambiar el tipo de la columna email existente (si es necesario)
    change_column :users, :email, :string, null: false, default: ""

    # Añadir solo las columnas que no existen
    add_column :users, :encrypted_password, :string, null: false, default: ""
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at, :datetime

    # Añadir índices únicos
    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true
  end
end