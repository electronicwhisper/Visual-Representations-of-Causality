require 'rubygems'

require 'json'
require 'open-uri'
require 'cgi'

def get_flickr(method, opts={})
  flickr_api_key = "b7221816b2573ee111f71e0085fe45d7"
  query = opts.map{|k,v| "#{CGI.escape(k)}=#{CGI.escape(v)}"}.join("&")
  uri = "http://api.flickr.com/services/rest/?format=json&nojsoncallback=1&api_key=#{flickr_api_key}&method=#{method}&#{query}"
  JSON.parse(open(uri).read)
end

collection = get_flickr("flickr.collections.getTree", {"collection_id" => "42116005-72157626676063142", "user_id" => "42137335@N07"})["collections"]["collection"][0]

project_description = collection["description"]

sets = collection["set"].map do |set|
  id = set["id"]
  
  resp = get_flickr "flickr.photosets.getPhotos", "photoset_id" => id, "extras" => "url_t,url_l"
  photos = resp["photoset"]["photo"]
  
  resp = get_flickr "flickr.photosets.getInfo", "photoset_id" => id
  description = resp["photoset"]["description"]["_content"]
  
  {
    "photos" => photos,
    "description" => description
  }
end

data = {
  "project_description" => project_description,
  "sets" => sets
}

puts data.to_json