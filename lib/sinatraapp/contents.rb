# frozen_string_literal: true

module SinatraApp
  class Contents
    attr_accessor :entry_id, :description, :entry, :created_at
    def initialize(entry_id:, description:, entry:, created_at:)
      @entry_id = entry_id
      @description = description
      @entry = entry
      @created_at = created_at
    end
  end
end
