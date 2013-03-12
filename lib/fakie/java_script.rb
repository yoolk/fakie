module Fakie
  module JavaScript
    module_function

    # ExecJS Context
    # @return [ExecJS::ExternalRuntime::Context] context for executing JavaScript against libphonenumber and Fakie
    def context
      @@_js_context ||= begin
        require 'execjs'
        js_dir = File.join(File.expand_path(File.dirname(__FILE__)), 'js')
        source = File.open(File.join(js_dir, 'libphonenumber.js')).read
        source += File.open(File.join(js_dir, 'fakie.js')).read
        ExecJS.compile(source)
      end
    end

    # Call a function against the context
    # @param function [String] function name
    # @param args [* String] list of arguments to send to the function
    def call(function, *args)
      context.call(function, *args)
    end

    # Call a function against the context
    # @param function [String] JavaScript code to evaluate
    def eval(script)
      context.eval(script)
    end
  end
end
