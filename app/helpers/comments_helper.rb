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
end
