### Ruby-based Slack Bot for Interacting with ThePirateBay Torrent Search Engine

##### Before getting started (Recommended)

1. Create an account on [Heroku](http://www.heroku.com)
2. Install the heroku toolbelt
 - Linux: `apt-get install heroku`
 - OSX: `brew install heroku`
 - Deprecated: `gem install heroku`
3. Create auth file for Heroku toolbelt
 - `heroku apps`
 - Then follow the login prompts

##### Getting started

1. Clone this repo
2. `cd tpb_slack_ruby`
3. `bundle install`
4. `heroku create {{APP_NAME}}`
 - {{APP_NAME}} is optional. Heroku will choose a random name if ommitted
5. `git push heroku`
6. Create an Outgoing Webhook and configure the URL to point to `https://{{YOUR_HEROKU_APP_NAME}}.herokuapp.com/gateway`
7. Use your trigger word, followed by `help` or `info` to verify the bot is running
 - You can also visit `https://{{YOUR_HEROKU_APP_NAME}}.herokuapp.com/status` and check for `server online`

##### Defaults

1. Ordering: default ordering is by seeders and is descending.
 - Specify ordering with -o ORDERING_VALUE (See `help` for these numerical values)

##### Commands and options

1. `recent` (ordered by seeders)
2. `top -t TYPE [-o ORDERING]`
3. `search {{TORRENT_NAME}} [-p PAGE, -t TYPE, -o ORDERING]`
4. `info`
5. `help`

##### Examples

1. `tpb: recent`
 - List the 30 most recent torrents
2. `tpb: top -t 200`
 - List the top 99 torrents for type 'video'
3. `tpb: search fight club -t 207`
 - List the torrents relating to 'fight club' of type 'Video (HD Movies)'.
 - (If no page is specified, returns first page. Pages start at 0.)

##### Further information

- All used constants can be found in `includes/constants.rb`
- If you wish to contribute, see contributions section
- Visit http://www.techflavor.com for more information about my work

##### Contributions

This project is open source and distributed under the MIT License.
Thus, contributions are welcome. Feel free to clone this repository to submit issues and pull requests.
