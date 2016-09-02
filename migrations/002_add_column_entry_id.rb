Sequel.migration do
  change do
    alter_table(:contents) do 
      add_column :entry_id, String
      set_column_not_null :entry_id
    end
  end
end
