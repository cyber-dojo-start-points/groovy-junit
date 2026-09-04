
# Each test run starts two JVMs, one to compile and one to run the tests,
# and starting them is most of the wait rather than a part of it. The image
# holds an AOT cache for the compiler, recorded when it was built, holding the
# classes that JVM loads in the form the JVM wants them; reading it back costs
# a fraction of loading them again.
#
# The JVM that runs the tests has no cache. Its classpath starts with the
# directory holding the classes groovyc has just written, and a cache cannot be
# recorded from a classpath naming a non-empty directory.
#
# Your own classes are in neither JVM's cache, so editing them cannot
# invalidate one.
#
# The collector is named rather than left to the JVM to choose. A JVM that lives
# for a fraction of a second has nothing to gain from a concurrent collector,
# and replaying a cache under the one it picks by default is not reliable.
GROOVYC_JVM_OPTS=()
GROOVYC_JVM_OPTS+=(-XX:TieredStopAtLevel=1)        # a run is milliseconds; later tiers never repay
GROOVYC_JVM_OPTS+=(-XX:+UseSerialGC)               # see above
GROOVYC_JVM_OPTS+=(-XX:AOTCache=/aot/groovyc.aot)  # the compiler's own classes

TEST_JVM_OPTS=()
TEST_JVM_OPTS+=(-XX:TieredStopAtLevel=1)  # as above, for the JVM running the tests
TEST_JVM_OPTS+=(-XX:+UseSerialGC)         # as above

# Every .groovy file is compiled, however deep it sits, so a file you add is
# checked whether or not anything else refers to it yet. One that will not
# compile stops the run and says why, rather than being passed over in silence.
SOURCES=$(find . -name '*.groovy')

# groovyc takes its JVM's options through JAVA_OPTS, as one string, which is
# what [*] spells. java takes its own directly.
#
# -d . puts each class file where its package says it belongs, rather than
# beside its source. A test in a subdirectory is then where the runner looks for
# it, including one whose file declares no package at all.
if JAVA_OPTS="${GROOVYC_JVM_OPTS[*]}" groovyc -d . ${SOURCES}; then
  # Your test classes, read from the class files just written so that a test in
  # a subdirectory is run too. JUnit does not go looking for tests, so a class
  # of yours is run only if Test appears in its name; one named otherwise still
  # has to compile, but its tests will not run.
  #
  # A closure compiles to a class of its own, named with a $_ after the class
  # holding it, and handing one of those to the runner reports it as a test
  # class with no tests in it, so those are left out. A named inner class has no
  # underscore there, so it is still run.
  TESTS=$(find . -name '*Test*.class' ! -name '*$_*' \
    | sed -e 's|^\./||' -e 's|\.class$||' -e 's|/|.|g')
  java "${TEST_JVM_OPTS[@]}" -cp .:$(ls /groovy/*.jar | xargs | sed -e 's/ /:/g') \
    org.junit.runner.JUnitCore \
      ${TESTS}
else
  # A kata that will not compile has to say so through the status it exits with,
  # not only in what the compiler printed above.
  exit 1
fi
