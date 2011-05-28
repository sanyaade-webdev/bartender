require "spec_helper"

describe Bartender::Beer, ".all" do
  before do
    Bartender::Request.stubs(:get)
  end

  it "retrieves all beers" do
    Bartender::Beer.all
    Bartender::Request.should have_received(:get).with("/beers", {})
  end

  it "retrieves all beers with options" do
    Bartender::Beer.all(:page => 2)
    Bartender::Request.should have_received(:get).with("/beers", { :page => 2 })
  end
end

describe Bartender::Beer, ".create" do
  let(:options)    { { :token => "Fake" } }
  let(:attributes) { { :name  => "Awesome" } }

  before do
    Bartender::Request.stubs(:post)
  end

  it "creates a beer" do
    Bartender::Beer.create(attributes, options)
    Bartender::Request.should have_received(:post).with("/beers", attributes, options)
  end
end

describe Bartender::Beer, ".find" do
  before do
    Bartender::Request.stubs(:get)
  end

  it "retrieves a specific beer" do
    Bartender::Beer.find(1)
    Bartender::Request.should have_received(:get).with("/beers/1", {})
  end

  it "retrieves a specific beer with options" do
    Bartender::Beer.find(1, :token => "fake")
    Bartender::Request.should have_received(:get).with("/beers/1", :token => "fake")
  end
end
