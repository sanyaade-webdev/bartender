require 'spec_helper'

describe Bartender::Request, '.get' do
  let(:request)  { stub('Request',  :get  => response) }
  let(:response) { stub('Response', :body => '{}') }

  before do
    Bartender::Request.stubs(:uri).returns('/')
    Bartender::Request.stubs(:request).returns(request)
  end

  it 'constructs the request URI' do
    Bartender::Request.get('/', {})
    Bartender::Request.should have_received(:uri).with('/', {})
  end

  it 'makes an API request' do
    Bartender::Request.get('/')
    request.should have_received(:get).with('/')
  end

  it 'returns the parsed JSON response body' do
    Bartender::Request.get('/').should == {}
  end
end

describe Bartender::Request, '.request' do
  it 'creates a new HTTP client' do
    Bartender::Request.request.should be_a(Net::HTTP)
  end

  it 'connects to configured host and port' do
    Bartender::Request.request.address.should == Bartender.configuration.host
    Bartender::Request.request.port.should    == Bartender.configuration.port
  end

  it 'sets configured open and read timeouts' do
    Bartender::Request.request.open_timeout.should == Bartender.configuration.http_open_timeout
    Bartender::Request.request.read_timeout.should == Bartender.configuration.http_read_timeout
  end
end

describe Bartender::Request, '.uri' do
  let(:version) { Bartender::API_VERSION }

  it 'returns a path and query string based on the provided options' do
    Bartender::Request.uri('/path', { :a => 1, :b => 2 }).should == "/v#{version}/path.json?a=1&b=2"
  end

  it 'includes token when configured' do
    Bartender.configuration.token = 'a1b2c3'
    Bartender::Request.uri('/path', { :a => 1, :b => 2 }).should == "/v#{version}/path.json?a=1&b=2&token=a1b2c3"
  end

  it 'allows overriding of configured token' do
    Bartender.configuration.token = 'a1b2c3'
    Bartender::Request.uri('/path', { :a => 1, :b => 2, :token => 3 }).should == "/v#{version}/path.json?a=1&b=2&token=3"
  end
end
