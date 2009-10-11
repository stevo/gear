# AutoIconsHelper enable user to use  _icon_name_icon("tooltip")_ style methods in views to render standard icons
# Icons should be stored in public/images/icons folder and be in one of following formats
# - gif
# - png
#
# I.e. if user has placed edit.png icon in /images/icons, he can access it from view by simply calling either
#  edit_icon
# or
#  edit_icon("Custom edit icon title")
#
# Remember to restart app's server after adding new icons
module AutoIconsHelper
  begin
    Dir.foreach(File.join(RAILS_ROOT, 'public', 'images', 'icons')) do |icon|
      if icon =~ /.gif|.png/
        caption = icon.gsub(/.gif|.png/, "")
        define_method("#{caption}_icon"){|*message| msg = (message and message.first) || caption.humanize; image_tag("icons/#{icon}",
                                                                                                                     :alt => msg, :title => msg)}
      end
    end
  rescue => e
    puts "Auto icons failed to load because of following reason -> #{e.message}"
  end
end
