require 'fileutils'

RSPEC_ARTIFACT = 'tmp/rspec_results.html'
JASMINE_ARTIFACT = 'tmp/jasmine_results.html'
CUKE_ARTIFACT = 'tmp/cucumber_results.html'
SIMPLECOV_ARTIFACT = 'coverage'

desc "Run all Continuous Integration tests"
task :cruise do
  begin
    Rake.application.options.trace = true

    ENV['RAILS_ENV'] = 'test'
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke

    ENV['SPEC_OPTS'] = "--format progress --format html --out #{RSPEC_ARTIFACT}"
    Rake::Task['spec'].invoke

    ENV['SPEC_OPTS'] = "--format progress --format html --out #{JASMINE_ARTIFACT}"
    Rake::Task['jasmine:ci'].invoke

    ENV['RAILS_ENV'] = 'cucumber'
    Rake::Task['assets:precompile'].invoke
    ENV['CUCUMBER_OPTS'] = "--format pretty --format html --out #{CUKE_ARTIFACT}"
    Rake::Task['cucumber'].invoke
  ensure
    artifacts_dir = ENV['CC_BUILD_ARTIFACTS']

    if artifacts_dir
      FileUtils::mkdir_p artifacts_dir unless File.directory? artifacts_dir
      [RSPEC_ARTIFACT, JASMINE_ARTIFACT, CUKE_ARTIFACT, SIMPLECOV_ARTIFACT].each do |artifact|
        FileUtils::mv artifact, artifacts_dir if File.exist?(artifact)
      end
    end
    Rake::Task['assets:clean'].invoke
  end
end
