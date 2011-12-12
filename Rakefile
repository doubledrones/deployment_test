begin
  require 'echoe'
rescue LoadError
  abort "You'll need to have `echoe' installed to use deployment_test's Rakefile"
end

require "./lib/deployment_test/version"

version = DeploymentTest::Version::STRING.dup
if ENV['SNAPSHOT'].to_i == 1
  version << "." << Time.now.utc.strftime("%Y%m%d%H%M%S")
end

Echoe.new('deployment_test', version) do |p|
  p.changelog        = "CHANGELOG.rdoc"

  p.author           = "Marcin Nowicki"
  p.email            = "pr0d1r2@gmail.com"
  p.summary          = "Gem to perform common deployment testing"
  p.url              = "https://github.com/doubledrones/deployment_test"

  p.need_zip         = true

  p.dependencies     = ["pg >=0.11.0"]
end
