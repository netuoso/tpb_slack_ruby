#!/usr/bin/env ruby
# This file handles the user interaction with api_base.rb
# This is intended to be used in conjunction with Slack Real-time Messaging API
# Make sure to set SLACK_API_TOKEN environment variable to that of your bot
# Written by @Netuoso

require_relative 'api_base'
require_relative 'tpb_slack'
require_relative 'constants'

require 'json'

module TpbSlackFormatter
  class Commands
    def recent
      torrents = TpbSlack.new.process('recent')
      process_torrents(torrents: torrents)
      @results
    end

    def top(opts: [])
      torrents = TpbSlack.new.process('top', opts: opts)
      process_torrents(torrents: torrents)
      @results
    end

    def search(query: "", opts: [])
      torrents = TpbSlack.new.process('search', query: query, opts: opts)
      process_torrents(torrents: torrents)
      @results
    end

    def process_torrents(torrents: {})
      if torrents.empty?
        @results = "0 torrents found matching criteria."
      else
        @results = ""
        torrents.each_with_index do |torrent, index|
          @results << "Info: " + torrents["torrent_#{index+1}"][:info] + "\nLink: " + torrents["torrent_#{index+1}"][:magnet] + "\n\n"
        end
        @results = paste(@results, count: torrents.count)
      end
    end

    def paste(results, count: 0)
      p = Pastie.create("#{'*' * 30}\nListing #{count} results matching critera\n#{'*' * 30}\n\n#{results}".chomp.chomp)
      p.raw_link
    end

    def create_gist(results, count: 0)
      # FIXME: NoMethodError - undefined method `map' for #<String:0x007f5d502fb7a0>: Line 62
      payload = {
        'description': "TPB Search Results",
        'public': true,
        'files': {
          'results.txt': {
            'content': "#{'*' * 30}\nListing #{count} results matching critera\n#{'*' * 30}\n\n#{results}".chomp.chomp
          }
        }
      }
      # The following line has an issue
      Net::HTTP.post_form(URI.parse('https://api.github.com/gists'), URI.encode_www_form(payload)).body
    end
  end
end

