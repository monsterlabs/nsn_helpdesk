class LoadUserRegionForFieldManager < ActiveRecord::Migration

  def self.user_regions(user_id, regions)
    @user = User.find(user_id)
    regions.each do |name|
        @user.regions << Region.find_by_name(name)
    end
  end
  
  def self.up
    user_regions(145, ['Region 8', 'Region 9'])
    user_regions(146, ['Region 3', 'Region 6', 'Region 7'])
    user_regions(147, ['Region 5'])
    user_regions(148, ['Region 2', 'Region 1', 'Region 4'])
    
    @emergency_role = Role.create!(:name => 'Emergencies')
    @user = User.find(144)
    @user.roles << @emergency_role
    @user.save
  end

  def self.down
    UserRegion.destroy_all
    UserRole.find_by_user_id(144).destroy
  end
end
