# frozen_string_literal: true

module SinatraApp
  class Entries
    attr_reader :id, :entry_id, :description, :entry, :created_at
    def initialize(id:, entry_id:, description:, entry:, created_at:)
      @id = id
      @entry_id = entry_id
      @description = description
      @entry = entry
      @created_at = created_at
    end
  end
end
