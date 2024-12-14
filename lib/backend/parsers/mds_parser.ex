defmodule Backend.Parsers.MdsParser do
  @moduledoc """
  MdsParser used to invoke haskell parser
  """

  @parser_path Path.expand("mds-converter/runnable/parser", File.cwd!())

  def parse(markdown) do
    args = ["-c", markdown]

    case System.cmd(@parser_path, args) do
      {output, 0} -> {:ok, output}
      {error, status} -> {:error, "Process failed with status #{status}: #{error}"}
    end
  end
end
