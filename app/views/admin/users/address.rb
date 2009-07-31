class Views::Admin::Users::Address < Erector::RailsWidget
  needs :f, :user
  
  def content
    f.fields_for 'address_attributes', user.address do |address|
      rawtext address.hidden_field :id
 
      div :class => 'field' do
        label "Location"
        rawtext address.text_area :location, :size => '40x4'
      end
 
      div :class => 'field' do
        label "Country"
        rawtext address.collection_select  :country_id, Country.all, :id, :name, {:prompt => true}
      end

      div :class => 'field' do
        label "State"
        rawtext address.collection_select  :state_id, State.all, :id, :name, {:prompt => true}
      end

      div :class => 'field' do
        label "City"
        rawtext address.collection_select  :city_id, City.all, :id, :name, {:prompt => true}
      end
      
      div :class => 'field' do
          label "Zipcode"
          rawtext address.text_field :zipcode, :size => 5
      end

      div :class => 'field' do
          label "Bussines phone"
          rawtext address.text_field :business_phone, :size => 15
      end

      div :class => 'field' do
          label "Home phone"
          rawtext address.text_field :home_phone, :size => 15
      end

      div :class => 'field' do
          label "Mobile phone"
          rawtext address.text_field :mobile_phone, :size => 15
      end

      div :class => 'field' do
          label "Fax number"
          rawtext address.text_field :fax_number, :size => 15
      end
    end
  end
  
end
