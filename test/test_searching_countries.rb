require_relative 'helper'
require 'sqlite3'

class TestSearchingCountries < ExportsImportTest
  def test_search_returns_relevant_results
    `./exportsImports add China --year 2014 --month 01 --type e --amount 23435`
    `./exportsImports add China --year 2015 --month 01 --type i --amount 78239`
    `./exportsImports add France --year 2014 --month 05 --type i --amount 9384`

    shell_output = ""
    IO.popen('./exportsImports search', 'r+') do |pipe|
      pipe.puts("China")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "China", "China"
    assert_not_in_output shell_output, "France"
  end
end