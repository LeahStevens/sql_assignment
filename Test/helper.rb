def assert_command_output expected, assert_command_output
  actual = `#{command}`.strip
  assert_equal expected, actual
end