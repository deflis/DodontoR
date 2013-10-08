# coding: utf-8

Encoding.default_external = 'UTF-8'

class DodontoFServer
    def initialize_with_rack(saveDirInfo, cgiParams, req, logger)
        @req = req
        @logger = logger

        initialize_without_rack(saveDirInfo, cgiParams)
    end
    alias_method :initialize_without_rack, :initialize
    alias_method :initialize, :initialize_with_rack

    def getRequestData(key)
        value = @cgiParams[key]

        if( value.nil? )
            if( @isWebIf )
                value = @req[key]
            end
        end
        return value
    end

    def logging(obj, *options)
        unless @logger.nil?
            @logger.info [obj, options]
        end
    end

    def loggingForce(obj, *options)
        unless @logger.nil?
            @logger.error [obj, options]
        end
    end

    def self.logging(obj, *options)
    end

    def self.loggingForce(obj, *options)
        p [obj, options]
    end

    def debug(obj1, *obj2)
        logging(obj1, *obj2)
    end
end
