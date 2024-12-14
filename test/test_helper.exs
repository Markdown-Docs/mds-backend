Application.ensure_all_started(:ecto_sql)
Application.ensure_all_started(:backend)

Mix.Task.run("ecto.create", ["--quiet"])
Mix.Task.run("ecto.migrate", ["--quiet"])

ExUnit.start()
# Code.require_file("support/channel_case.ex", __DIR__)
Code.require_file("support/data_case.ex", __DIR__)
Code.require_file("support/conn_case.ex", __DIR__)
Ecto.Adapters.SQL.Sandbox.mode(Backend.Repo, :manual)
