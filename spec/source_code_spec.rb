require 'spec_helper'

RSpec.describe 'SourceCode' do
  RUBY_SOURCE_PATHS = Dir.entries('lib')
  it 'not have any binding.pry in the ruby code. What? You made this fail? How embarrassing...' do
    includes = RUBY_SOURCE_PATHS.inject('') do |result, path|
      result << " --include *.rb app/#{path} --include *.haml app/#{path}"
    end
    output = `grep -R 'binding\\.pry' #{includes}`
    puts output
    matches = output.count("\n")
    expect(matches).to eq(0), "Found in:\n#{output}"
  end

  context 'rubocop analysis' do
    subject(:report) { `rubocop` }

    it 'has no offenses' do
      expect(report).to match(/no\ offenses\ detected/)
    end
  end
end
