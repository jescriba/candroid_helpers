require "candroid_helpers/version"
require "calabash-android/abase"

module CandroidHelpers
  
  def until_element_exists element, action, timeout = 15
    '''Performs a lambda action until the element appears.'''
    wait_poll until_exists: element, timeout: timeout do
      action.call
    end
  end

  def once_element_exists element, action = lambda { touch element }, timeout = 15
    '''Performs a lambda action once the element exists.
    The default behavior is to touch the specified element.'''
    wait_for_elements_exist [element], timeout: timeout
    action.call
  end

  def multiple_traits arr = ["*"], timeout = 15
    '''Pass an array of query elements. Determines the
    correct trait for page objects that can have multiple 
    acceptable traits.'''
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
