use Mix.Config

config :chavez,
       Chavez.Repo,
       username: System.get_env("DATABASE_USER"),
       password: System.get_env("DATABASE_PASS"),
       database: System.get_env("DATABASE_NAME"),
       hostname: System.get_env("DATABASE_HOST"),
       pool_size: 15

port = String.to_integer(System.get_env("PORT") || "8080")
config :chavez, ChavezWeb.Endpoint,
       cache_static_manifest: "priv/static/cache_manifest.json",
       server: true,
       root: ".",
       http: [
         port: port
       ],
       url: [
         host: System.get_env("HOSTNAME"),
         port: port
       ],
       root: ".",
       secret_key_base: System.get_env("SECRET_KEY_BASE"),
       check_origin: [System.get_env("CHECK_ORIGIN")],
       live_view: [
         signing_salt: System.get_env("LIVE_VIEW_SALT")
       ]
