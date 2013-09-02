ActiveAdmin.register Video do
	index do
	    column :title
	    column :style
	    column :teacher
	    column :level
	    column :duration
	    default_actions
	end

	form :html => { :enctype => "multipart/form-data" } do |f|
	   f.inputs do
	   	f.input :title
	   	f.input :duration
	    f.input :style
	  	f.input :teacher
	    f.input :level
	    f.input :photo
	    f.input :description
	  end
	  f.buttons
	 end

end
