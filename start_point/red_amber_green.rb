
lambda { |stdout,stderr,status|
  output = stdout + stderr
  # JUnitCore says OK, and exits zero, for a run it was handed no test classes
  # for, which is what a kata with no class named *Test* gives it. The count is
  # what keeps that out of green: nothing ran, so nothing was proved.
  return :amber if /^OK \(0 tests\)$/.match(output)
  return :green if status === 0
  # JUnit counts an exception as a failure, so its own counts cannot tell an
  # assertion that failed from code that broke on the way to one. What can is
  # the throwable printed under each failure, on the line after the one naming
  # the test. This image can produce three spellings of a failed assertion:
  # java.lang.AssertionError from assertTrue, org.junit.ComparisonFailure from
  # assertEquals, and groovy's power assertion, which prints its diagram under
  # "Assertion failed:" and names no class at all.
  thrown = output.scan(/^\d+\) .*\n(.*)$/).flatten
  return :amber if thrown.empty?
  return :red if thrown.all? { |t| t =~ /AssertionError|ComparisonFailure|^Assertion failed:/ }
  :amber
}
