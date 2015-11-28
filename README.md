### Ruby-based Slack Bot for Interacting with ThePirateBay Torrent Search Engine

1. Clone this repo
2. `cd tpb_slack_ruby`
3. `bundle install`
4. Get your slack realtime messaging API token (*)
5. `SLACK_API_TOKEN={{YOUR_TOKEN_HERE}} ruby tpb_slack.rb

### Commands and options

1. `recent` (ordered by seeders)
2. `top -t TYPE [-o ORDERING]`
3. `search {{TORRENT_NAME}} [-p PAGE, -t TYPE, -o ORDERING]

### Examples

1. `botname: recent`
 - List the 30 most recent torrents
2. `botname: top -t 200`
 - List the top 99 torrents for type 'video'
3. `botname: search fight club -p 1`
 - List the second page of torrents relating to 'fight club'.
 - (If no page is specified, returns first page. Pages start at 0.)

### Further information

- All used constants can be found in constants.rb
- If you wish to contribute, see contributions section
- Visit http://www.techflavor.com for more information about my work

### Contributions

This project is open source and distributed under the MIT License.
Thus, contributions are welcome. Feel free to clone this repository to submit issues and pull requests.
