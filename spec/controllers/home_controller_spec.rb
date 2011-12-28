require 'spec_helper'

describe HomeController do
  describe "#index" do
    it "should render the index template" do
      get :index
      response.should render_template('index')
    end
  end

  context "rendering views" do
    render_views

    it "gets saved as a fixture so it can be used in Jasmine tests" do
      get :index
      response.should be_success
      save_fixture(html_for('body'), 'home_index')
    end
  end
end
