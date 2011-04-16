# The model representing a sorted url redirection

class UrlRedir
	include DataMapper::Resource
	
	property :id, Serial
	property :date, DateTime, :required => true
	property :targeturl, String, :required => true
	property :clicks, Integer, :required => true
	
	def incr_clicks
		self.clicks += 1
		self.save
	end

	def self.newurl(url)
		p = UrlRedir.new( :date => Time.now, 
			:targeturl => url, 
			:clicks => 0)
		begin
			p.save
		rescue
			puts "Save failed. Illegal blog contents"
		end
		p.id
	end
end

