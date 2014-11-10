class CreateTweets < ActiveRecord::Migration
  def change
  	create_table :tweets do |t|
  		t.text :tweet_text, index: true
  		t.integer :twitter_user_id, index: true

  		t.timestamps
  	end
  end
end
