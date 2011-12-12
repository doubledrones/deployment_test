require 'pg'

module DeploymentTest
  class Postgres

    def initialize(options = {})
      @options = {
        :host => "127.0.0.1",
        :dbname => 'postgres',
        :user => 'postgres',
        :password => 'postgres'
      }.merge(options)
    end

    def user_exist?(name)
      user_count(name).entries[0]['count'] != '0'
    end

    private

      def postgres_connection
        @postgres_connection ||= PGconn.connect(@options)
      end

      def user_count(name)
        postgres_connection.exec("SELECT COUNT(*) FROM pg_user WHERE usename='#{name}'")
      end

  end
end
