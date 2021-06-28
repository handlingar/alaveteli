require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/alaveteli_dsl')

RSpec.describe 'when making stripping cookies' do

  it 'should not set a cookie when no significant session data is set' do
    get '/country_message'
    expect(response.headers['Set-Cookie']).to be_blank
  end

end
