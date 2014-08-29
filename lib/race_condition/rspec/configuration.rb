module RaceCondition
  module RSpec
    class Configuration
      attr_accessor :branch_name,
                    :project_id,
                    :commit,
                    :build_number,
                    :codebase_id,
                    :report_if

      def report?
        if report_if.respond_to? :call
          report_if.call
        else
          report_if
        end
      end
    end
  end
end
