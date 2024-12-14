defmodule Backend.Parsers.MdsParserTest do
  use ExUnit.Case, async: true

  alias Backend.Parsers.MdsParser

  @parser_path Path.expand("mds-converter/runnable/parser", File.cwd!())

  setup do
    # Проверяем, существует ли парсер
    if File.exists?(@parser_path) do
      :ok
    else
      {:error, "Parser executable not found at #{@parser_path}"}
    end
  end

  test "parses valid content" do
    content = "# Test\n\nSome **bold** text"
    assert {:ok, html} = MdsParser.parse(content)
    assert html =~ "<!DOCTYPE html>\n<html>\n<head>\n<meta charset=\"UTF-8\">\n</head>\n<body>\n<h1 id=\"0cbc6611f5540bd0809a388dc95a615b\">Test</h1>\n<p>Some <strong>bold</strong> text</p>\n\n</body>\n</html>\n"
  end

  test "handles invalid content gracefully" do
    content = ""
    assert {:ok, html} = MdsParser.parse(content)
    assert html =~ "<body>" # Даже пустой контент должен возвращать корректный HTML
  end

  test "handles parser errors" do
    content = :binary.copy("a", 1_000_000) # Очень длинный ввод для потенциальной ошибки
    assert {:error, _} = MdsParser.parse(content)
  end
end
