require "sinatra"
require "net/http"
require "uri"
require "json"
require "ostruct"

set :port, 8080
set :bind, '0.0.0.0'

helpers do
  def tracks
    uri = URI::HTTP.build(host: ENV['TRACKS_HOST'], port: ENV['TRACKS_PORT'], path: '/tracks')
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    JSON.parse(response.body, object_class: OpenStruct)
  end

  def laptimes(id)
    uri = URI::HTTP.build(host: ENV['LAPTIMES_HOST'], port: ENV['LAPTIMES_PORT'], path: '/laptimes/'+id)
    http = Net::HTTP.new(uri.host, uri.port)
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    JSON.parse(response.body, object_class: OpenStruct)
  end

  def get_fastest_laptime(data={})
    (1..17).map {|i| data[i.to_s.to_sym].to_f}.delete_if {|i| i == 0.0}.min
  end
end

get "/" do
  @id = "hangtown"
  erb :index
end

get "/tracks/:id" do
  @id = params[:id]
  erb :index
end
