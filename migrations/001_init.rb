# frozen_string_literal: true
Sequel.migration do
  change do
    create_table(:entries) do
      primary_key :id, auto_increment: true
      String :entry_id, null: false
      String :description, text: true
      String :entry, text: true, null: false
      DateTime :created_at, null: false
    end
  end
end
