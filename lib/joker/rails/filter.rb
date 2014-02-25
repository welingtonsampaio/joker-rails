module Joker::Rails
  class Filter
    attr_accessor :name, :type, :collection, :url, :def_eval, :only_filter,
                  :callback, :indicekey, :template, :valuekey, :model

    # @param args Hash
    def initialize args
      args.keys.each {|method| send "#{method}=", args[method] if self.respond_to? method }
    end

    def def_eval
      @def_eval ||= %[where('#{model.table_name}.#{name} LIKE ?', "\#{value}%")] if type == :text
      @def_eval ||= %[where #{name}: value ] if type == :select
      @def_eval
    end

    def indicekey
      @indicekey || :id
    end

    def is_date() ; type == :date end
    def is_select() ; type == :select end
    def is_text() ; type == :text end
    def is_typeahead() ; type == :typeahead end

    def t_name
      model.human_attribute_name(name).humanize
    end

    def template
      @template || %[<p>{{name}}</p>]
    end

    def type
      @type.to_sym
    rescue
      :text
    end

    def valuekey
      @valuekey || :name
    end

  end
end