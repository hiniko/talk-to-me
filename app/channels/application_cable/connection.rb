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
        Rails.logger.info "Rejected connection due to no cookie"
         reject_unauthorized_connection 
      end
      Rails.logger.info "Verfied cookie for user"
      cookies.signed[:id]
    end

  end
end
