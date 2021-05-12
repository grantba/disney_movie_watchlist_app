module UsersHelper

    def users_name
        current_user.name.titleize
    end

end