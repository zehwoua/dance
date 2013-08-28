module UsersHelper
	def avatar_url(user, options = {:size => 200, :class => "gravatar"})
		size = options[:size]
	 	avatar_class = options[:class]
		if @user.avatar.url.present?
			if (size < 100)
	    		image_tag(@user.avatar.url(:small), alt: "user name", class: "avatar", :width => size)
	    	else
	    		image_tag(@user.avatar.url(:medium), alt: "user name", class: avatar_class, :width => size)
	    	end
	  	else
	  		default_url = "https://cdn1.iconfinder.com/data/icons/faceavatars/PNG/FA01.png"#{}"#{root_url}images/guest.png"
		    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
		    image_tag(gravatar_url, alt: "user name", class: avatar_class)
		end
	end
end
