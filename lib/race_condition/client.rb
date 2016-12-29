require "net/http"
require 'json'

module RaceCondition
  class Client
    BASE_URL = "https://racecondition.io"
    ENDPOINT = "api/v1"

    def report!(project_id, report_output)
      return unless report?

      puts "Sending test run data to RaceCondition..."
      response = post("projects/#{project_id}/builds", report_output)

      unless response.code.to_i == 200
        puts "Unable to log test results to RaceCondition."
      end
    rescue Errno::ECONNREFUSED, SocketError, Net::ReadTimeout => e
      puts "Unable to reach RaceCondition."
    end

    private

    def post(path, params)
      url = URI.parse("#{BASE_URL}/#{ENDPOINT}/#{path}")

      http = Net::HTTP.new(url.host, url.port)
      http.read_timeout = 5
      http.open_timeout = 5

      json_headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      http.post(url.path, params.to_json, json_headers)
    end

    def report?
      config.report?
    end

    def config
      RaceCondition::RSpec.configuration
    end
  end
end
