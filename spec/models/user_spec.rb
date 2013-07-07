require 'spec_helper'

describe User do
  
  before do
    @user = User.new(first_name: "John", last_name: "Doe",
                     email: "john@example.com", password: "ohaihai",
                     password_confirmation: "ohaihai")
  end

  subject { @user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  describe "User attributes" do

    describe "when first name is not present" do
      before { @user.first_name = " "}
      it { should_not be_valid }
    end

    describe "when last name is not present" do
      before { @user.last_name = " "}
      it { should_not be_valid }
    end

    describe "when email address is not present" do
      before { @user.email = " " }
      it { should_not be_valid }
    end

    describe "when email address in not unique" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email.upcase!
        user_with_same_email.save
      end

      it { should_not be_valid }
    end

    describe "when password is blank" do
      before do
        @user.password = " "
        @user.password_confirmation = " "
      end

      it { should_not be_valid }
    end

    describe "when password is too short" do
      before do
        @user.password = "foo"
        @user.password_confirmation = "foo"
      end

      it { should_not be_valid }
    end

    describe "when password and password_confirmation don't match" do
      before { @user.password_confirmation = "foobarfoo"}
      it { should_not be_valid }
    end
  end
end
