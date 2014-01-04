require "candroid_helpers/version"
require "calabash-android/abase"

module CandroidHelpers
  
    # Performs a lambda action until the element appears.
    # The default action is to do nothing.
  def until_element_exists opts = {}
    raise "No element given." if opts[:element].nil?
    timeout = opts[:timeout] || 10
    action = opts[:action] || lambda { ; }
    wait_poll until_exists: opts[:element], timeout: timeout do
      action.call
    end
  end

    # Performs a lambda action once the element exists.
    # The default behavior is to touch the specified element.
  def once_element_exists opts = {}
    raise "No element given." if opts[:element].nil?
    timeout = opts[:timeout] || 10
    action = opts[:action] || lambda { touch opts[:element] }
    wait_for_elements_exist [opts[:element]], timeout: timeout
    action.call
  end

    # Pass an array of query elements. Determines the
    # correct trait for page objects that can have multiple 
    # acceptable traits.
  def multiple_traits opts = {}
    timeout = opts[:timeout] || 10
    traits = opts[:traits] || ["*"]
    trait = ''
    action = lambda do 
      traits.each do |element|
        if element_exists element
          trait = element
          break
        end
      end
      !trait.empty?
    end
    wait_poll until: action, timeout: timeout do ; end
    trait # Return the one trait
  end

end
