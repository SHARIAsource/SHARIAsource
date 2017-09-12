class AddContributorFkToSources < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :contributor_id, :integer
    add_index :sources, :contributor_id
  end
end
