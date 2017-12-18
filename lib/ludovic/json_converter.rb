# frozen_string_literal: true
require 'json'

module Ludovic
  class JsonConverter
    FORBIDDEN_CHARS = /\./
    ERR_INVALID_CHARS = "Forbidden '.' in field %s"

    def datas
      throw "No data to parse" unless @datas
      @datas
    end

    def load_file(path)
      self.datas = File.read(path)
      self
    end

    def datas=(value)
      throw "Data must be a string value" unless value.is_a?(String)
      @datas = JSON.load(value)
    end

    def headers
      @headers ||= begin
        hsh = datas.first if datas.is_a?(Array)
        throw BadInput.new("Json must contain an array of objects") unless hsh.is_a?(Hash)
        get_deep_keys(hsh)
      end
    end

    def diggers
      @diggers ||= headers.map { |v| v.split('.') }
    end

    def get_deep_keys(hsh)
      hsh.each_with_object([]) do |(field, value), acc|
        throw BadInput.new(ERR_INVALID_CHARS % [field]) if field.match(FORBIDDEN_CHARS)
        other_keys = get_deep_keys(hsh[field]) if value.respond_to?(:keys)
        other_keys ? other_keys.each { |k| acc << "#{field}.#{k}" } : acc << field
      end
    end

    def to_csv(path)
      # TODO : Limitation : Structure dismatch, on empty dig result, throw error.
    end
  end

  class JsonConverter::BadInput < StandardError; end
end
