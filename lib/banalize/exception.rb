module Banalize
  class BanalizeError < StandardError
  end

  class Runner
    class Error < BanalizeError
    end
  end

  class Policy
    class Error < BanalizeError
    end
  end

  
end
