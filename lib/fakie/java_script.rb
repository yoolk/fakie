module Fakie
  module JavaScript
    module_function

    # ExecJS Context
    # @return [ExecJS::ExternalRuntime::Context] context for executing JavaScript against libphonenumber and Fakie
    def js_context
      @@_js_context ||= begin
        require 'execjs'
        source = File.open(File.join(__FILE__, '../js/libphonenumber.js')).read
        source += File.open(File.join(__FILE__, '../js/fakie.js')).read
        ExecJS.compile(source)
      end
    end

    # Call a function against the context
    # @param function [String] function name
    # @param args [* String] list of arguments to send to the function
    def js_call(function, *args)
      js_context.call(function, *args)
    end

    # Call a function against the context
    # @param function [String] JavaScript code to evaluate
    def js_eval(script)
      js_context.eval(script)
    end
  end
end
