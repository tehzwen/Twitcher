# frozen_string_literal: true

RSpec.describe Twitcher do
  it "has a version number" do
    expect(Twitcher::VERSION).not_to be nil
  end


  it "should be able to make an http request" do
    client = Twitch::Client::TwitchClient.new(client_id: "MOCK", client_secret: "MOCK")
    response = client.query_url(url:"https://www.google.ca")
    expect(client.secrets).to eq({id:"MOCK", secret:"MOCK"})
    expect(response).not_to eq(nil)
  end


  it "does something useful" do
    expect(false).to eq(true)
  end
end
