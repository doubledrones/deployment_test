require 'deployment_test'

describe DeploymentTest::Postgres do

  let(:the_class) { DeploymentTest::Postgres }
  let(:the_object) do
    # you need local admin user for testing
    the_class.new(:user => 'deployment_test', :password =>'deployment_test')
  end

  describe "#user_exist?" do
    subject { the_object.user_exist?(user_name) }

    context "when user exist" do
      let(:user_name) { "postgres" }

      it { should be_true }
    end

    context "when user not exist" do
      let(:user_name) { "example_not_existing_user" }

      it { should be_false }
    end
  end

end
