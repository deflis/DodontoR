# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'dodontor'
require 'dodontor/utils/messageviewer'

use Rack::Reloader
use Rack::Logger, ::Logger::ERROR

map '/DodontoF/DodontoFServer.rb' do
  use DodontoR::Utils::MessageViewer
  run DodontoR::Application.new
end

run Rack::Directory.new('./public')
