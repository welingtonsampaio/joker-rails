module Joker::Rails
  module Concerns

    module Filter
      extend ActiveSupport::Concern

      module ClassMethods
        attr_accessor :filter_fields,
                      :list_url

        def set_list_url url
          @list_url = url
        end

        def filter attribute, args, &block
          @filter_fields ||= Array.new
          args[:name]       = attribute
          args[:model]      = self
          args[:collection] = args[:collection].call if args[:collection].is_a?(Proc)
          filter = Joker::Rails::Filter.new args
          generate_method_filter filter unless filter.only_filter
          @filter_fields << filter
        end

        # @param attribute Joker::Rails::Filter
        def generate_method_filter attribute
          self.send :module_eval, <<EOT
  def self.by_#{attribute.name} value
    #{attribute.def_eval}
  end
EOT
        end

        def get_filters
          @filter_fields
        end

        protected :generate_method_filter

        def render_filters(path=nil)
          first = @filter_fields.first

          path = path.to_s if path.is_a? Symbol

          template = "#{Joker::Rails::JOKER_RAILS_PATH}/filter/filter.mustache"
          template = Rails.root.join('app','views','layouts','filter.mustache') if File.exist? Rails.root.join('app','views','layouts','filter.mustache')
          template = Rails.root.join('app','views',path,'filter.mustache') if File.exist? Rails.root.join('app','views',path,'filter.mustache') unless path.nil?

          mustache = Joker::Rails::FilterMustache.new [first], @filter_fields.slice(1..@filter_fields.count)
          mustache.form_url   = @list_url
          mustache.table_name = self.table_name
          mustache.template = File.read(template)
          ActiveSupport::SafeBuffer.new mustache.render
        end
      end
    end
  end
end
