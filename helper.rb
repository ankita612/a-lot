require 'rspec'
require 'watir-webdriver'
require 'watir-webdriver/wait'
require 'watir-webdriver/extensions/alerts'
require 'logger'

RSpec.configure do |c|
  c.color = true
  c.formatter = :documentation
  c.fail_fast = true
end

# --------------------------------------------------- #
# * Login
#---------------------------------------------------- #
class Login
  def self.username
    $b.element :css, "div.controls > input[name='username']"
  end
  def self.password
    $b.element :css, "div.controls > input[name='password']"
  end
  def self.login
    $b.element :css, 'div.span3 > button'
  end
end

# --------------------------------------------------- #
# * Capture a screenshot
#---------------------------------------------------- #
# defining global method to capture screenshot
def screenshot(filename)
  basepath = File.join(File.dirname(__FILE__), 'screenshot')
  # Create dir if not exists
  Dir.mkdir basepath, 0755 if not File.exist? basepath
  #%x(mkdir -p #{basepath})
  # Capture screenshot
  $b.driver.save_screenshot("#{basepath}/#{filename}_#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.png")
end

class Browser
  def self.inst= (val)
    @inst = val
  end

  def self.inst
    return @inst
  end
end

# --------------------------------------------------- #
# * Image folder from where to test uploads
#---------------------------------------------------- #

describe 'imagepath' do
  $imagepath = File.join(File.dirname(__FILE__), 'Image')
end

