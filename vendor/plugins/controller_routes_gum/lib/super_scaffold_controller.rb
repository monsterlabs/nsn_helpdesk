require 'rubygems'
require 'active_support/inflector'
module SuperScaffoldController
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def set_class_name(class_name)
      ActiveSupport::Inflector.tableize(class_name).classify.constantize
    end

    def add_routes(class_name)
      set_class_name(class_name).send :add_controller_routes
    end
    
    def super_scaffold(options = {})
      add_routes(options[:class_name])
      options[:columns] ||= {:name => 'string'}
            
      module_eval <<-EOV
      def index
        @collection = #{set_class_name(options[:class_name])}.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
        @columns = #{options[:columns].inspect}
        render 'super_scaffold/index'
      end

      def new
        @record = #{set_class_name(options[:class_name])}.new
        @columns = #{options[:columns].inspect}
        render 'super_scaffold/new'
      end

      def create
        @record = #{set_class_name(options[:class_name])}.new(params[#{set_class_name(options[:class_name])}.params_name])
        if @record.save 
          redirect_to :controller => #{set_class_name(options[:class_name])}.controller_url('#{options[:name_space]}')
        else
          render 'super_scaffold/new'
        end
      end

      def show
        @record = #{set_class_name(options[:class_name])}.find(params[:id])
        @columns = #{options[:columns].inspect}
        render 'super_scaffold/show'
      end


      def edit
        @record = #{set_class_name(options[:class_name])}.find(params[:id])
        @columns = #{options[:columns].inspect}
        render 'super_scaffold/edit'
      end

      def update
        @record = #{set_class_name(options[:class_name])}.find(params[:id])
        if @record.update_attributes(params[#{set_class_name(options[:class_name])}.params_name])
          redirect_to :controller => #{set_class_name(options[:class_name])}.controller_url('#{options[:name_space]}')
        else
          render 'super_scaffold/new'
        end
      end

      def destroy
        @record = #{set_class_name(options[:class_name])}.find(params[:id])
        if @record.destroy
          redirect_to :controller => #{set_class_name(options[:class_name])}.controller_url('#{options[:name_space]}')
        end
      end
      EOV
    end

  end

end









