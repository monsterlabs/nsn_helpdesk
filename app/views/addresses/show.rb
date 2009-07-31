class Views::Addresses::Show < Views::Layouts::Application
  needs :addr
  # address is a reserver word for Erector

  def content
    unless @addr.nil?
      h2 'Información de contacto'
      table :id => "profile-info" do
        tr do 
          td { b 'Location:' }
          td { rawtext @addr.location }
        end
        unless @addr.country.nil?
          tr do 
            td { b 'Country:' }
            td { rawtext @addr.country.name }
          end
        end
        unless @addr.state.nil?
          tr do 
            td { b 'State:' }
            td { rawtext @addr.state.name  }
          end
        end
        unless @addr.city.nil?
          tr do 
            td { b 'City:' }
            td { rawtext @addr.city.name }
          end
        end
        unless @addr.zipcode.to_s.strip.empty?
          tr do 
            td { b 'Zipcode:' }
            td { rawtext @addr.zipcode }
          end
        end
        unless @addr.business_phone.to_s.strip.empty?
          tr do 
            td { b 'Business phone:' }
            td { rawtext @addr.business_phone }
          end
          unless @addr.home_phone.to_s.strip.empty?
            tr do 
              td { b 'Home phone:' }
              td { rawtext @addr.home_phone }
            end
          end
          unless @addr.mobile_phone.to_s.strip.empty?
            tr do 
              td { b 'Mobile phone:' }
              td { rawtext @addr.mobile_phone }
            end
          end
          unless @addr.fax_number.to_s.strip.empty?
            tr do 
              td { b 'Fax:' }
              td { rawtext @addr.fax_number }
            end
          end
        end
      end
      end

    widget Views::Addresses::ShowLog, :addr => @addr

    end
  end
