# Top.gg Ruby SDK

The community-maintained Ruby library for Top.gg.

## Installation

```sh
$ gem install topgg
```

## Setting up

```rb
require "topgg"

client = Topgg.new(ENV["TOPGG_TOKEN"])
```

## Usage

### Getting a bot

```rb
bot = client.get_bot("264811613708746752")
```

### Getting several bots

```rb
bots = client.get_bots({ sort: "date", limit: 50, offset: 0 })

for bot in bots.results do
  puts bot.username
end
```

### Getting your bot's voters

#### First page

```rb
voters = client.get_votes

for voter in voters.results do
  puts voter.username
end
```

#### Subsequent pages

```rb
voters = client.get_votes(2)

for voter in voters.results do
  puts voter.username
end
```

### Check if a user has voted for your bot

```rb
has_voted = client.voted?("661200758510977084")
```

### Getting your bot's server count

```rb
stats = client.get_stats
server_count = client.server_count
```

### Posting your bot's server count

```rb
client.post_stats(bot.server_count)
```

### Automatically posting your bot's server count every few minutes

For Discordrb:

```rb
require "discordrb"

bot = Discordrb::Bot.new(token: env["BOT_TOKEN"], intents: [:servers])

bot.ready do |event|
  client.auto_post_stats(bot)
  
  puts "Bot is now ready!"
end

bot.run
```

### Checking if the weekend vote multiplier is active

```rb
is_weekend = client.is_weekend?
```

### Generating widget URLs

#### Large

```rb
widget_url = Dbl::Widget.large(:discord_bot, "574652751745777665")
```

#### Votes

```rb
widget_url = Dbl::Widget.votes(:discord_bot, "574652751745777665")
```

#### Owner

```rb
widget_url = Dbl::Widget.owner(:discord_bot, "574652751745777665")
```

#### Social

```rb
widget_url = Dbl::Widget.social(:discord_bot, "574652751745777665")
```