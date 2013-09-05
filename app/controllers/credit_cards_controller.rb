class CreditCardsController < ApplicationController
  before_filter :find_user, :find_customer
  before_filter :find_credit_card, :except => [:new, :create]


  def new
    billing_address = @customer.addresses.first || {}
    @credit_card = @customer.credit_cards.build({:cardholder_name => @customer.full_name, :billing_address => billing_address})
  end

  def edit; end

  def show; end

  def create
    @credit_card = @customer.credit_cards.build(params[:credit_card])
    if @credit_card.save
      flash[:notice] = "Credit card has been successfully updated."
      redirect_to user_profile_path(:anchor => "credit-card-tab")
    else
      flash[:alert] = @credit_card.errors.full_messages.join(".\n")
      render :new
    end
  end

  def update
    if @credit_card.update_attributes(params[:credit_card])
      flash[:notice] = "Credit card has been successfully updated."
      redirect_to user_credit_card_path(@user, @credit_card) and return
    else
      flash[:alert] = @credit_card.errors.full_messages.join(".\n")
      render :edit
    end
  end

  def make_default
    if @credit_card.update_attributes(:options => {:make_default => true})
      flash[:notice] = "Credit card has been successfully updated."
      redirect_to user_profile_path(:anchor => "credit-card-tab")
    end
  end

  def destroy
    @credit_card.destroy
    flash[:notice] = "Credit card has been successfully deleted."
    redirect_to user_profile_path(:anchor => "credit-card-tab")
  end

  protected
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_customer
    @customer = @user.customer
    redirect_to user_path(@user) and return if @customer.nil?
  end

  def find_credit_card
    @credit_card = @customer.credit_cards.find(params[:id])
  end
end
