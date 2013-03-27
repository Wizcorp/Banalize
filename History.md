
## v.0.0.2

* Wed Mar 27 2013 -- Dmytro Kovalov
    Multiple changes:
  - Allow search policies by regexp from CLI
  - search method changes in Policy
      - add search by Regexp
      - YARD formatting
  - Changes to describe command
      - Better screen output with color support
      - Drop policy name argument from desc command, use global policies search
  - Fix NaN - divizion by 0n comment coverage
  - Use of active = false
      By using false on active default allow disabling policies.
  - Policy to check percetantage coverage of the comments over code
  - POD comments module
      POD comments included into standard parser as module.  It recognizes comments in POD here-doc style and moves them from code part to comments.
  - For Numbered class:
      - method slice
      - method sort
  - Move @lines parsing to Parser class
  - Add GLI_DEBUG for exit_now!
  - Documnetation for Numbered class
  - Fix no method error when $styles section for policy don't exist
