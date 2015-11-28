# Written by @Netuoso

class TpbSlackWrapper
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
    when 'download'
      download(ARGV[1])
    when 'info'
      info
    end
  end

  def recent
    results = {}
    url = URI::encode(@base_url + '/recent')
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
      @options[:page] = opt[1..-1].delete("\s") if opt.first == 'p'
      @options[:ordering] = opt[1..-1].delete("\s") if opt.first == 'o'
      @options[:type] = opt[1..-1].delete("\s") if opt.first == 't'
    end if opts.present?
    url = URI::encode(@base_url + "/top/#{@options[:type]}")
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
      @options[:page] = opt[1..-1].delete("\s") if opt.first == 'p'
      @options[:ordering] = opt[1..-1].delete("\s") if opt.first == 'o'
      @options[:type] = opt[1..-1].delete("\s") if opt.first == 't'
    end if opts.present?
    url = URI::encode(@base_url + "/search/#{query}/#{@options[:page]}/#{@options[:ordering]}/#{@options[:type]}")
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

  def download(torrent_id)
    # TODO: Enable downloading?
    p "Not yet implemented"
  end

  def info
    puts "ThePirateBay Unofficial Ruby API written by @Netuoso"
  end
end