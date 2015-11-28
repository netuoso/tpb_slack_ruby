# Written by @Netuoso

require 'rubygems'
require 'bundler'

Bundler.require

require_relative 'includes/tpb_slack_formatter'

configure :production, :development do
  SLACK_API_TOKEN = ENV['SLACK_API_TOKEN']
  Dotenv.load
  enable :logging
end

before /^(bot_response)/ do
  content_type :html, 'charset' => 'utf-8'
end

get '/status' do
  bot_response("Server online")
end

post '/gateway' do
  message = params[:text].gsub("#{params[:trigger_word]} ", '').strip
  action = message.split('-')[0].strip.split(' ')[0]
  query = message.split('-')[0].split(' ')[1..-1].join(' ')
  options = message.split('-')[1..-1]
  logger.info({action: action, query: query, opts: options})

  case action
    when 'recent'
      logger.info({recent_params: params})
      results = TpbSlackFormatter::Commands.new.recent
      bot_response(results)
    when 'top'
      logger.info({top_params: params})
      results = TpbSlackFormatter::Commands.new.top(opts: options)
      bot_response(results)
    when 'search'
      logger.info({search_params: params})
      results = TpbSlackFormatter::Commands.new.search(query: query, opts: options)
      bot_response(results)
    when 'download'
    when 'info'
      app_info = TpbSlack.new.process('info')
      bot_response(app_info)
    when 'help'
      help_info = TpbSlack.new.process('help')
      bot_response("Categories: #{help_info[:categories]}\nOrdering: #{help_info[:ordering]}")
  end
end

def bot_response(message)
  content_type :json
  {text: message}.to_json
end
