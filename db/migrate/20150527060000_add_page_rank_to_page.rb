class AddPageRankToPage < ActiveRecord::Migration
  def change
    add_column :page, :page_score, :float
  end
end
