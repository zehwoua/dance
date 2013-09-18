class Admin::UsersController < ApplicationController
	# before_filter :authenticate_admin_user!
	# before_filter :find_customer
 	# before_filter :find_credit_card, :except => [:new, :create]

	def index
		@search = User.search(params[:q])
		if params[:sort].present?
			if params[:sort] == '0'
				@users = @search.result.where(:admin => nil)
				@active = "approved"
			elsif params[:sort] == '1'
				@users = @search.result.where(:admin => params[:sort])
				@active = "unapproved"
			end
		else
    	@users = @search.result
    	@active = "all"
    	end
	end

	def show
		@user = User.find(params[:id])
		@customer = @user.customer
		if @user.paid_customer?
			@addresses = @customer.addresses
			@credit_cards = @customer.credit_cards
			@transactions = @customer.transactions
		end
	end
 

	def new
	  	@user = User.new
	  	@plans = BraintreeRails::Plan.all
	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @user }
	    end
	end

	def create
	   if params.has_key?(:plan_id) && params[:user][:plan_id].empty?
	    	redirect_to new_admin_user_path, :flash => { :alert => "Please select subscription type" }
	    else
		    plan_id = params[:user][:plan_id]
		    
		    params[:user].delete("plan_id")
		    @user = User.new(params[:user])

		    respond_to do |format|
			    if @user.save
			    	if params[:user][:customer_type] == "paid"
				    	redirection_link = admin_new_customer_path(:plan_id => plan_id, :user_id =>@user.id) 
				    elsif params[:user][:customer_type] == "free"
				    	@customer = BraintreeRails::Customer.create(:email => @user.email)
				    	@user.update_attribute(:braintree_customer_id, @customer.id)
				    	redirection_link = admin_user_path(@user)
				    end
			        format.html { redirect_to redirection_link, notice: 'user was successfully created.' }
			        format.json { render json: @user, status: :created, location: @teacher }
			    else
			        format.html { render action: "new" }
			        format.json { render json: @user.errors, status: :unprocessable_entity }
		      	end
		    end
		end
  	end

	# def edit
 #  		@user = User.find(params[:id])
	# 	@customer = @user.customer
 #  	end

	# def update
	# 	@user = User.find(params[:id])
	# 	@customer = @user.customer

	#     if @customer.update_attributes(params[:customer])
	#       flash[:notice] = "Customer has been successfully updated."
	#       redirect_to admin_user_path(@user) and return
	#     else
	#       flash[:alert] = @customer.errors.full_messages.join(".\n")
	#       render :edit
	#     end
	# end

	def new_admin
		@user = User.new

	    respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @user }
	    end
	end

	def create_admin
		@user = User.new(params[:user])

	    respond_to do |format|
		    if @user.save
		        format.html { redirect_to admin_users_path, notice: 'user was successfully created.' }
		        format.json { render json: @user, status: :created, location: @teacher }
		    else
		        format.html { render action: "new_admin" }
		        format.json { render json: @user.errors, status: :unprocessable_entity }
	      	end
	    end
	end

	def edit_admin
		@user = User.find(params[:id])
		redirect_to admin_users_path, notice: 'This user is not an admin' unless @user.admin?
  	end

  	def update_admin
  		# required for settings form to submit when password is left blank
	    if params[:user][:password].blank?
	      params[:user].delete("password")
	      params[:user].delete("password_confirmation")
	    end

	    @user = User.find(params[:id])
	    if @user.update_attributes(params[:user])
	      flash[:notice] = "Admin has been successfully updated."
	      # Sign in the user bypassing validation in case his password changed
	      if current_user == @user
	      	sign_in @user, :bypass => true
	      end
	      redirect_to admin_users_path
	    else
	      flash[:alert] = @user.errors.full_messages.join(".\n")
	      render :edit_admin
	    end
	end

	def new_customer
		@plan_id = params[:plan_id]
		@user_id = params[:user_id]
		@plan = BraintreeRails::Plan.find(@plan_id)
		@customer = BraintreeRails::Customer.new(:email => current_user.email)
		billing_address = @customer.addresses.first || {}
		@credit_card = @customer.credit_cards.build({:cardholder_name => @customer.full_name, :billing_address => billing_address})
	end

	def create_customer
		@plan_id = params[:plan_id]
		@user_id = params[:user_id]
		@user = User.find(@user_id)
		@customer = BraintreeRails::Customer.create(:email => @user.email)
		@credit_card = @customer.credit_cards.build(params[:credit_card])
		
	    if @credit_card.save
	    	@subscription = @credit_card.subscriptions.build(:plan_id => @plan_id)
	    	if @subscription.save 
		    	@user.update_attribute(:braintree_customer_id, @customer.id)
		      	flash[:notice] = "Subscriber customer successfully created"
		      	redirect_to admin_user_path(@user)
		    end
	    else
	      	flash[:alert] = @credit_card.errors.full_messages.join(".\n")
	      	render :new_customer
	    end
	end

  	def edit_customer
  		@user = User.find(params[:id])
		@customer = @user.customer
  	end

	def update_customer
		@user = User.find(params[:id])
		@customer = @user.customer

	    if @customer.update_attributes(params[:customer])
	      flash[:notice] = "Customer has been successfully updated."
	      redirect_to admin_user_path(@user) and return
	    else
	      flash[:alert] = @customer.errors.full_messages.join(".\n")
	      render :edit
	    end
	end

  	def destroy
	    @user = User.find(params[:id])
	    @user.destroy

	    respond_to do |format|
		    format.html { redirect_to admin_users_path }
		    format.json { head :no_content }
	    end
  	end

 #  	protected
 #  	def paid_customer?
	# 	customer_type == paid
	# end

	  # def find_customer
	  #   @customer = @user.customer
	  #   redirect_to user_path(@user) and return if @customer.nil?
	  # end

	  # def find_credit_card
	  #   @credit_card = @customer.credit_cards.find(params[:id])
	  # end
  end