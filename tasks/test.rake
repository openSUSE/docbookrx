#
# run "testsuite"
#
# 1. docbookxml -> daps -> html
# 2. docbookxml -> docbookrx -> asciidoctor -> docbookxml -> daps -> html
#
# => compare both results
#

task :test => [:daps, :asciidoctor] do
  puts "Now compare"
end

        