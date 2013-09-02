ActiveAdmin.register User do
	actions :all
	index do
		selectable_column
		column :username
		column :email
		column :first_name
		column "Last Sign in",:last_sign_in_at do |user|
			date = user.last_sign_in_at.strftime("%d %b %Y")
			date
		end
		column "Member Since",:created_at do |user|
			date = user.created_at.strftime("%d %b %Y")
			date
		end
		column "Active" do |user|
			if user.has_payment_info?
				user.first_name
			end 
		end
		column "" do |user|
	    	links = ''.html_safe
	    	links += link_to '<span class="glyphicon glyphicon-zoom-in"></span>'.html_safe, admin_user_path(user), :class =>"view_admin_btn admin_btn"
	    	links += link_to '<span class="glyphicon glyphicon-pencil"></span>'.html_safe, edit_admin_user_path(user), :class =>"edit_admin_btn admin_btn"
	    	links += link_to '<span class="glyphicon glyphicon-remove-sign"></span>'.html_safe, admin_user_path(user), method: :delete, data: { confirm: 'Are you sure?' }, :class =>"delete_admin_btn admin_btn"
	    links
	    end
	end
end
