#!/usr/bin/env ruby
# This file handles the user interaction with api_base.rb
# This is intended to be used in conjunction with Slack Real-time Messaging API
# Make sure to set SLACK_API_TOKEN environment variable to that of your bot
# Written by @Netuoso

require './api_base'
require './tpb_slack_wrapper'

require 'rubygems'
require 'optparse'
require 'open-uri'
require 'nokogiri'
require 'restclient'
require 'http-cookie'
require 'torrent-ruby'
require 'slack-ruby-bot'

module ApiSlack
  class Bot < SlackRubyBot::App
  end

  class Recent < SlackRubyBot::Commands::Base
    command 'recent' do |client, data, _match|
      torrents = TpbSlackWrapper.new.process('recent')
      if torrents.empty?
        results = "`0 torrents found matching criteria.`"
      else
        results = "```"
        torrents.each_with_index do |torrent, index|
          results << "Info: " + torrents["torrent_#{index+1}"][:info] + "\nLink: " + torrents["torrent_#{index+1}"][:magnet] + "\n\n"
        end
        results << "```"
      end
      client.message text: results, channel: data.channel
      client.message text: "`Listed #{torrents.count} torrents.`", channel: data.channel if torrents
    end
  end

  class Top < SlackRubyBot::Commands::Base
    # TODO: Clean this logic up to prevent sending huge messages to Slack
    command 'top' do |client, data, _match|
      options = _match['expression'].split('-')[1..-1]
      puts options if options
      torrents = TpbSlackWrapper.new.process('top', opts: options)
      if torrents.empty?
        results = "`0 torrents found matching criteria.`"
      else
        results = "```"
        results_2 = "```"
        results_3 = "```"
        results_4 = "```"
        torrents.each_with_index do |torrent, index|
          results << "Info: " + torrents["torrent_#{index+1}"][:info] + "\nLink: " + torrents["torrent_#{index+1}"][:magnet] + "\n\n" if index <= 30
          results_2 << "Info: " + torrents["torrent_#{index+1}"][:info] + "\nLink: " + torrents["torrent_#{index+1}"][:magnet] + "\n\n" if index > 30 && index <= 60
          results_3 << "Info: " + torrents["torrent_#{index+1}"][:info] + "\nLink: " + torrents["torrent_#{index+1}"][:magnet] + "\n\n" if index > 60 && index <= 90
          results_4 << "Info: " + torrents["torrent_#{index+1}"][:info] + "\nLink: " + torrents["torrent_#{index+1}"][:magnet] + "\n\n" if index > 90 && index <= 120
        end
        results << "```"
        results_2 << "```"
        results_3 << "```"
        results_4 << "```"
      end
      client.message text: results, channel: data.channel if results
      client.message text: results_2, channel: data.channel unless results_2 == "``````"
      client.message text: results_3, channel: data.channel unless results_3 == "``````"
      client.message text: results_4, channel: data.channel unless results_4 == "``````"
      client.message text: "`Listed #{torrents.count} torrents.`", channel: data.channel if torrents
    end
  end

  class Search < SlackRubyBot::Commands::Base
    command 'search' do |client, data, _match|
      search_string = _match['expression'].split('-')[0]
      options = _match['expression'].split('-')[1..-1]
      puts options if options
      torrents = TpbSlackWrapper.new.process('search', query: search_string.strip, opts: options)
      if torrents.empty?
        results = "`0 torrents found matching criteria.`"
      else
        results = "```"
        torrents.each_with_index do |torrent, index|
          results << "Info: " + torrents["torrent_#{index+1}"][:info] + "\nLink: " + torrents["torrent_#{index+1}"][:magnet] + "\n\n"
        end
        results << "```"
      end
      client.message text: results, channel: data.channel
      client.message text: "`Listed #{torrents.count} torrents.`", channel: data.channel if torrents
    end
  end
end

ApiSlack::Bot.instance.run
