module UsersHelper

    def users_name
        current_user.name.split.map { |name| name.capitalize }.join(" ")
    end

end