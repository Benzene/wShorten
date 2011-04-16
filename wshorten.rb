require 'sinatra'

require_relative 'lib/db-config'

baseurl = "http://rdr.leukensis.org/"

get '/' do
	"This is an url-shortener. Try " + baseurl + "a/[yoururl]"
end

get '/a/*' do
	baseurl + "r/" + UrlRedir.newurl(params[:splat][0]).to_s
end

get '/r/:id' do
	url = UrlRedir.get(params[:id])
	if url != nil
		url.incr_clicks
		redirect to(url.targeturl), 303
	end
end

get '/c/:id' do
	url = UrlRedir.get(params[:id])
	url.clicks.to_s unless url == nil
end

get '/l' do
	s = "Urls in memory :<br />"
	UrlRedir.all.each do |u|
		s += baseurl + "r/" + u.id.to_s + " -> " + u.targeturl + " (" + u.clicks.to_s + " clicks)<br />"
	end
	s
end

