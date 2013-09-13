module AdminHelper
	def load_javascript
	  if Rails.env.production?
	  	content_for :header do
  			javascript_include_tag 'ga_auth_pro', :cache => true 
  		end
	  else
	  	content_for :header do
  			javascript_include_tag 'ga_auth_dev'
  		end
	  end
	end
end
