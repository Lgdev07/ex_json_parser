import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ex_json_parser, ExJsonParserWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "oBuDX4KG41ksr+k8zp3MPBhZ13srvnGs1eudGwQrT8K217lcv+qF44Hfpnypj/z/",
  server: false

# In test we don't send emails.
config :ex_json_parser, ExJsonParser.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
