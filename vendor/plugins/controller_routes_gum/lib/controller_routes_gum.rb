# ControllerRoutesGum


module ControllerRoutesGum
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def add_controller_routes
      module_eval <<-EOV
      def self.controller_url(name_space='')
         [name_space, ActiveSupport::Inflector.underscore(self.to_s).pluralize].join('/')
       end

      def self.params_name
         ActiveSupport::Inflector.underscore(self.to_s).to_sym
      end
      EOV
    end
  end
  
end