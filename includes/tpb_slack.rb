# Written by @Netuoso

class TpbSlack
  def initialize
    @options = {page: '0', ordering: Constants::ORDERING.default, type: Constants::CATEGORIES.default}
    @base_url = Constants::BASE_URL
  end

  def process(action, query: "", opts: [])
    case action
    when 'recent'
      recent
    when 'top'
      top(opts)
    when 'search'
      search(query, opts)
    when 'info'
      info
    when 'help'
      help
    end
  end

  def recent
    results = {}
    url = URI.encode(@base_url + '/recent')
    page = Nokogiri::HTML(RestClient.get(url))
    torrent_rows = page.css('tr')[1...-1]
    torrent_rows.each_with_index do |result, index|
      results.merge!({"torrent_#{index+1}" => {info: result.text.lstrip.gsub("\t", "").gsub("\n", " "), magnet: ""}})
    end if torrent_rows
    links = page.css("a[title='Download this torrent using magnet']").select { |link| link['title'] = 'Download this torrent using magnet' }
    links[0...torrent_rows.count].each_with_index do |link, index|
      results["torrent_#{index+1}"][:magnet] = link['href']
    end if torrent_rows
    results
  end

  def top(opts=[])
    results = {}
    opts.each do |opt|
      @options[:page] = opt[1..-1].delete("\s") if opt[0] == 'p'
      @options[:ordering] = opt[1..-1].delete("\s") if opt[0] == 'o'
      @options[:type] = opt[1..-1].delete("\s") if opt[0] == 't'
    end if !opts.empty?
    url = URI.encode(@base_url + "/top/#{@options[:type]}")
    page = Nokogiri::HTML(RestClient.get(url))
    torrent_rows = page.css('tr')[1...-1]
    torrent_rows.each_with_index do |result, index|
      results.merge!({"torrent_#{index+1}" => {info: result.text.lstrip.gsub("\t", "").gsub("\n", " "), magnet: ""}})
    end if torrent_rows
    links = page.css("a[title='Download this torrent using magnet']").select { |link| link['title'] = 'Download this torrent using magnet' }
    links[0...torrent_rows.count].each_with_index do |link, index|
      results["torrent_#{index+1}"][:magnet] = link['href']
    end if torrent_rows
    results
  end

  def search(query, opts=[])
    results = {}
    opts.each do |opt|
      @options[:page] = opt[1..-1].delete("\s") if opt[0] == 'p'
      @options[:ordering] = opt[1..-1].delete("\s") if opt[0] == 'o'
      @options[:type] = opt[1..-1].delete("\s") if opt[0] == 't'
    end if !opts.empty?
    url = URI.encode(@base_url + "/search/#{query}/#{@options[:page]}/#{@options[:ordering]}/#{@options[:type]}")
    page = Nokogiri::HTML(RestClient.get(url))
    torrent_rows = page.css('tr')[1...-1]
    torrent_rows.each_with_index do |result, index|
      results.merge!({"torrent_#{index+1}" => {info: result.text.lstrip.gsub("\t", "").gsub("\n", " "), magnet: ""}})
    end if torrent_rows
    links = page.css("a[title='Download this torrent using magnet']").select { |link| link['title'] = 'Download this torrent using magnet' }
    links[0...torrent_rows.count].each_with_index do |link, index|
      results["torrent_#{index+1}"][:magnet] = link['href']
    end if torrent_rows
    results
  end

  def info
    "Ruby-based Slack Bot for interacting with <https://thepiratebay.la>, written by @Netuoso"
  end

  def help
    {categories: Constants::CATEGORIES, ordering: Constants::ORDERING}
  end
end