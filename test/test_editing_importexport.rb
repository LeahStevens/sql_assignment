require_relative 'helper'

class TestEditingExportsImports < ExportsImportsTest
  def test_updating_a_record_that_exists
    exportsimports = ExportsImports.new(country: "China", year: 2013, month: 1, type: 1, amount: 2342)
    exportsimports.save
    countryid = exportsimports.countryid
    command = "./tradedata edit --country.id #{country.id} --country China --year 2013 --month 1 --type 1 --amount 2342"
    expected = "ExportsImports #{countryid} is now China, 2013, 1, 1, with 2342."
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistant_record
    command = "./tradedata edit --countryid 999999999999999 --country China --year 2013 --month 1 --type 1 --amount 2342"
    expected = "ExportsImports 999999999999999 couldn't be found."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_no_changes
    exportsimports = ExportsImports.new(country: "China", year: 2013, month: 1, type: 1, amount: 2342)
    exportsimports.save
    countryid = exportsimports.countryid
    command = "./tradedata edit --countryid #{countryid} --country China --year 2013 --month 1 --type 1 --amount 2342"
    expected = "ExportsImports #{countryid} is now China, 2013, 1, 1, with 2342."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_bad_data
    skip
    exportsimports = ExportsImports.new(country: "China", year: 2013, month: 1, type: 1, amount: 2342)
    exportsimports.save
    countryid = exportsimports.countryid
    command = "./tradedata edit --countryid #{countryid} --country China --year asf --month 1 --type 1 --amount 2342"
    expected = "ExportsImports #{countryid} can't be updated.  Year must be a number."
    assert_command_output expected, command
  end

  def test_attempting_to_update_partial_data
    skip
    exportsimports = ExportsImports.new(country: "China", year: 2013, month: 1, type: 1, amount: 2342)
    exportsimports.save
    countryid = exportsimports.countryid
    command = "./tradedata edit --countryid #{countryid} --country China"
    expected = "ExportsImports #{countryid} is now China, 2013, 1, 1, with 2342."
    assert_command_output expected, command
  end
end