require_relative 'helper'

class Testing < exportsImportsTest
  def test_country_information_is_printed
    command = "./exportsImports add China --year 2014 --month 1 --type e --amount 23435"
    expected = "A country named China, with the year 2014, month 1, type 3, and amount 23435"
    assert_command_output expected, command
  end

  def test_valid_country_information_gets_saved
    `./exportsImports add China --year 2014 --month 1 --type e --amount 23435 --environment test`
    results = database.execute("select country, year, month, type, amount from exportsImports")
    expected = ["China", 2014, 1, "e", 23435]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from exportsImports")
    assert_equal 1, result[0][0]
  end

  def test_invalid_country_information_does_not_get_saved
    `./exportsImports add China --year 2014`
    result = database.execute("select count(id) from exportsImports")
    assert_equal 0, result[0][0]
  end

  def test_for_missing_year
    command = "./exportsImports add China --month 1 --type e --amount 23435"
    expected = "You must provide the year for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_missing_month
    command = "./exportsImports add China --year 2014 --type e --amount 23435"
    expected = "You must provide the year for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_missing_type
    command = "./exportsImports add China --year 2014 --month 1 --amount 23435"
    expected = "You must provide the year for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_missing_amount
    command = "./exportsImports add China --year 2014 --month 1 --type e"
    expected = "You must provide the year for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_all_entries_blank
    command = "./exportsImports add China"
    expected = "You must provide the year and month and type and amount for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_missing_country
    command = "./exportsImports add"
    expected = "You must provide the name of the country you are adding.\nYou must provide the year, month, type, and amount for the country you are adding."
    assert_command_output expected, command
  end
end
