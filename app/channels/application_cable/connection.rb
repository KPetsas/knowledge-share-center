module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_current_user
    end

    def disconnect

    end

    protected
      def find_current_user
        # Here we do not have access to session, but we have access to cookies
        if (current_user = Expert.find_by(id: cookies.signed[:expert_id]))
          current_user
        else
          reject_unauthorized_connection
        end
      end

  end
end
