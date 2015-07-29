class AddColumnsToIndexBanner < ActiveRecord::Migration
  def change
    index_banner = IndexBanner.translation_class.table_name

    add_column index_banner, :date_from, :string
    add_column index_banner, :name_text, :string
    add_column index_banner, :where_to_go, :string
  end
end
