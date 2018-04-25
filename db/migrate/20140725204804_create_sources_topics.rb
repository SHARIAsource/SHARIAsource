class CreateSourcesTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :sources_topics, id: false do |t|
      t.integer :source_id
      t.integer :topic_id
    end

    add_index :sources_topics, :source_id
    add_index :sources_topics, :topic_id
    add_index :sources_topics, [:source_id, :topic_id], unique: true
  end
end
