# coding: utf-8

Encoding.default_external = 'UTF-8'

require "./DodontoF/DodontoFServer"
require "dodontor_core"

module DodontoR
    class Application
        def call(env)
            req = Rack::Request.new(env)

            server = DodontoR::Core.new(req)

            res = Rack::Response.new do |r|
                r.status = 200

                if( server.isJsonResult )
                    r["Content-Type"]= "text/plain; charset=utf-8"

                    if( server.jsonpCallBack )
                        r["Access-Control-Allow-Origin"] = "*"

                        r.write "#{server.jsonpCallBack}("
                    end
                else
                    r["Content-Type"]= "application/x-msgpack; charset=x-user-defined"
                end

                r.write server.getResponse

                if( server.isJsonResult && server.jsonpCallBack )
                    r.write ");"
                end

            end

            res.finish
        end
    end
end
