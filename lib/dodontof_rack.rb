# coding: utf-8

Encoding.default_external = 'UTF-8'

require "./DodontoF/DodontoFServer"
require "dodontof_server_patch_for_rack"

class DodontoFRack
    def call(env)
        input = env['rack.input'].read
        env['rack.input'] = StringIO.new(input)
        req = Rack::Request.new(env)

        $isMessagePackInstalled = true
        cgiParams = getCgiParams(env, req, input) 

        server = DodontoFServer.new(SaveDirInfo.new(), cgiParams, req, env['app.logger'] || env['rack.logger'])

        res = Rack::Response.new do |r|
            r.status = 200

            if( server.isJsonResult )
                r["Content-Type"]= "text/plain; charset=utf-8"
            else
                r["Content-Type"]= "application/x-msgpack; charset=x-user-defined"
            end
            if( server.isAddMarker )
                r.write "#D@EM>#"
            end

            if( server.jsonpCallBack )
                r["Access-Control-Allow-Origin"] = "*"

                r.write "#{server.jsonpCallBack}("
            end

            r.write server.getResponse

            if( server.jsonpCallBack )
                r.write ");"
            end

            if( server.isAddMarker )
                r.write "#<D@EM#";
            end

        end

        res.finish
    end

    def getCgiParams(env, req, input)
        if !req.post?
            input = env['QUERY_STRING']
        end

        return DodontoFServer.getMessagePackFromData( input )
    end
end
