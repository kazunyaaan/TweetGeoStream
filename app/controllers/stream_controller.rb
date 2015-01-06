require 'reloader/sse'

class StreamController < ApplicationController
  include ActionController::Live

  def index
  end

  def stream
    tweets = Queue.new

    twitter_thread = Thread.new do
      client = TweetStream::Client.new
      client.locations(122.87,24.84, 153.01,46.80) do |tweet|
        tweets.push(tweet)
      end
    end
    
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Reloader::SSE.new(response.stream)

    begin
      loop do
        t = tweets.pop
        id        = t.user.screen_name
        tweet     = t.text
        timestamp = t.created_at.dup.localtime("+09:00")
        place     = t.place.name
        
        unless t.geo.coordinates.nil? then
          lat   = format("%.4f", t.geo.coordinates[0])
          lng   = format("%.4f", t.geo.coordinates[1])
        end
        
        sse.write({ :id => id,
                    :place => place,
                    :lat => lat,
                    :lng => lng,
                    :tweet => tweet,
                    :timestamp => timestamp
        })
        #sse.write( "#{id}" )
      end
    rescue IOError
      puts "IOError"
    ensure
      twitter_thread.kill
      sse.close
    end
  end
end
