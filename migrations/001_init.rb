# frozen_string_literal: true
Sequel.migration do
  change do
    create_table(:contents) do
      primary_key :id, auto_increment: true
      String :name, text: true, null: false
      String :content, text: true, null: false
      DateTime :created_at, null: false
    end
  end
end
