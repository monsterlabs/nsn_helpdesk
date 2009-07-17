require 'rubygems'
require 'active_support/inflector'
module ListForController
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def set_class_name(class_name)
      ActiveSupport::Inflector.tableize(class_name).classify.constantize
    end

    def foreign_key(class_name)
        ActiveSupport::Inflector.tableize(class_name).classify.foreign_key
    end

    def list_for(class_name,options={})    
      options[:include].each do |model|
        module_eval <<-EOV  
          def list_by_#{model}
            @collection = #{set_class_name(class_name)}.#{foreign_key(model)}_equals(params[:id]).paginate :page => 1, :per_page => 10
            respond_to do |format|
              format.js { render 'list_js'}
            end
        end
        EOV
      end
    end

  end

end








