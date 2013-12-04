
module Joker::Rails
  module ActiveRecord

    module JokerMethods

      def joker_filter params
        current_joker_scoped = self.current_scope || self.scoped

        #begin
        #  current_joker_scoped = current_joker_scoped.paginate page: params[:page], per_page: params[:limit]
        #rescue
        #  throw "Eh preciso importar a gem will_paginate"
        #end

        if params[:filter]
          current_joker_scoped = current_joker_scoped.unscoped
          self.get_filters.each do |item|
            current_joker_scoped = current_joker_scoped.send "by_#{item.name}", params[:filter][item.name] unless params[:filter][item.name].blank?
          end
        end
        current_joker_scoped
      end

    end

    # mix everything into Active Record
    ::ActiveRecord::Base.extend JokerMethods

    klasses = [::ActiveRecord::Relation]
    if defined? ::ActiveRecord::Associations::CollectionProxy
      klasses << ::ActiveRecord::Associations::CollectionProxy
    else
      klasses << ::ActiveRecord::Associations::AssociationCollection
    end

    # support pagination on associations and scopes
    klasses.each { |klass| klass.send(:include, JokerMethods) }

  end

end