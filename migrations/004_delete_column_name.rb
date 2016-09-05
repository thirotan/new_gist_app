Sequel.migration do
  change do
    alter_table(:contents) do 
      drop_column :name
    end
  end
end
