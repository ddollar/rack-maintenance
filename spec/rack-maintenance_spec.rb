require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'fileutils'

describe "RackMaintenance" do
  let(:app) { Class.new { def call(env); end }.new }
  let(:rack) { Rack::Maintenance.new(app, :file => "spec/maintenance.html") }

  context "without maintenance file" do
    it "calls the app" do
      app.should_receive(:call).once
      rack.call({})
    end
  end

  context "with maintenance file" do
    before do
      FileUtils.touch 'spec/maintenance.html'
    end

    after do
      FileUtils.rm 'spec/maintenance.html'
    end

    it "does not call the app" do
      app.should_not_receive :call
      rack.call({})
    end

    it "returns the maintenance response" do
      rack.call({}).should eq [503, {"Content-Type"=>"text/html", "Content-Length"=>"0"}, [""]]
    end
  end
end
