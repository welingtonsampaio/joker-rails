module Joker::Rails
  module ActionController
    class Base < ::ActionController::Base
      layout :set_default_to_joker_format

      def set_default_to_joker_format
        "content_only" if params[:format] == "joker"
      end


      protected

      #def create
      #  @franchise = Franchise.new(franchise_params)
      #  params[:user][:email] = params[:franchise][:email]
      #  params[:user][:name] = params[:franchise][:name]
      #  if save_with_reflections @franchise
      #    set_bankslip_settings
      #    redirect_to @franchise, notice: 'Franchise was successfully created.'
      #  else
      #    return show_errors_for @franchise
      #  end
      #end

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

      #def update
      #  @franchise.attributes= franchise_params
      #  if update_with_reflections @franchise
      #    set_bankslip_settings
      #    redirect_to @franchise, notice: 'Franchise was successfully updated.'
      #  else
      #    return show_errors_for @franchise
      #  end
      #end
      def update_with_reflections model
        save_with_reflections model, true
      end

      # @param ActiveRecord::Base
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