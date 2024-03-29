class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :long_url
      t.string :short_url
      t.integer :redirections, :default => 0

      t.timestamps
    end
  end
end
