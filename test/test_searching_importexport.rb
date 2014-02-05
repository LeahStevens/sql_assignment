require_relative 'helper'


class TestSearchingCountries < ExportsImportsTest
  def test_search_returns_relevant_results
    ExportsImports.create(year: 2014, month: 1, type: 2, amount: 23435)
    ExportsImports.create(year: 2015, month: 1, type: 1, amount: 78239)
    ExportsImports.create(year: 2014, month: 5, type: 1, amount: 9384)

    shell_output = ""
    IO.popen('./tradedata search --environment test', 'r+') do |pipe|
      pipe.puts(2014)
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, 2014, 2014
    assert_not_in_output shell_output, 2015
  end
end


