require "net/http"
require "uri"

module RaceCondition
  class Client
    BASE_URL = "https://racecondition.io"
    ENDPOINT = "api/1"

    def report!(project_id, report_output)
      return unless report?

      puts "Sending test run data to RaceCondition..."
      response = post("projects/#{project_id}/builds", report_output)
      # TODO: handle response / check status code
    rescue Errno::ECONNREFUSED, SocketError, Net::ReadTimeout
      puts "Unable to reach RaceCondition."
    end

    def check_response_errors(response)
    end

    private

    def post(path, params)
      uri = URI.parse("#{BASE_URL}/#{ENDPOINT}/#{path}")
      Net::HTTP.post_form(uri, params)
    end

    def report?
      config.report?
    end

    def config
      RaceCondition::RSpec.configuration
    end
  end
end
