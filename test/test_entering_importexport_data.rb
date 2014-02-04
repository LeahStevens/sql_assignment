require_relative 'helper'

class TestingEnteringExportsImports < ExportsImportsTest

  def test_user_is_presented_with_countries_list
    country1 = Country.find_or_create("China")
    country2 = Country.find_or_create("India")
    country3 = Country.find_or_create("Australia")
    shell_output = ""
    IO.popen('./tradedata add China --year 2014 --month 01 --type e --amount 23435 --environment test', 'r+') do |pipe|
      pipe.puts "2"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
      "Choose a country:",
      "1. Australia",
      "2. China",
      "3. India"
  end

  def test_user_chooses_country
    country1 = Country.find_or_create("China")
    country2 = Country.find_or_create("India")
    country3 = Country.find_or_create("Australia")
    shell_output = ""
    IO.popen('./tradedata add China --year 2014 --month 01 --type e --amount 23435 --environment test', 'r+') do |pipe|
      pipe.puts "2"
      shell_output = pipe.read
    end
    expected = "A country named China, with the year 2014, month 01, type 3, and amount 23435 was created."
    assert_in_output shell_output, expected
  end

  def test_user_skips_entering_country
    country3 = Country.find_or_create("Australia")
    shell_output = ""
    IO.popen('./tradedata add China --year 2014 --month 01 --type e --amount 23435 --environment test', 'r+') do |pipe|
      pipe.puts ""
      shell_output = pipe.read
    end
    expected = "A country named China, with the year 2014, month 01, type 3, and amount 23435 was created."
    assert_in_output shell_output, expected
  end

  def test_country_information_is_printed
    command = "./tradedata add China --year 2014 --month 01 --type e --amount 23435"
    expected = "A country named China, with the year 2014, month 01, type 3, and amount 23435"
    assert_command_output expected, command
  end

  def test_valid_country_information_gets_saved
    execute_popen("./tradedata add China --year 2014 --month 01 --type e --amount 23435 --environment test")
    database.results_as_hash = false
    results = database.execute("select country, year, month, type, amount from ExportsImports")
    expected = ["China", 2014, 01, "e", 23435]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from ExportsImports")
    assert_equal 1, result[0][0]
  end

  def test_invalid_country_information_does_not_get_saved
    `./tradedata add China --year 2014`
    result = database.execute("select count(id) from ExportsImports")
    assert_equal 0, result[0][0]
  end

  def test_for_missing_year
    command = "./tradedata add China --month 01 --type e --amount 23435"
    expected = "You must provide the year for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_missing_month
    command = "./tradedata add China --year 2014 --type e --amount 23435"
    expected = "You must provide the year for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_missing_type
    command = "./tradedata add China --year 2014 --month 1 --amount 23435"
    expected = "You must provide the year for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_missing_amount
    command = "./tradedata add China --year 2014 --month 1 --type e"
    expected = "You must provide the year for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_all_entries_blank
    command = "./tradedata add China"
    expected = "You must provide the year and month and type and amount for the country you are adding."
    assert_command_output expected, command
  end

  def test_for_missing_country
    command = "./tradedata add"
    expected = "You must provide the name of the country you are adding.\nYou must provide the year, month, type, and amount for the country you are adding."
    assert_command_output expected, command
  end
end
