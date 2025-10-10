# Top.gg Ruby SDK

The community-maintained Ruby library for Top.gg.

## Chapters

- [Installation](#installation)
- [Setting up](#setting-up)
- [Usage](#usage)
  - [API v1](#api-v1)
    - [Getting your project's vote information of a user](#getting-your-projects-vote-information-of-a-user)
    - [Posting your bot's application commands list](#posting-your-bots-application-commands-list)
  - [API v0](#api-v0)
    - [Getting a bot](#getting-a-bot)
    - [Getting several bots](#getting-several-bots)
    - [Getting your project's voters](#getting-your-projects-voters)
    - [Check if a user has voted for your project](#check-if-a-user-has-voted-for-your-project)
    - [Getting your bot's statistics](#getting-your-bots-statistics)
    - [Posting your bot's statistics](#posting-your-bots-statistics)
    - [Automatically posting your bot's statistics every few minutes](#automatically-posting-your-bots-statistics-every-few-minutes)
    - [Checking if the weekend vote multiplier is active](#checking-if-the-weekend-vote-multiplier-is-active)
    - [Generating widget URLs](#generating-widget-urls)
  - [Webhooks](#webhooks)
    - [Being notified whenever someone voted for your project](#being-notified-whenever-someone-voted-for-your-project)

## Installation

```sh
$ gem install topgg
```

## Setting up

### API v1

> **NOTE**: API v1 also includes API v0.

```rb
require "topgg"

client = V1Topgg.new(ENV["TOPGG_TOKEN"])
```

### API v0

```rb
require "topgg"

client = Topgg.new(ENV["TOPGG_TOKEN"])
```

## Usage

### API v1

#### Getting your project's vote information of a user

```rb
vote = client.vote("661200758510977084")
```

#### Posting your bot's application commands list

##### Discordrb

```rb
commands = bot.rest.api.get_global_application_commands(bot.application_id).to_json

client.post_commands(commands)
```

##### Raw

```rb
commands = "[{\"options\":[],\"name\":\"test\",\"name_localizations\":null,\"description\":\"command description\",\"description_localizations\":null,\"contexts\":[],\"default_permission\":null,\"default_member_permissions\":null,\"dm_permission\":false,\"integration_types\":[],\"nsfw\":false}]"

client.post_commands(commands)
```

### API v0

#### Getting a bot

```rb
bot = client.get_bot("264811613708746752")
```

#### Getting several bots

```rb
bots = client.search_bot({ sort: "id", limit: 50, offset: 0 })

for bot in bots.results do
  puts bot.username
end
```

#### Getting your project's voters

##### First page

```rb
voters = client.votes

for voter in voters.results do
  puts voter.username
end
```

##### Subsequent pages

```rb
voters = client.votes(2)

for voter in voters.results do
  puts voter.username
end
```

#### Check if a user has voted for your project

```rb
has_voted = client.voted?("8226924471638491136")
```

#### Getting your bot's statistics

```rb
stats = client.get_stats
```

#### Posting your bot's statistics

```rb
client.post_stats(bot.server_count)
```

#### Automatically posting your bot's statistics every few minutes

With Discordrb:

```rb
require "discordrb"

bot = Discordrb::Bot.new(token: env["BOT_TOKEN"], intents: [:servers])

bot.ready do |event|
  client.auto_post_stats(bot)
  
  puts("Bot is now ready!")
end

bot.run
```

#### Checking if the weekend vote multiplier is active

```rb
is_weekend = client.is_weekend?
```

#### Generating widget URLs

##### Large

```rb
widget_url = Dbl::Widget.large(:discord_bot, "574652751745777665")
```

##### Votes

```rb
widget_url = Dbl::Widget.votes(:discord_bot, "574652751745777665")
```

##### Owner

```rb
widget_url = Dbl::Widget.owner(:discord_bot, "574652751745777665")
```

##### Social

```rb
widget_url = Dbl::Widget.social(:discord_bot, "574652751745777665")
```

### Webhooks

#### Being notified whenever someone voted for your project

##### Ruby on Rails

In your `config/application.rb`:

```rb
module MyServer
  class Application < Rails::Application
    # ...

    config.middleware.use Dbl::Webhook,
    type: Dbl::Webhook::VOTE,
    path: "/votes",
    auth: ENV["MY_TOPGG_WEBHOOK_SECRET"] do |vote|
      Rails.logger.info "A user with the ID of #{vote.voter_id} has voted us on Top.gg!"
    end
  end
end
```

##### Sinatra

```rb
use Dbl::Webhook,
type: Dbl::Webhook::VOTE,
path: "/votes",
auth: ENV["MY_TOPGG_WEBHOOK_SECRET"] do |vote|
  puts "A user with the ID of #{vote.voter_id} has voted us on Top.gg!"
end
```