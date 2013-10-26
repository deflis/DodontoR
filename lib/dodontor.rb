module DodontoR
    def self.get_dodontof_path
        File.expand_path('../../DodontoF/', __FILE__)
    end

    def self.get_dodontof_server
        File.expand_path('./DodontoFServer.rb', self.get_dodontof_path)
    end
end

require "dodontor/version"
require "dodontor/core"
require "dodontor/application"
