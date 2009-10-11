#:nodoc: all
require "extensions/date_extensions"
require "extensions/hash_extensions"
require "extensions/all_cached"
require "extensions/auto_icons_helper"
require "extensions/browser_identification_helper"
require "extensions/ajax_notifications"
require "extensions/global_named_scopes"
ActionView::Base.send :include, AutoIconsHelper
ActionView::Base.send :include, BrowserIdentificationHelper