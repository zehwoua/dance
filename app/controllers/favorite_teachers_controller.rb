class FavoriteTeachersController < ApplicationController
	before_filter :authenticate_user!
	def create
		@teacher = Teacher.find(params[:teacher_id])
	    @favorite_teacher = current_user.favorite_teachers.create!(:teacher_id => params[:teacher_id])
	    respond_to do |format|
			format.html 
			format.js
		end
	end

	def update
	 	@favorite = FavoriteTeacher.find(params[:id])

	  	respond_to do |format|
		    if @favorite.update_attributes(params[:favorite_teacher])
		       format.html { redirect_to user_my_classes_path, notice: 'Post was successfully updated.' }
		       format.json { head :no_content } # 204 No Content
		    else
		      format.html { render action: "edit" }
		      format.json { render json: @post.errors, status: :unprocessable_entity }
		    end
	  	end
	end

	def destroy
		@teacher = Teacher.find(params[:id])
		@favorite_teacher = current_user.favorite_teachers.find_by_teacher_id(params[:id])
		@favorite_teacher.destroy
		respond_to do |format|
			format.html 
			format.js
		end
	end
end
