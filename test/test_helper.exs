Application.ensure_all_started(:ecto_sql)
Application.ensure_all_started(:backend)

Mix.Task.run("ecto.create", ["--quiet"])
Mix.Task.run("ecto.migrate", ["--quiet"])

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Backend.Repo, :manual)
