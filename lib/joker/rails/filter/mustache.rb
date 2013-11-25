module Joker::Rails
  class FilterMustache < Mustache
    attr_accessor :fields, :first
    attr_accessor :form_url, :table_name
    # @param fields Array
    def initialize first,fields
      self.first = first
      self.fields= fields
    end
  end
end
Joker::Rails::FilterMustache.template_path = ''