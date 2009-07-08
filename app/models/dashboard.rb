class Dashboard < ActiveRecord::Base
    acts_as_tree
    named_scope :parents, :conditions => { :parent_id => nil }
    named_scope :parents_by_role_id, lambda { |role_id| {:conditions => {:role_id => role_id, :parent_id => nil}}}
    
    def has_children?
      children.size > 0
    end
end
