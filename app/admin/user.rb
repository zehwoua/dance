ActiveAdmin.register User do
	actions :all
	index do
		selectable_column
		column :username
		column :email
		column :name do |user|
			user.with_braintree_data!
			"#{user.first_name} #{user.last_name}"
		end
		column "Last Sign in",:last_sign_in_at do |user|
			date = user.last_sign_in_at.strftime("%d %b %Y")
			date
		end
		column "Member Since",:created_at do |user|
			date = user.created_at.strftime("%d %b %Y")
			date
		end
		column "Status" do |user|
			user.with_braintree_data!
			@credit_cards = user.credit_cards
			@credit_cards.find {|credit_card| credit_card.default? }

			# @credit_cards = Braintree::CreditCards.find(user.braintree_customer_id)
				
			

			# @customer = Braintree::Customer.find(user.braintree_customer_id)
			# # @credit_cards = customer.credit_cards
			# @credit_card = @customer.credit_cards
			# # @subscriptions = @credit_card.subscriptions
			# @credit_card.each do |cc|
   #    			cc.card_type
			# end
			
		end
		column "" do |user|
	    	links = ''.html_safe
	    	links += link_to '<span class="glyphicon glyphicon-zoom-in"></span>'.html_safe, admin_user_path(user), :class =>"view_admin_btn admin_btn"
	    	links += link_to '<span class="glyphicon glyphicon-pencil"></span>'.html_safe, edit_admin_user_path(user), :class =>"edit_admin_btn admin_btn"
	    	links += link_to '<span class="glyphicon glyphicon-remove-sign"></span>'.html_safe, admin_user_path(user), method: :delete, data: { confirm: 'Are you sure?' }, :class =>"delete_admin_btn admin_btn"
	    links
	    end
	end

	show do |user|
		user.with_braintree_data!
		div :class =>"row clearfix" do
		    panel "Customer Details",:class =>"user_info col-lg-6" do
			    attributes_table_for user do
			      row("Name") { user.full_name }
			      row("Username") { user.username }
			      row("Email") { user.email }
			      row("Member since") { nice_date_form(user.created_at) }
			      row("Last activity") { nice_date_form(user.last_sign_in_at) }
			    end
			end

			panel "Subscription",:class =>"user_info col-lg-6" do
			    attributes_table_for user do
			    	row("Plan name") { user.first_name }
			      	row("Status") { user.first_name }
			      	row("Price") { user.first_name }
			      	row("Billing Cycle") { user.first_name }
			    end
			end
		end
    end

    sidebar "Other Tasks For This User", :only => :show do
	  "Need help? Email us at help@example.com"
	end
end
