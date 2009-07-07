require 'controller_routes_gum'
require 'super_scaffold_controller'
ActiveRecord::Base.send :include, ControllerRoutesGum
ActionController::Base.send :include, SuperScaffoldController