Sequel.migration do
  up do
    create_table(:contents) do
      primary_key :id
      String :name, :text=>true, :null=>false
      String :content, :text=>true, :null=>false
      DateTime :created_at, :null=>false
    end
  end
end
