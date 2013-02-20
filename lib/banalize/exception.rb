module Banalize
  class BanalizeError < StandardError; end

  class Runner
    class Error < BanalizeError; end
  end

  class Registry
    class Error              < BanalizeError; end
    class RuntimeError       < BanalizeError; end
    class ArgumentError      < BanalizeError; end
  end

  class Policy
    class Error              < BanalizeError; end
    class RuntimeError       < BanalizeError; end
    class ArgumentError      < BanalizeError; end
  end
end
