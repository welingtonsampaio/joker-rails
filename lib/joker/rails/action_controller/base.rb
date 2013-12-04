module Joker::Rails
  module ActionController
    class Base < ::ActionController::Base
      include Pundit

      before_filter :authenticate_user!
      layout :set_default_to_joker_format

      rescue_from Pundit::NotAuthorizedError do |exception|
        if params[:format] == 'joker'
          render :json => {status: :error, error: 'Forbidden access'}, :status => 403, :layout => false
        else
          render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => true
        end
      end

      protected

      def user_not_authorized
        head 403, :text => "This is an error"
      end

      def set_default_to_joker_format
        "content_only" if params[:format] == "joker"
      end

      def save_with_reflections model, update = false
        response = true
        if model.save
          model.reflections.each do |i, association|
            next if association.macro != :belongs_to
            next unless params[association.name]

            puts eval("#{association.name}_params")
            object = eval("#{association.class_name}.find #{model.send(association.name).id }") if update
            object ||= eval("#{association.class_name}.new")
            object.attributes= eval("#{association.name}_params")

            unless object.save
              @joker_errors ||= {}
              @joker_errors[association.name] = object.errors.full_messages
              response = false
              next
            end
            model.send "#{association.name}_id=", object.id
          end
        else
          @joker_errors ||= {}
          @joker_errors[I18n.t("activerecord.models.#{model.class.name.tableize.singularize}")] = model.errors.full_messages
          response = false
        end
        if not response and not update
          model.destroy
        else
          model.save
        end
        response
      end

      def update_with_reflections model
        save_with_reflections model, true
      end

      # @param model ActiveRecord::Base
      def show_errors_for model
        if params[:format] == 'json'
          render :json => { status: :error, errors: @joker_errors}
        elsif model.persisted?
          flash[:notice] = @joker_errors
          render :action => :edit
        else
          flash[:notice] = @joker_errors
          render :action => :new
        end
      end

    end
  end
end