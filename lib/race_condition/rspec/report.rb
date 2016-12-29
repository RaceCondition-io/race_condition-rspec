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
          examples: examples_output,
          seed: seed.seed,
          client: "race_condition-rspec",
          duration: duration,
          branch_name: config.branch_name,
          commit: config.commit,
          build_number: config.build_number
        }

        allow_webmock!
        Client.new.report!(config.codebase_id, data)
      end

      private

      def allow_webmock!
        WebMock.allow_net_connect! if Object.const_defined?("WebMock")
      end

      def config
        RaceCondition::RSpec.configuration
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
        if Gem::Version.new(::RSpec::Core::Version::STRING).release >= Gem::Version.new('3.0.0')
          example = example.example
        end

        data = {
          started_at: example.execution_result.started_at.iso8601,
          finished_at: example.execution_result.finished_at.iso8601,
          run_time: example.execution_result.run_time,
          result: example.execution_result.status,
          full_description: example.full_description,
          file_path: example.file_path,
          location: example.location,
          type: example.metadata[:type]
        }

        if exception = example.exception
          data[:exception] = {
            rerun: "rspec #{rerun_argument_for(example)}",
            class: exception.class.name,
            message: exception.message,
            backtrace: exception.backtrace
          }
        end

        data
      end

      # rerun logic from https://github.com/rspec/rspec-core/blob/4b0a10466cd19271bc5387bf5179bdb3b47a744d/lib/rspec/core/notifications.rb

      def rerun_argument_for(example)
        location = example.location_rerun_argument
        return location unless duplicate_rerun_locations.include?(location)
        example.id
      end

      def duplicate_rerun_locations
        @duplicate_rerun_locations ||= begin
          locations = ::RSpec.world.all_examples.map(&:location_rerun_argument)

          Set.new.tap do |s|
            locations.group_by { |l| l }.each do |l, ls|
              s << l if ls.count > 1
            end
          end
        end
      end
    end
  end
end
