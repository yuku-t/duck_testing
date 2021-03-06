require "forwardable"

module DuckTesting
  class Violation
    extend Forwardable

    def_delegators :@call_data, :method_expr

    attr_reader :param

    # @param call_data [DuckTesting::MethodCallData]
    # @param param [Object] the given object.
    # @param expected_types [Array<DuckTesting::Type::Base>] the expected object types.
    # @param param_or_return [Symbol] the report type, `:param` or `:return`
    def initialize(call_data: nil, param: nil, expected_types: nil, param_or_return: nil)
      @call_data = call_data
      @param = param
      @expected_types = expected_types
      @param_or_return = param_or_return
    end

    # @return [Boolean]
    def param?
      param_or_return == :param
    end

    # @return [Boolean]
    def return?
      param_or_return == :return
    end

    # @return [String]
    def expected
      expected_types.map(&:to_s).join(", ")
    end

    private

    attr_reader :call_data, :expected_types, :param_or_return
  end
end
