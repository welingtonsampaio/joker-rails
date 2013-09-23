require "base64"

module Joker::Rails
  module ActiveRecord

    module JokerMethods
      def joker_filter params
        params = decrypt_params params
        current_joker_scoped = self.current_scope || self.scoped

        begin
          current_joker_scoped = current_joker_scoped.paginate page: params[:page], per_page: params[:limit]
        rescue
          throw "Eh preciso importar a gem will_paginate"
        end

        current_joker_scoped = current_joker_scoped.group params[:group]   if params.include? :group
        current_joker_scoped = current_joker_scoped.order params[:orderBy] if params.include? :orderBy
        current_joker_scoped = current_joker_scoped.where params[:where]   if params.include? :where
        current_joker_scoped
      end


      private
      def decrypt_params params
        params[:orderBy] = Base64.decode64 params[:orderBy] if params.include? :orderBy
        params[:group]   = Base64.decode64 params[:group]   if params.include? :group
        params[:where]   = Base64.decode64 params[:where]   if params.include? :where
        params
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