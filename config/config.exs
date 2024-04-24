import Config

config :school_project, School.Repo,
  database: Path.expand("../school_project#{Mix.env()}.db", Path.dirname(__ENV__.file)),
  pool_size: 5

config :school_project,
    ecto_repos: [School.Repo]
