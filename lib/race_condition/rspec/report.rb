module RaceCondition
  module RSpec
    class Report
      attr_accessor :passed_count, :passed_examples, :failure_count,
                    :failed_examples, :pending_count, :pending_examples,
                    :seed, :duration

      def initialize
        @passed_examples = []
        @failed_examples = []
        @pending_examples = []
      end

      def broadcast!
        data = {
          seed: seed,
          duration: duration,
          examples: examples_output,
          metadata: metadata
        }

        allow_webmock!
        Client.new.report!("f8e76771aef86908", data)
      end

      private

      def allow_webmock!
        WebMock.allow_net_connect! if Object.const_defined?("WebMock")
      end

      def metadata
        config = RaceCondition::RSpec.configuration

        {
          branch_name: config.branch_name,
          commit: config.commit,
          build_number: config.build_number
        }
      end

      def examples
        passed_examples + failed_examples + pending_examples
      end

      def examples_output
        examples.map do |example|
          map_to_data_hash(example)
        end
      end

      def map_to_data_hash(example)
        data = example.execution_result.merge({
          description: example.description,
          full_description: example.full_description,
          file_path: example.file_path,
          location: example.location,
          type: example.metadata[:type]
        })

        if data[:exception]
          exception = data[:exception]

          data[:exception] = {
            class: exception.class.name,
            message: exception.message,
            backtrace: exception.backtrace
          }
        end

        data
      end
    end
  end
end
