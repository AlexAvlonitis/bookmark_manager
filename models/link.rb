require 'data_mapper'
require 'dm-postgres-adapter'

class Link

  include DataMapper::Resource

  property :id, Serial
  property :title, Text
  property :url, Text
end


DataMapper.setup(:default,"postgres://#{ENV['USER']}@localhost/bookmark_manager_test")
DataMapper.finalize
DataMapper.auto_upgrade!
