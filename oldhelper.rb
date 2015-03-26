# --------------------------------------------------- #
  # * Login
#---------------------------------------------------- #   
 class Login
  def Login.username
    $b.element(:css, "div.controls > input[name='username']")
  end
  def Login.password
    $b.element(:css, "div.controls > input[name='password']")
  end
  def Login.login
    $b.element :css, "div.span3 > button"
  end
end
  
## TIPS
# Use this Login class anywhere in your any script referncing this helper file 
    
# --------------------------------------------------- #
  # * Adding screenshot
#---------------------------------------------------- #
class Capture
# defining global method to capture screenshot
  def Capture.screenshot(filename)
	$b.driver.save_screenshot("../screenshot/#{filename}_#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.png")
  end
end

# This Capture class could be used anywhere to capture screen shot and giving a specific filename like 
#Capture.screenshot '1-Fail'
  
# --------------------------------------------------- #
  # * Adding logger class
#---------------------------------------------------- #
$log = Logger.new(STDOUT)
$log.level = Logger::DEBUG
$log.formatter = proc do |severity, datetime, progname, msg|
  "[#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}] [#{severity}] : #{msg}\n"
end

# ----- This is to add log information ------------------------#
  # * $log.info 'My Test information' - would give you log like 
  # * [2013-08-13 15:31:01] [INFO] : My Test information
# -------------------------------------------------------------#
 
# --------------------------------------------------- #
  # * For Select List
#---------------------------------------------------- #
 
$b.select_list(:xpath, '//select').option(:xpath, 'option[2]').select # Selected second option 

# --------------------------------------------------- #
  # * For Radio button
#---------------------------------------------------- #

$b.radio(:id, 'one').set
$b.radio(:id, 'one').clear

#OR when radio button does not have id, then 
#<input type="radio" value="true" name="site[name]">
$b.execute_script("$('input:radio[name = \"site[name]\"][value = \"true\"]').attr('checked', true);")

# --------------------------------------------------- #
  # * For Pop up alert
#---------------------------------------------------- #

require 'watir-webdriver/extensions/alerts'

alert_message_text = $b.confirm(true) {$b.button(:value,"force").when_present.fire_event'onclick'} 

OR
$b.alert.ok
$b.execute_script("window.confirm = function() {return true}")

# --------------------------------------------------- #
  # * For check box
#---------------------------------------------------- #

$b.execute_script("$('#id_of_object').attr('checked', 'checked');")

OR
$b.checkbox(:id, 'id_of_object').when_present.set 

# --------------------------------------------------- #
  # * For Auto Complete Box
#---------------------------------------------------- #

$b.input(:type, 'text').when_present.click 
sleep 1
$b.input(:type, 'text').when_present.send_keys 'a' #entering 'a' in search
begin
  $b.li(:class, 'token-input-dropdown-item-facebook').wait_until_present(timeout = 30)
rescue 
  raise "Auto Complete Drop down not loading"
end
$b.li(:class, 'token-input-dropdown-item-facebook').when_present.click #clicking on auto complete drop down

 
# --------------------------------------------------- #
  # * Clicking on tab from keyboard
#---------------------------------------------------- #

$b.element(:xpath, '//fieldset/div[2]/div/input').when_present.send_keys "{TAB}"

# --------------------------------------------------- #
  # * To uppload  FILE
#---------------------------------------------------- #

$b.file_field(:name, 'files[]').set 'F:\\SWF files\\728x90_img2.png'

# --------------------------------------------------- #
  # * Drag and Drop 
#---------------------------------------------------- #

$b.element(:xpath, "//div[@class='sp-slider']").fire_event 'mousedown'
$b.execute_script("var e = $.Event('mousemove');e.pageY=70;$('html').trigger(e);") # Moves the max slider to 0%
$b.element(:xpath, "//div[@class='sp-slider']").fire_event 'mouseup' #filter results as per min slider

# --------------------------------------------------- #
  # * Key Press Event - using JS to click on ENTER button
#---------------------------------------------------- #

$b.text_field(:name, 'fee').fire_event 'mousedown'
$b.execute_script("var e = $.Event('keyup', { keyCode: 13 }); $('input.span6').trigger(e);")
$b.text_field(:name, 'fee').fire_event 'mouseup'
 

# --------------------------------------------------- #
  # * CSS PATH Tips
#---------------------------------------------------- # 

Id  		: 	#
class 		: 	.

