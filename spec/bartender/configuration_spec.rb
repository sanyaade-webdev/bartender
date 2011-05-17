require 'spec_helper'

describe Bartender::Configuration do
  it { should have_configuration_option(:port).default(80) }
  it { should have_configuration_option(:public_token).default(nil) }
  it { should have_configuration_option(:private_token).default(nil) }
  it { should have_configuration_option(:http_open_timeout).default(2) }
  it { should have_configuration_option(:http_read_timeout).default(2) }
  it { should have_configuration_option(:host).default('api.openbeerdatabase.com') }
end
