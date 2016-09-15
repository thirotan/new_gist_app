# frozen_string_literal: true

module SinatraApp
  class Contents
    attr_accessor :entry_id, :description, :cotent, :created_at
    def initialize
      @entry_id = entry_id
      @description = description
      @content = content
      @created_at = created_at
    end
  end
end
