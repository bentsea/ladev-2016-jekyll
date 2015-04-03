# ImageSet Liquid Plugin
# by Erik Dungan
# erik.dungan@gmail.com / @callmeed
# 
# Takes a dir, gets all the images from it, and creates HTML image and container tags
# Useful for creating an image gallery and the like 
# 
# USAGE
# default: {% image_set images/gallery1 %}
# (this will create a UL, then LI and IMG tags for each image in images/gallery1)
# 
# with options: {% image_set images/gallery2 --class=img-responsive --container-tag=div --wrap-tag=div %}
# (this will set the class for the <img> tags and use <div>s for the container and wrap)
# 
# OPTIONS
# --class=some_class (sets the class for the <img> tags, default is 'image')
# --wrap_tag=some_tag (sets the tag to wrap around each <img>, default is 'li')
# --wrap_class=some_class (sets the class for wrap_tag, default is 'image-item')
# --container_tag=some_tag (sets the tag to contain all <img>s, default is 'ul')
# --container_class=some_class (sets the class for container_tag, default is 'image-set')


module Jekyll
  class ImageSet < Liquid::Tag
    @path = nil
    @galleryid = nil
    @imagetext = nil
    @gallerydescription = nil

    def initialize(tag_name, text, tokens)
      super

      # The path we're getting images from (a dir inside your jekyll dir)
      @path = text.split(/\s+/)[0].strip

      #Defaults
      @galleryid = ' '
      @imagetext = ' '
      @gallerydescription = ' '

      # Parse Options
      if text =~ /id="/
        @galleryid = text.split(/id="/)[1].split(/"/)[0]
      end
      if text =~ /text="/
        @imagetext = text.split(/text="/)[1].split(/"/)[0]
      end 
      if text =~ /description="/
        @gallerydescription = text.split(/description="/)[1].split(/"/)[0]
      end

    end

    def render(context)
      # Get the full path to the dir
      # Include a filter for JPG and PNG images
      full_path = File.join(context.registers[:site].config['source'], @path, "*.{jpg,jpeg,png}")
      ## generate thumb path

      # Start building tags
      source = "<!-- begin gallery images -->\n"
      # Glob the path and create tags for all images
     
      Dir.glob(full_path).each do |image|
        file = Pathname.new(image).basename
        src = File.join('/', @path, file)
        tsrc = File.join('/', @path[0..-1] + "_thumbs", file)[0..-4] + "jpg"
        source += "<div class='col-md-4 col-xs-6 portfolio-item #{@galleryid}'>\n"
        source += "<a data-lightbox='#{@galleryid}' href='#{src}' title='#{@imagetext}'>\n"
        source += "<span class='project-hover'>\n"
        source += "<span>#{@gallerydescription}\n"
        source += "</span>\n"
        source += "</span>\n"
        source += "<img src='#{tsrc}' alt='#{@imagetext}'>\n"
        source += "</a>\n"
        source += "</div>\n"
      end 
      # Close it up
      source += "<!-- end gallery images -->\n"
      source
    end
  end
end

Liquid::Template.register_tag('image_set', Jekyll::ImageSet)
