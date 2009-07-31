class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.references :user, :null => false
      t.string :location
      t.string :zipcode
      t.references :city, :state, :country
      t.string :business_phone
      t.string :home_phone
      t.string :mobile_phone
      t.string :fax_number
      t.references :modified_by, :class_name => 'User' # Who has changed each record?
      t.string     :ip_address
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
