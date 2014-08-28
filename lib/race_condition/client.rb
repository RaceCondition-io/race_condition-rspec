module RaceCondition
  class Client
    include APISmith::Client
    base_uri "http://localhost:3000/"
    endpoint "api/1"

    def report!(project_id, report_output)
      puts "Sending test run data to RaceCondition..."
      params = { build: report_output }
      post("projects/#{project_id}/builds", extra_body: params)
    rescue Errno::ECONNREFUSED, SocketError, Net::ReadTimeout
      puts "Unable to reach RaceCondition."
    end

    def check_response_errors(response)
    end
  end
end
