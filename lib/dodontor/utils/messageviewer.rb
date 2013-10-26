# coding: utf-8

require 'msgpack'
require 'json'
Encoding.default_external = 'UTF-8'

module DodontoR::Utils
    class MessageViewer
        def initialize(app)
            @app = app
        end

        def call(env)
            input = env['rack.input'].read
            env['rack.input'] = StringIO.new(input)
            req = Rack::Request.new(env)
            env['rack.input'] = StringIO.new(input)

            res = @app.call env

            if !req.post?
                input = env['QUERY_STRING']
            end
            begin
                p MessagePack.unpack input
            rescue
                p input
            end

            res[2].each do |body|
                begin
                    p JSON.parse body
                rescue
                    p body
                end
            end

            res
        end
    end
end
