module ApplicationHelper
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    @title.nil? ? base_title : "#{base_title} | #{@title}"
  end
  
  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end
  
end
