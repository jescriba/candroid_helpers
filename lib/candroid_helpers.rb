require "candroid_helpers/version"
require "calabash-android/abase"

module CandroidHelpers
  
  def until_element_exists element, action, timeout = 30
    '''Performs a lambda action until the element appears.'''
    wait_poll until_exists: element, timeout: 30 do
      action.call
    end
  end

  def once_element_exists element, action = lambda { touch element }, timeout = 30
    '''Performs a lambda action once the element exists.
    The default behavior is to touch the specified element.'''
    wait_for_elements_exist [element], timeout: 35
    action.call
  end

  def multiple_traits arr = ["*"]
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
    wait_poll until: action, timeout: 30 do ; end
    trait # Return the one trait
  end

end