<div class="user-image" style="background-image:url(/images/user_image.jpg)">
page.find('div.user-image')['style'].should == 'background-image:url(/images/user_image.jpg)'


<span customattribute="custom1">Custom Attribute 1</span>
browser.span(:css, 'span[customattribute]').text
browser.span(:css, 'span[customattribute="custom1"]').text

:xpath, //div/a
:css, div > a

:xpath, //div[@id='example']/a
:css, div#example > a

$b.element(:css, "table#report-table > tbody > tr:nth-child(1) > td > ul > li > a:contains('Details')") #tr:nth-child(1) is equivalent to tr[1]


# ---------------------------------------- #
  # * Recording single script time
# ---------------------------------------- #
before (:each) do
  puts "--- *** Test Started at Time Stamp: [#{Time.now}] *** ---"
  $timeStart = Time.now
end

after (:each) do
  elapsed = Time.now - $timeStart
  puts "--- *** Test Completed in [#{elapsed}] seconds *** ---"
end

# ---------------------------------------- #
  # * Attach to new browser window and then switch back 
# ---------------------------------------- #

# <a href="http://testwisely.com/demo" target="_blank">Open new window</a>

#While we could use Watir attach method, it will be easier to perform all testing within one browser window. Here is how:

current_url = browser.url
new_window_url = browser.link(:text, "Open new window").href browser.goto(new_window_url)
# ... testing on new site
browser.text_field(:name, "name").set "sometext" 
browser.goto(current_url) # back

# ---------------------------------------- #
  # * Clicking on same link that appears more than once
# ---------------------------------------- #

#Line i <link>
#Line ii <link>

#In order to click on <link> of line2 you could use index like

browser.link(:text => '<link>', :index => 1).click

# ---------------------------------------- #
  # * Getting link data attributes
# ---------------------------------------- #

browser.link(:text, "Recommend Watir").href.should == "http://testwisely.com/demo"
browser.link(:text, "Recommend Watir").id.should == "recommend_watir_link"
browser.link(:id, "recommend_watir_link").text.should == "Recommend Watir"
browser.link(:id, "recommend_watir_link").tag_name.should == "a"
browser.link(:id, "recommend_watir_link").style.should == "FONT-SIZE: 14px"

# ---------------------------------------- #
  # * click button by label
# ---------------------------------------- #

$b.button(:value, 'labelname').click

# if you would like to click on  <input type="image" src="images/go.gif">
$b.button(:src, /go/).click

# Assert a button enabled or disabled?
browser.button(:text, "Choose Watir").enabled?.should be_true
browser.link(:text, "Disable").click
sleep 0.5
browser.button(:id, "choose_watir_btn").enabled?.should be_false
browser.link(:text, "Enable").click
sleep 1
browser.button(:id, "choose_watir_btn").enabled?.should be_true

# ---------------------------------------- #
  # * enter text into text field
# ---------------------------------------- #

browser.text_field(:name, "username").set("new value")
browser.text_field(:id, "user").send_keys("tester1")
browser.text_field(:id, "user").clear

#Enter text into a multi-line text area
browser.text_field(:id, "comments").set("Automated testing is\r\nFun!")
# here \r\n represent new line

# ---------------------------------------- #
  # * Set a value to a read-only or disabled text field
# ---------------------------------------- #

#Readonly text field:
#<input type="text" name="readonly_text" readonly="true"/> <br/>
#Disabled text field:
#<input type="text" name="disabled_text" disabled="true"/>
browser.text_field(:name, "readonly_text").value = "anyuse"
browser.text_field(:name, "disabled_text").value = "bypass"

# ---------------------------------------- #
  # * To upload a image
# ---------------------------------------- #

#Create a image folder on root directory
#place the image - img.jpg inside that folder

describe 'imagepath' do
  $imagepath = File.join(File.dirname(__FILE__), 'Image')
end
$b.file_field(:name, 'files[]').set "#{$imagepath}//img.jpg"

# ---------------------------------------- #
  # * To generate random number
# ---------------------------------------- #

$b.text_field(:name, 'text').set("#{rand(9999)}")

# ---------------------------------------- #
  # * To login where you get login js popup 
# ---------------------------------------- #

 #login to site that has JS popup authentication
 $b.goto "https://<username>:<password>@<url>"
 
# ---------------------------------------- #
  # * To run script on multiple browsers 
# ---------------------------------------- #
browsers = [:firefox, :ie, :phantomjs].each do |br|
$b = Watir::Browser.new br
$b.goto <url>
end
 