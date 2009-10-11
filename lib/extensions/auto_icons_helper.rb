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
