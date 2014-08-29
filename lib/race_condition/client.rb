module RaceCondition
  class Client
    include APISmith::Client

    base_uri "http://racecondition.io/"
    endpoint "api/1"

    def report!(project_id, report_output)
      return unless report?

      puts "Sending test run data to RaceCondition..."
      params = { build: report_output }
      post("projects/#{project_id}/builds", extra_body: params)
    rescue Errno::ECONNREFUSED, SocketError, Net::ReadTimeout
      puts "Unable to reach RaceCondition."
    end

    def check_response_errors(response)
    end

    private

    def report?
      config.report?
    end

    def config
      RaceCondition::RSpec.configuration
    end
  end
end
