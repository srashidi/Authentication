module SessionsHelper

	def log_in(user)
		session[:user_id] = user.id
		current_user = user
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_digest] = user.remember_digest
	end

	def current_user
		if (user_id = session[:user_id])
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_digest])
				log_in user
			end
		end
	end

	def current_user=(user)
		@current_user = user
	end

	def logged_in?
		!current_user.nil?
	end

	def log_out
		current_user.update_attribute(:remember_digest, nil)
		cookies.delete(:user_id)
		cookies.delete(:remember_digest)
		session.delete(:user_id)
		current_user = nil
	end
end
