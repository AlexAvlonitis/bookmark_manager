require_relative '../data_mapper_setup.rb'

class Link
  include DataMapper::Resource

  has n, :tag, through: Resource

  property :id,   Serial
  property :bookmark_name, String
  property :url, String

end
