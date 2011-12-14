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

  describe "#user_can_login?" do
    subject { the_object.user_can_login?(user_name, user_password) }

    let(:existing_user_name) do
      begin
        the_object.send(:postgres_exec, "CREATE ROLE deployment_test_example;")
      rescue PGError
      end
      "deployment_test_example"
    end

    context "when user exist with password" do
      let(:user_name) { existing_user_name }
      let(:user_password) do
        the_object.send(:postgres_exec, "ALTER ROLE #{existing_user_name} ENCRYPTED PASSWORD 'xxx';")
        'xxx'
      end

      it { should be_true }
    end

    context "then user not exist" do
      let(:user_name) { "deployment_test_not_existing" }
      let(:user_password) { "deployment_test_example_password" }

      it { should be_false }
    end
  end

  describe "#database_exist?" do
    subject { the_object.database_exist?(database_name) }

    context "when database exist" do
      let(:database_name) { "postgres" }

      it { should be_true }
    end

    context "when database not exist" do
      let(:database_name) { "example_not_existing_database" }

      it { should be_false }
    end
  end

end
