require_relative 'helper'


class TestSearchingCountries < ExportsImportsTest
  def test_search_returns_relevant_results
    ExportsImports.create(country: "China", year: 2014, month: 01, type: "e", amount: 23435)
    ExportsImports.create(country: "China", year: 2015, month: 01. type: "i", amount: 78239)
    ExportsImports.create(country: "France", year: 2014, month: 05, type: "i", amount: 9384)

    shell_output = ""
    IO.popen('./tradedata search --environment test', 'r+') do |pipe|
      pipe.puts("China")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "China", "China"
    assert_not_in_output shell_output, "France"
  end
end


