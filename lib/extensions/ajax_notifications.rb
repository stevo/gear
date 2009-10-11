# Extends application RJS handling, so any flash or validation errors will be refreshed on page after any ajax action.
# This extension depends on message_block gem and will be switched off if this gem is missing.
# Model names for message block are to be stored in MODEL_NAMES_FOR_MB global constant
        
module ActionController #:nodoc:
  class Base #:nodoc:
    private

    def render_for_text_with_flashes(text = nil, status = nil, append_response = false) #:nodoc:
      result = render_for_text_without_flashes(text, status, append_response)

      begin
        if response.content_type == Mime::JS
          self.flash[:warn] = Err.message if defined?(Err) and Err.errors?
          begin

            flash_content = self.instance_variable_get("@template").message_block :flash_types => %w(back confirm error info warn notice), :on => MODEL_NAMES_FOR_MB

            #unless no message block content present...
            unless flash_content=='<div id="message_block"></div>'
              response.body << "$('messages').update('#{flash_content}');new Effect.Highlight('messages'); "
              self.flash.clear
            else
              response.body << "$('message_block').innerHTML=''"
            end

          rescue => e
            if e.is_a?(NameError)
              puts "Ajax notification failed to execute due to following reason -> #{e.message}"
              puts "Removing from method chain..."
              ActionController::Base.send :alias_method, :render_for_text, :render_for_text_without_flashes
              ActionController::Base.send :remove_method,:render_for_text_with_flashes
              ActionController::Base.send :remove_method, :render_for_text_without_flashes
            else
              puts "Problem with ajax notifications -> #{e.message}"
            end

          end

        end
      ensure
        return result
      end
    end

    alias_method_chain :render_for_text, :flashes
  end
end

