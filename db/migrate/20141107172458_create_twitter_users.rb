class CreateTwitterUsers < ActiveRecord::Migration
  def change
  	create_table :twitter_users do |t|
  		t.string :twitter_username, index: true
  		t.string :access_token, index: true
  		t.string :access_token_secret, index: true

  		t.timestamps
  	end
  end
end