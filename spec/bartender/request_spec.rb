require "spec_helper"

describe Bartender::Request, ".delete" do
  let(:request)       { stub("Request",  :delete => response) }
  let(:response)      { stub("Response", :code => 200) }
  let(:private_token) { "a1b2c3" }

  before do
    Bartender::Request.stubs(:uri).returns("/")
    Bartender::Request.stubs(:request).returns(request)
    Bartender.configuration.private_token = private_token
  end

  it "constructs the request URI" do
    Bartender::Request.delete("/", :option => 1)
    Bartender::Request.should have_received(:uri).with("/", :option => 1, :token => private_token)
  end

  it "allows overriding of configured private token" do
    Bartender::Request.delete("/", :token => "x1y2z3")
    Bartender::Request.should have_received(:uri).with("/", :token => "x1y2z3")
  end

  it "makes an API request" do
    Bartender::Request.delete("/")
    request.should have_received(:delete).with("/")
  end

  it "returns true for a successful response" do
    Bartender::Request.delete("/").should == true
  end

  it "returns false for all other responses" do
    response.stubs(:code => "401")
    Bartender::Request.delete("/").should == false
  end
end

describe Bartender::Request, ".get" do
  let(:request)      { stub("Request",  :get  => response) }
  let(:response)     { stub("Response", :body => "{}", :code => 200) }
  let(:public_token) { "a1b2c3" }

  before do
    Bartender::Request.stubs(:uri).returns("/")
    Bartender::Request.stubs(:request).returns(request)
  end

  it "constructs the request URI" do
    Bartender::Request.get("/", :option => 1)
    Bartender::Request.should have_received(:uri).with("/", :option => 1)
  end

  it "includes public token when configured" do
    Bartender.configuration.public_token = public_token
    Bartender::Request.get("/")
    Bartender::Request.should have_received(:uri).with("/", :token => public_token)
  end

  it "allows overriding of configured public token" do
    Bartender.configuration.public_token = public_token
    Bartender::Request.get("/", :token => "x1y2z3")
    Bartender::Request.should have_received(:uri).with("/", :token => "x1y2z3")
  end

  it "makes an API request" do
    Bartender::Request.get("/")
    request.should have_received(:get).with("/")
  end

  it "returns the parsed JSON response body for a successful response" do
    Bartender::Request.get("/").should == {}
  end

  it "returns false for all other responses" do
    response.stubs(:code => "401")
    Bartender::Request.get("/").should == false
  end
end

describe Bartender::Request, ".post" do
  let(:headers)       { { "Content-Type" => "application/json" } }
  let(:request)       { stub("Request",  :post => response) }
  let(:location)      { "/v1/records/1" }
  let(:response)      { stub("Response", :code => 201, :[] => location) }
  let(:private_token) { "a1b2c3" }

  before do
    Bartender::Request.stubs(:uri).returns("/")
    Bartender::Request.stubs(:request).returns(request)
    Bartender.configuration.private_token = private_token
  end

  it "constructs the request URI" do
    Bartender::Request.post("/", {}, :option => 1)
    Bartender::Request.should have_received(:uri).with("/", :option => 1, :token => private_token)
  end

  it "allows overriding of configured private token" do
    Bartender::Request.post("/", {}, :token => "x1y2z3")
    Bartender::Request.should have_received(:uri).with("/", :token => "x1y2z3")
  end

  it "makes an API request" do
    Bartender::Request.post("/", :name => "Example")
    request.should have_received(:post).with("/", Yajl::Encoder.encode({ :name => "Example" }), headers)
  end

  it "returns the location header for a created response" do
    Bartender::Request.post("/").should == location
  end

  it "returns an errors hash for a bad request response" do
    response.stubs(:code => "400", :body => '{"errors":{}}')
    Bartender::Request.post("/").should == {}
  end

  it "returns false for all other responses" do
    response.stubs(:code => "401")
    Bartender::Request.post("/").should == false
  end
end

describe Bartender::Request, ".request" do
  it "creates a new HTTP client" do
    Bartender::Request.request.should be_a(Net::HTTP)
  end

  it "connects to configured host and port" do
    Bartender::Request.request.address.should == Bartender.configuration.host
    Bartender::Request.request.port.should    == Bartender.configuration.port
  end

  it "sets configured open and read timeouts" do
    Bartender::Request.request.open_timeout.should == Bartender.configuration.http_open_timeout
    Bartender::Request.request.read_timeout.should == Bartender.configuration.http_read_timeout
  end
end

describe Bartender::Request, ".uri" do
  let(:version) { Bartender::API_VERSION }

  it "returns a path and query string based on the provided options" do
    Bartender::Request.uri("/path", { :a => 1, :b => 2 }).should == "/v#{version}/path.json?a=1&b=2"
  end
end
