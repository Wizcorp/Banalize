module Banalize
  ##
  # Helper methods for printing out policies descriptions.
  #
  class Describe

    ##
    # Format for markdown documentation for policies
    #
    FORMAT =<<-FORM

## %s

*%s*

* Policy name: %s
* Severity:    %s
* Style:       %s
* Defaults:    %s

**Description**

````
%s

````

------------------------------------------------------------------

FORM

    def self.yellow
      printf "%s\n", ('~' * 80).color(:yellow)
    end

    def self.markdown policies

      puts <<-PUT
# @title List of available policies

# Banalizer

![banalize](images/banalize_small.png)

PUT

      policies.each do |pol|

        defl = ""

        if pol[:default]
          pol[:default].each { |k,v| defl << "\n  * #{k}: #{v}\n" }
        end

        defl = "N/A" if defl.empty?

        printf FORMAT,
        pol[:policy].to_s.titleize,
        pol[:synopsis],
        pol[:policy],
        pol[:severity],
        pol[:style],
        defl,
        pol[:description]
      end
    end

    def self.screen policies
      policies.each do |pol|
        yellow
        printf "%s :  %s\n", pol[:policy].to_s.color(:bold), pol[:synopsis].color(:green)
        yellow

        puts pol[:description]
        puts
      end
    end
  end
end
