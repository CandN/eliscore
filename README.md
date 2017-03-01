# Eliscore

Your scores in elixir with a flame of a phoenix.

## Environment setup

Make sure you have elixir installed - http://elixir-lang.org/install.html. For Homebrew:
`brew install elixir`.

Hex package manager (used by Phoenix):

`mix local.hex`

Install Phoenix package:

`mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez`


## Project setup

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Debugging

To use interactive console run server with: `iex -S mix phoenix.server` and trigger in the code:
```
require IEx
IEx.pry
```

## Deploying

If you have environment ready, just use bin/deploymator.sh on your prod machine.
