class AddAuthenticationTokenToConsumers < ActiveRecord::Migration
  def change
    add_column :consumers, :authentication_token, :string
    add_index :consumers, :authentication_token
  end
end
