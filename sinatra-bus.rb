require 'sinatra'
require 'net/http'
require 'base64'
require 'uri'

def callRTPI(params, param_symbol, url)
	content_type :json
	uriparams = {:format => "json", :operator => "bac"}
	uriparams[param_symbol] = params[:number]
	uri = URI(url)
	uri.query = URI.encode_www_form(uriparams)
	puts uri.to_s
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Get.new(uri.request_uri)
	request.basic_auth "username", "password" #not the real ones obviously :P
	response = http.request request
	response.body
end

get '/bus/stop/:number' do
	callRTPI(params, :stopid, "http://www.dublinked.ie/cgi-bin/rtpi/realtimebusinformation")
end

get '/bus/route/:number' do
	callRTPI(params, :routeid, "http://www.dublinked.ie/cgi-bin/rtpi/routeinformation")
end

get '/location/stop/:number' do
	callRTPI(params, :stopid, "http://www.dublinked.ie/cgi-bin/rtpi/busstopinformation")
end

# These two methods are used for debugging only and won't be used
# or available in a production environment
get '/test-api.html' do
	File.read('test-api.html')
end

get '/qml/dublin-bus-api.js' do
	File.read('qml/dublin-bus-api.js')
end
