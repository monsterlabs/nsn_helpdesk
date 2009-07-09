class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.references :user, :null => false
      t.string :location
      t.string :zipcode
      t.references :city, :state, :country
      t.string :bussiness_phone
      t.string :home_phone
      t.string :mobile_phone
      t.string :fax_number

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
