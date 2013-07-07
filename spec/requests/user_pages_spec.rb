require 'spec_helper'

describe "User pages" do
  
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    let(:submit_form) { "Sign up!" }

    describe "without valid information" do
      it "should not change the user count" do
        expect { click_button submit_form }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "First name",   with: "Sarah"
        fill_in "Last name",    with: "McMara"
        fill_in "Email",        with: "sarah@mcmara.com"
        fill_in "Password",     with: "password123"
        fill_in "Confirmation", with: "password123"
      end

      it "should create a new user" do
        expect { click_button submit_form }.to change(User, :count).by(1)
      end
    end
  end
end
