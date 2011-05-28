require "spec_helper"

describe Bartender::Brewery, ".all" do
  before do
    Bartender::Request.stubs(:get)
  end

  it "retrieves all breweries" do
    Bartender::Brewery.all
    Bartender::Request.should have_received(:get).with("/breweries", {})
  end

  it "retrieves all breweries with options" do
    Bartender::Brewery.all(:page => 2)
    Bartender::Request.should have_received(:get).with("/breweries", { :page => 2 })
  end
end

describe Bartender::Brewery, ".create" do
  let(:options)    { { :token => "Fake" } }
  let(:attributes) { { :name  => "Awesome" } }

  before do
    Bartender::Request.stubs(:post)
  end

  it "creates a brewery" do
    Bartender::Brewery.create(attributes, options)
    Bartender::Request.should have_received(:post).with("/breweries", { :brewery => attributes }, options)
  end
end

describe Bartender::Brewery, ".delete" do
  let(:options) { { :token => "Fake" } }

  before do
    Bartender::Request.stubs(:delete)
  end

  it "creates a brewery" do
    Bartender::Brewery.delete(1, options)
    Bartender::Request.should have_received(:delete).with("/breweries/1", options)
  end
end

describe Bartender::Brewery, ".find" do
  before do
    Bartender::Request.stubs(:get)
  end

  it "retrieves a specific brewery" do
    Bartender::Brewery.find(1)
    Bartender::Request.should have_received(:get).with("/breweries/1", {})
  end

  it "retrieves a specific brewery with options" do
    Bartender::Brewery.find(1, :token => "fake")
    Bartender::Request.should have_received(:get).with("/breweries/1", :token => "fake")
  end
end
