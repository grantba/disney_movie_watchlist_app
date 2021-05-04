module UsersHelper

    def users_name
        current_user.name.split { |name| name.capitalize }
    end

end