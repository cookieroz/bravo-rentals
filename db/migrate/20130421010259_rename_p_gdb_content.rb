class RenamePGdbContent < ActiveRecord::Migration
  def change
    rename_column :pg_search_documents, :content, :results
  end
end
