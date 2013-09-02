ActiveAdmin.register Video do
	scope :all, :default => true
	actions :all
	index do
		selectable_column
	    column :title
	    column :style
	    column :teacher
	    column :level
	    column :duration, :sortable => :duration do |video|
	    	duration = ''.html_safe
	    	duration += "#{video.duration} min"
	    duration
	    end
	    column "" do |video|
	    	links = ''.html_safe
	    	links += link_to '<span class="glyphicon glyphicon-zoom-in"></span>'.html_safe, admin_video_path(video), :class =>"view_admin_btn admin_btn"
	    	links += link_to '<span class="glyphicon glyphicon-pencil"></span>'.html_safe, edit_admin_video_path(video), :class =>"edit_admin_btn admin_btn"
	    	links += link_to '<span class="glyphicon glyphicon-remove-sign"></span>'.html_safe, admin_video_path(video), method: :delete, data: { confirm: 'Are you sure?' }, :class =>"delete_admin_btn admin_btn"
	    links
	    end
	end

	index :as => :grid do |video|
	    link_to(image_tag(video.photo.url(:small)), admin_video_path(video))
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
