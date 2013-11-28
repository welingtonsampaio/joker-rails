module Joker::Rails
  module Concerns

    module DefaultValue
      extend ActiveSupport::Concern

      module ClassMethods
        def set_default attribute, value
          self.send :define_method, "before_send_#{attribute}" do
            value = value.call(self) if value.instance_of? Proc
            self.send "#{attribute}=", value if @attributes[attribute.to_s].nil? or @attributes[attribute.to_s].blank?
          end
          self.send :before_save, "before_send_#{attribute}"
        end
      end
    end

  end
end
