require "net/http"
require 'json'

module RaceCondition
  class Client
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
      url = URI.parse("#{base_url}/#{ENDPOINT}/#{path}")

      http = Net::HTTP.new(url.host, url.port)
      http.read_timeout = 5
      http.open_timeout = 5
      http.use_ssl = uri.scheme == 'https'

      json_headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }

      http.post(url.path, params.to_json, json_headers)
    end

    def report?
      config.report?
    end

    def base_url
      config.report_to_domain
    end

    def config
      RaceCondition::RSpec.configuration
    end
  end
end
