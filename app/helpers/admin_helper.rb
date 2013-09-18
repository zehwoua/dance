module AdminHelper
	def load_javascript
	  if Rails.env.production?
	  	content_for :header do
  			javascript_include_tag 'ga_auth_pro' 
  		end
	  else
	  	content_for :header do
  			javascript_include_tag 'ga_auth_dev'
  		end
	  end
	end

	def find_user_subs(credit_cards)
		  @subscriptions = [];
        credit_cards.each do |credit_card|
            @subscriptions = credit_card.subscriptions
            return @subscriptions
        end
	end

	def subscription_status(plan)

		results = Braintree::Subscription.search do |search|
            search.status.in(
                      Braintree::Subscription::Status::Active,
                      Braintree::Subscription::Status::Canceled,
                      Braintree::Subscription::Status::PastDue
                    )
            if plan.present?
            	search.plan_id.is plan.id
            end
        end
        return results
	end
	def subscription_status_counter(results,status)
		count = 0;
        results.each do |result|
            if result.status == status
            	count+=1
            end
        end

        return count
	end

	def subscription_trial(results)
		count = 0;
        results.each do |result|
            if result.trial_period == true && result.status == "Active"
            	count+=1
            end
        end

        return count
	end
  def user_role(user)
    if user.admin?
      @role = "Admin"
    else
      @role = "Customer"
    end
    return @role
  end
end
