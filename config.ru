# coding: utf-8

$LOAD_PATH.unshift './lib'

require 'dodontor_application'
require './msg_viewer.rb'

use Rack::Reloader
use Rack::Logger, ::Logger::ERROR

map '/DodontoF/DodontoFServer.rb' do
    use MsgViewer
    run DodontoR::Application.new
end

run Rack::Directory.new('./public')
