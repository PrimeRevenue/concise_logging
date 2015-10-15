module ConciseLogging 
  class ConciseLoggingError < StandardError; end

    # allow for runtime configuration
    def self.options=(options)
      @@_options = options.symbolize_keys!
      #ensure format in FORMATS
    end
    def self.default_adhoc_fields
        { 
          app: Rails.application.class.to_s.underscore,
          host: Socket.gethostname,
          environment: Rails.env
        } 
    end
    def self.default_options
      {
        level: :warn,
        format: :text,
      }
    end
    def self.options
      if defined?(@@_options)
        default_options.merge(@@_options)
      else
        default_options
      end
    end

    
    def self.validate_options!
      unless FORMATS.include? options[:format]
        raise ConciseLoggingError.new("Not a valid format!")
      end
    end
    #self.validate_options!

end
require "concise_logging/version"
require "concise_logging/log_middleware"
require "concise_logging/log_subscriber"
require "concise_logging/railtie" if defined? Rails
