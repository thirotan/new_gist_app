Sequel.migration do
  change do
    alter_table(:contents) do 
      add_column :description, String
    end
  end
end
