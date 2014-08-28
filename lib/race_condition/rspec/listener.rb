module RaceCondition
  module RSpec
    class Listener
      SUBSCRIPTIONS = %i(example_passed example_failed example_pending
                         dump_summary seed close)

      def initialize
        @report = Report.new
      end

      def example_passed(example)
        @report.passed_examples << example
      end

      def example_failed(example)
        @report.failed_examples << example
      end

      def example_pending(example)
        @report.pending_examples << example
      end

      def dump_summary(duration, example_count, failure_count, pending_count)
        @report.duration = duration
      end

      def seed(seed)
        @report.seed = seed
      end

      def close
        @report.broadcast!
      end
    end
  end
end
