module SuperScaffoldController
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def super_scaffold(options = {})
      options[:columns] ||= {:name => 'string'}
      module_eval <<-EOV
        def index
          @collection = #{options[:model]}.all.paginate :page => params[:page] || 1, :per_page => params[:per_page] || 10
          @columns = #{options[:columns].inspect}
          render 'super_scaffold/index'
        end

        def new
          @record = #{options[:model]}.new
          @columns = #{options[:columns].inspect}
          render 'super_scaffold/new'
        end

        def create
          @record = #{options[:model]}.new(params[#{options[:model]}.params_name])
          if @record.save 
            redirect_to :controller => #{options[:model]}.controller_url('#{options[:name_space]}')
          else
            render 'super_scaffold/new'
          end
        end

        def show
          @record = #{options[:model]}.find(params[:id])
          @columns = #{options[:columns].inspect}
          render 'super_scaffold/show'
        end

        def edit
          @record = #{options[:model]}.find(params[:id])
          @columns = #{options[:columns].inspect}
          render 'super_scaffold/edit'
        end

        def update
          @record = #{options[:model]}.find(params[:id])
          if @record.update_attributes(params[#{options[:model]}.params_name])
            redirect_to :controller => #{options[:model]}.controller_url('#{options[:name_space]}')
          else
            render 'super_scaffold/new'
          end
        end

        def destroy
          @record = #{options[:model]}.find(params[:id])
          if @record.destroy
            redirect_to :controller => #{options[:model]}.controller_url('#{options[:name_space]}')
          end
        end
      EOV
    end
    
  end
  
end









