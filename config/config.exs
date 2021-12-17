import Config

config :url_shortener,
port: System.get_env("PORT"),
pool_size: 10
