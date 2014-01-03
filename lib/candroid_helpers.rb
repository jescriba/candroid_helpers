require "candroid_helpers/version"
require "calabash-android/abase"

module CandroidHelpers
  
  def until_element_exists opts = {}
    '''Performs a lambda action until the element appears.
    The default action is to do nothing.'''
    raise "No element given." if opts[:element].nil?
    timeout = opts[:timeout] || 10
    action = opts[:action] || lambda { ; }
    wait_poll until_exists: element, timeout: timeout do
      action.call
    end
  end

  def once_element_exists opts = {}
    '''Performs a lambda action once the element exists.
    The default behavior is to touch the specified element.'''
    raise "No element given." if opts[:element].nil?
    timeout = opts[:timeout] || 10
    action = opts[:action] || lambda { touch element }
    wait_for_elements_exist [element], timeout: timeout
    action.call
  end

  def multiple_traits opts = {}
    '''Pass an array of query elements. Determines the
    correct trait for page objects that can have multiple 
    acceptable traits.'''
    timeout = opts[:timeout] || 10
    traits = opts[:traits] || ["*"]
    trait = ''
    action = lambda do 
      arr.each do |element|
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
