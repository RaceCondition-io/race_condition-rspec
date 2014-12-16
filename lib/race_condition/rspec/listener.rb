module RaceCondition
  module RSpec
    class Listener
      SUBSCRIPTIONS = [:example_passed, :example_failed, :example_pending,
                       :dump_summary, :seed, :close]

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

      def dump_summary(*args)
        if Gem::Version.new(::RSpec::Core::Version::STRING).release >= Gem::Version.new('3.0.0')
          @report.duration = args.first.duration
        else
          @report.duration = args.first
        end
      end

      def seed(seed)
        @report.seed = seed
      end

      def close(*args)
        @report.broadcast!
      end
    end
  end
end
