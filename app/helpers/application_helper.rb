module ApplicationHelper
	def homepage?
		current_page?(root_url)
	end

	def confirmation?
		current_page?(page_path('success'))
	end

	def include_fonts
		fonts = <<-sitefonts      
      <link href='http://fonts.googleapis.com/css?family=Source+Sans+Pro:200,300,400,600,700,900,400italic' rel='stylesheet' type='text/css'>
      <link href='http://fonts.googleapis.com/css?family=Arapey:400italic,400' rel='stylesheet' type='text/css'>
		sitefonts
		
		fonts.html_safe
	end
end
