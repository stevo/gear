module BrowserIdentificationHelper

  # return true, if current browser matches browser gien as param
  def browser_is? name
    name = name.to_s.strip
    return true if browser_name == name
    return true if name == 'mozilla' && browser_name == 'gecko'
    return true if name == 'ie' && browser_name.index('ie')
    return true if name == 'webkit' && browser_name == 'safari'
  end

  # returns current browser name
  def browser_name
    @browser_name ||= begin

      ua = request.env['HTTP_USER_AGENT'].downcase

      if ua.index('msie') && !ua.index('opera') && !ua.index('webtv')
        'ie'+ua[ua.index('msie')+5].chr
      elsif ua.index('gecko/')
        'gecko'
      elsif ua.index('opera')
        'opera'
      elsif ua.index('konqueror')
        'konqueror'
      elsif ua.index('applewebkit/')
        'safari'
      elsif ua.index('mozilla/')
        'gecko'
      end
    end
  end

  # return current protocol used
  def protocol
    ( request.env['HTTPS'] == 'on' || request.env['HTTP_X_FORWARDED_PROTO'] == 'https') ? 'https://' : 'http://'
  end
end