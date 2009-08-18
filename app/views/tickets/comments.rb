class Views::Tickets::Comments < Erector::RailsWidget
  needs :ticket
  
  def content
    tr :id => 'ticket_title' do 
      td {}
      td {label "Ticket Comments"}
    end
    c_index = -1
    @ticket.comments.reverse.each do |comment|
      c_index = c_index + 1
      tr do 
        td :id => 'ticket_left_cell' do 
        end
        td :id => 'ticket_right_cell' do 
          rawtext b "Ticket Comment: #{@ticket.comments.size - c_index}"
        end
      end
      tr do 
        td :id => 'ticket_left_cell' do 
          text 'From'
        end
        td :id => 'ticket_right_cell' do 
          rawtext "#{comment.user.person.nil? ? 'admin' : comment.user.person.fullname} - #{comment.created_at}"
        end
      end
      tr do 
        td :id => 'ticket_left_cell' do 
          text 'Comment'
        end
        td :id => 'ticket_right_cell' do 
          rawtext comment.body
        end
      end
    end
  end
end
