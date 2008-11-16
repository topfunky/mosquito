$: << 'lib'
$:.reject! { |e| e.include? 'TextMate' }

require 'rubygems'
require 'hoe'
require './lib/mosquito'

# Disable spurious warnings when running tests, ActiveMagic cannot stand -w
Hoe::RUBY_FLAGS.replace ENV['RUBY_FLAGS'] || "-I#{%w(lib test).join(File::PATH_SEPARATOR)}" + 
  (Hoe::RUBY_DEBUG ? " #{RUBY_DEBUG}" : '')

Hoe.new('Mosquito', Mosquito::VERSION) do |p|
  p.name = "mosquito"
  p.author = ["Geoffrey Grosenbach"] # TODO Add Julik ...
  p.description = "A library for writing tests for your Camping app."
  p.email = 'boss@topfunky.com'
  p.summary = "A Camping test library."
  p.changes = p.paragraphs_of('CHANGELOG', 0..1).join("\n\n")
  p.url = "http://mosquito.rubyforge.org"
  p.remote_rdoc_dir = '' # Release to root on rubyforge
  # We need that so that Hoe does not grab Camping's own distro tests
  p.test_globs = ['test/test_*.rb']
  p.rsync_args << ' --exclude=statsvn/'
  p.rdoc_pattern = /README|CHANGELOG|mosquito/
  p.clean_globs = ['**.log', 'coverage', 'coverage.data', 'test/test.log', 'email.txt']
  p.extra_deps = ['activerecord', 'activesupport', 'camping']
end

begin
  require 'rcov/rcovtask'
  desc "just rcov minus html output"
  Rcov::RcovTask.new do |t|
    t.test_files = FileList["test/test_*.rb"]
    t.verbose = true
  end

  desc 'Aggregate code coverage for unit, functional and integration tests'
  Rcov::RcovTask.new("coverage") do |t|
    t.test_files = FileList["test/test_*.rb"]
    t.output_dir = "coverage"
    t.verbose = true
    t.rcov_opts << '--aggregate coverage.data'
  end
rescue LoadError
end

require 'rake/testtask'


multicamp_tasks = Dir.glob(File.dirname(__FILE__) + '/test/camping-dist/camping-*/lib').sort.map do | path |
  distname = File.basename(File.dirname(path))
  libs = path[(File.dirname(__FILE__) + '/').length..-1]
  
  desc "Run tests with #{distname}"
  Rake::TestTask.new("test-with-#{distname}") do |t|
    t.libs << "test" << libs
    t.pattern = 'test/test_*.rb'
    t.verbose = true
  end
  "test-with-#{distname}"
end

desc "Run with multiple Camping versions"
task :multicamp => multicamp_tasks