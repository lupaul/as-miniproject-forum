require 'rails_helper'

RSpec.describe TopicsController, type: :controller do

  # it "Get/topics" do
    # get "/index"
     subject! { get "index" }
     it { expect(response).to have_http_status(200) }
    #  it { expect(response).to render_template("topics/index") }
    # expect(response).to redirect_to('/test')
    # expect(response.status).to eq(200)
  # end
end
