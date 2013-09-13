module AdminHelper
	def load_javascript
	  if Rails.env.production?
  		javascript_include_tag '/admin/ga_auth_pro', :cache => true 
	  else
  		javascript_include_tag '/admin/ga_auth_dev'
	  end
	end
end
