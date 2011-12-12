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

    def user_can_login?(name, password)
      begin
        PGconn.connect(@options.merge(:user=>name, :password => password))
        true
      rescue PGError
        false
      end
    end

    private

      def postgres_connection
        @postgres_connection ||= PGconn.connect(@options)
      end

      def postgres_exec(query)
        postgres_connection.exec(query)
      end

      def user_count(name)
        postgres_exec("SELECT COUNT(*) FROM pg_user WHERE usename='#{name}'")
      end

  end
end
