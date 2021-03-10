# NarouEx
## What is this?

This library provides client of [the Syosetsuka-ni-Narou API](https://dev.syosetu.com/man/api/) for Elixir developers.

## Getting started

If you are interested in some author in Syo-setsuka-ni-Narou and handle their work descriptions in your app. You have to know their user ID.
It can be seen in the author's page(マイページ). Its URL tells us what we want.

`https://mypage.syosetu.com/#{user ID is here!}/`

Now, we can fetch their work descriptions. In your app, write like this:

**CAUTION: This operation will send request to Syosetsuka-ni-Narou website. Before do this, please read manual of Narou API and comply its restriction.**

```elixir
# User ID is 0, in this example.
user_id = 0
work_descriptions = NarouEx.API.fetch_by_user(user_id)
```

Then, we got struct represents a request from Narou API.

If you are interested in multiple authors, attribute above can be a list.

```elixir
# User IDs are 0, in this example.
user_ids = [0, 1, 2]
work_descriptions = NarouEx.API.fetch_by_user(user_ids)
```

Enjoy!

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `narou_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:narou_ex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/narou_ex](https://hexdocs.pm/narou_ex).

