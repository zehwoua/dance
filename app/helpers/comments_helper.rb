module CommentsHelper
	def comment_message(number)
        if number == 0 
        	comment_message = "No Comment yet" 
        elsif number == 1
        	comment_message = "#{number} Comment"
        else
        	comment_message = "#{number} Comments"
        end
        return comment_message     	
    end

    def comment_status(c)
        if c.approved == true
            status = raw("<span class='text-success'><b>Approved</b></span>")
        elsif c.approved == false
            status = raw("<span class='text-danger'><b>Unapproved</b></span>")
        else c.approved == nil
            status = raw("<span class='text-warning'><b>Pending</b></span>")
        end
    end
end
