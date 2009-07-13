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

    def super_scaffold(options = {})
      options[:columns] ||= {:name => 'string'}

      module_eval <<-EOV
      def index
        @collection = #{set_class_name(options[:model])}.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
        @columns = #{options[:columns].inspect}
        render 'super_scaffold/index'
      end

      def new
        @record = #{set_class_name(options[:model])}.new
        @columns = #{options[:columns].inspect}
        render 'super_scaffold/new'
      end

      def create
        @record = #{set_class_name(options[:model])}.new(params[#{set_class_name(options[:model])}.params_name])
        if @record.save 
          redirect_to :controller => #{set_class_name(options[:model])}.controller_url('#{options[:name_space]}')
        else
          render 'super_scaffold/new'
        end
      end

      def show
        @record = #{set_class_name(options[:model])}.find(params[:id])
        @columns = #{options[:columns].inspect}
        render 'super_scaffold/show'
      end


      def edit
        @record = #{set_class_name(options[:model])}.find(params[:id])
        @columns = #{options[:columns].inspect}
        render 'super_scaffold/edit'
      end

      def update
        @record = #{set_class_name(options[:model])}.find(params[:id])
        if @record.update_attributes(params[#{set_class_name(options[:model])}.params_name])
          redirect_to :controller => #{set_class_name(options[:model])}.controller_url('#{options[:name_space]}')
        else
          render 'super_scaffold/new'
        end
      end

      def destroy
        @record = #{set_class_name(options[:model])}.find(params[:id])
        if @record.destroy
          redirect_to :controller => #{set_class_name(options[:model])}.controller_url('#{options[:name_space]}')
        end
      end
      EOV
    end

  end

end









