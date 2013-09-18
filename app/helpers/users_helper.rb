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

	def options_for_month_select
    {
      :collection => Date::MONTHNAMES.each_with_index.to_a[1..-1].map { |month, index| [month, index.to_s.rjust(2, '0')]},
      :include_blank => false,
      :wrapper_html => { :class => 'pull-left' },
      :label => "Expiration Date",
      :input_html => { :class => 'form-control small_select month_select' }
    }
  	end

	def options_for_year_select
	    {
	       :collection => 1976..2200,
	       :include_blank => false,
         :wrapper_html => { :class => 'pull-left' },
         :label => "",
         :input_html => { :class => 'form-control small_select year_select' }
	    }
	end

	def options_for_country_select
    {
      :collection    => available_countries,
      :value_method  => :alpha_2_code,
      :label         => 'Country',
      :include_blank => false,
      :prompt => 'Please select a country',
      :input_html => { :class => 'form-control' }
    }
  end

  def options_for_region_select
    {
      :collection   => available_countries,
      :as           => :grouped_select,
      :group_method => :subregions,
      :value_method => :name,
      :input_html => { :class => 'form-control' }
    }
  end

  private
  def available_countries
    braintree_country_alpha_2_codes = Braintree::Address::CountryNames.map {|country| country[1]}
    Carmen::Country.all.select { |country| braintree_country_alpha_2_codes.include?(country.alpha_2_code) }.sort_by(&:name)
  end
end
