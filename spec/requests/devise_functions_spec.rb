require 'rails_helper'

RSpec.describe "DeviseFunctions", type: :request do
  describe "GET /devise_functions" do
    it "works! (now write some real specs)" do
      get devise_functions_path
      expect(response).to have_http_status(200)
    end
  end
end
