# coding: utf-8

$LOAD_PATH.unshift './lib'

require 'dodontof_rack.rb'
require './msg_viewer.rb'

require './dodontof_config'

use Rack::Logger, ::Logger::ERROR

map '/DodontoF/DodontoFServer.rb' do
    use MsgViewer
    run DodontoFRack.new
end

run Rack::Directory.new('./public')
