# coding: utf-8

Encoding.default_external = 'UTF-8'
require 'msgpack'
require 'json'

module DodontoR
    class Core < DodontoFServer
        def initialize(req)
            @req = req
            @logger = req.logger()

            if req.get?
                input = req.query_string
            else
                input = req.body.read
            end

            begin
                cgiParams = MessagePack.unpack input
            rescue
                cgiParams = {}
            end

            super(SaveDirInfo.new(), cgiParams)
        end

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

        def loggingException(e)
            loggingForce( e.to_s, "exception mean" )
            loggingForce( $@.join("\n"), "exception from" )
            loggingForce($!.inspect, "$!.inspect" )
        end

        def debug(obj1, *obj2)
            logging(obj1, *obj2)
        end
        def getTextFromJsonData(jsonData)
            begin
                jsonData = [] << jsonData if !(jsonData.is_a?(Array) || jsonData.is_a?(Hash))
                return JSON.generate(jsonData)
            rescue
                loggingForce jsonData, "json"
            end
        end

        def getDataFromMessagePack(data)
            return MessagePack.pack(data)
        end

        def getJsonDataFromText(text)
            jsonData = nil
            begin
                logging(text, "getJsonDataFromText start")
                begin
                    jsonData = JSON.parse text
                    logging("getJsonDataFromText 1 end")
                rescue => e
                    text = CGI.unescape text
                    jsonData = JSON.parse text
                    logging("getJsonDataFromText 2 end")
                end
            rescue => e
                # loggingException(e)
                jsonData = {}
            end

            return jsonData
        end

        def getMessagePackFromData(data)
            logging("getMessagePackFromData Begin")

            messagePack = {}

            if( data.nil? )
                logging("data is nil")
                return messagePack 
            end

            begin
                messagePack = MessagePack.unpack(data)
            rescue => e
                loggingForce("getMessagePackFromData rescue")
                loggingException(e)
            rescue Exception => e
                loggingForce("getMessagePackFromData Exception rescue")
                loggingException(e)
            end

            logging(messagePack, "messagePack")
            return messagePack
        end
    end
end
