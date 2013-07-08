require 'spec_helper'

describe "Authentication pages" do

  subject { page }

  describe "signin" do
    before { visit signin_path }

    describe "without valid credentials" do
      before { click_button "Sign in" }

      it { should have_link("Sign in", href: signin_path) }
    end

    describe "with valid credentials" do
      let(:user) { User.create(first_name: "John", last_name: "Doe",
                       email: "john@example.com", password: "ohaihai",
                       password_confirmation: "ohaihai") }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should have_link("Sign out", href: signout_path) }

      describe "signout after signin" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end
    end
  end
end
