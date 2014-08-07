class AddContributorFkToSources < ActiveRecord::Migration
  def change
    add_column :sources, :contributor_id, :integer
    add_index :sources, :contributor_id
  end
end
