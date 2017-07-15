module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = verify_cookie
    end

    def disconnect 

    end

    private 

    def verify_cookie
      if cookies.signed[:id].blank?  
         reject_unauthorized_connection 
      end
    end

  end
end
