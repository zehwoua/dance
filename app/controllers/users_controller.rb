class UsersController < ApplicationController
	before_filter :authenticate_user!, except: [:new_payment_method, :confirm_payment_info]
	def show
		@user = User.find(params[:id])
	end

	def dashboard
		@user = User.find(current_user.id)
	end

	def edit
		@user = User.find(current_user.id)
	end

	def new_payment_method
	    @tr_data = Braintree::TransparentRedirect.
	                create_customer_data(:redirect_url => "http://localhost:3000/users/confirm_payment_info")
	end

	def edit_payment_info
	    current_user.with_braintree_data!
	    @credit_card = current_user.default_credit_card
	    @tr_data = Braintree::TransparentRedirect.
	                update_customer_data(:redirect_url => "http://localhost:3000/users/confirm_payment_info",
	                                     :customer_id => current_user.braintree_customer_id)
	end

	def confirm_payment_info
	    @result = Braintree::TransparentRedirect.confirm(request.query_string)

	    if @result.success?
		    
		    if user_signed_in?
		    	current_user.braintree_customer_id = @result.customer.id
		    	current_user.update_attribute(:braintree_customer_id, @result.customer.id)

		    	customer_id = @result.customer.id
				payment_token = @result.customer.credit_cards[0].token
			    result = Braintree::Subscription.create(
						  :payment_method_token => payment_token,
						  :plan_id => "basic_plan_01"
						)
			    # email = @result.customer.email
			    # redirect_to user_registration_path( :email => email )				
			end
		    render :action => "confirm_payment_info"
	    # elsif current_user.has_payment_info?
	    #   	current_user.with_braintree_data!
	    #   	render :action => "edit_payment_info"
	    # else
	    #   	render :action => "new_payment_method"
	    end
	end

	def update
		@user = User.find(current_user.id)
		respond_to do |format|
	      	if @user.update_attributes(params[:user])
		        format.html { redirect_to dashboard_profile_path, notice: 'Profile was successfully updated.' }
		        format.json { head :no_content }
	      	else
		        format.html { render action: "edit" }
		        format.json { render json: @user.errors, status: :unprocessable_entity }
	      	end
	    end
	end

	def update_avatar
		@user = User.find(current_user.id)
		respond_to do |format|
	  		if @user.update_attributes(params[:user])
	  			redirect_to dashboard_profile_path, notice: "photo was updated."
	  		else
		        format.html { render action: "edit" }
		        format.json { render json: @user.errors, status: :unprocessable_entity }
	      	end 
	    end
	end

	def billing
		redirect_to new_user_session_path unless user_signed_in?

	    if current_user && current_user.has_payment_info?
	      	current_user.with_braintree_data!

		    # @credit_card = current_user.default_credit_card
		      # @transactions = Braintree::Transaction.search do |search|
		      #   search.customer_id.is current_user.braintree_customer_id
		      # end
	    end
	end
end
