casper = require('casper').create(
  {
    verbose: true
    logLevel: "debug"
  }
  )


casper.start "http://badslot.com/login", ->
  @test.assertExists "form[action='/login']", "Login Form is Present"
  @fill "form[action='/login']", 
    username: "dd@ad.com"
    password: "a!"  
  ,true


casper.userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5")

casper.then ->
 @echo(@getCurrentUrl())
 
casper.then ->
  @test.assertTitle "Dashboard", "title is OK"
  @capture "Ankita2.jpg"
  @click "button[class='nav-btn dropdown-toggle']"
  @capture "Ankita3.jpg"
  @test.comment "Clicked on the button to load drop down"
  
casper.then ->
  @test.assertExists "a[href='/siteadmin']", "Reports Link Found"
  @click "a[href='/siteadmin']"

casper.userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5")

casper.then ->
  @test.comment "Current Location is " + @getCurrentUrl()
  @capture "Ankita4.jpg"
  @test.assertExists "a[href='/siteadmin/']", "Link Present"
  @test.comment "Clicking On Link"
  @click "a[href='/siteadmin/']"

casper.userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5")

casper.then ->
  @test.info "Current location is " + @getCurrentUrl()
  @capture "Ankita5.jpg"
  #@test.assertExists x("//table[@id='report-table']/tbody/tr[1]/td[10]/ul/li/a"), "Details link present"
  x = require("casper").selectXPath
  #@test.assertExists x("//a[contains(.,'Details')]"), "Details link present"
  @test.assertExists x("//table[@id='report-table']/tbody/tr[1]/td[10]/ul/li/a"), "Details link present"
  @click x("//table[@id='report-table']/tbody/tr[1]/td[10]/ul/li/a")
  @test.comment "Clicked on Details Link"

casper.userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5")

casper.then ->
  @echo(@getCurrentUrl())
  @capture "Ankita6.jpg"
  @test.assertExists "input[id='enable-customisation']", "Enable Customisation checkbox present"
  @click "input[id='enable-customisation']" # checkbox selected
  @test.comment "Selected customisation checkbox"
  @capture "Create.jpg"
  x = require("casper").selectXPath
  @test.assertExists x("//div[@class='form-actions']/div/div[4]/a[@class='btn btn-inverse']"), "Login Button present"
  @click x("//div[@class='form-actions']/div/div[4]/a[@class='btn btn-inverse']")
  @test.comment "Clicked on Login button to Impersonate login"

casper.userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5")

casper.then ->
  @echo(@getCurrentUrl())
  @capture "Ankita7.jpg" 
  @test.assertExists "a[href='/sites']", "Sites tab present" 
  @click "a[href='/sites']"
  @test.comment "Clicked on Sites Tab"

casper.userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5")

casper.then ->
  @echo(@getCurrentUrl())
  @capture "Ankita8.jpg" 
  @test.assertExists "a[href='/sites/new']", "Add Site link present to add site"
  @test.assertExists "a[href='/lots/new']", "Add link present to add to Site"

  
casper.userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5")

casper.then ->
  @echo(@getCurrentUrl())
  @capture "Ankita9.jpg"
  @test.assertTitle "New Site", "title is OK" 
  @fill "form[id='site-form']",
    'site[siteName]': "CasperJS Test Site1"
    'site[siteUrl]': "http://badslot.com"                                                                                              
    'site[siteDescription]': "Adding badslot Site with CasperJS"
    'site[pageViews]': "10000"
    'site[monthlyVisitors]': "2500"
  @capture "Ankita10.jpg"
  @click "div[class='adslot-button-next']"
  @test.comment "Saving the CasperJS Test Site1 Details"
  @capture "Ankita11.jpg"

casper.userAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5")

casper.then ->
  @echo(@getCurrentUrl())
  @capture "Ankita13.jpg"
  @test.assertExists "div[title='CasperJS Test Site1']" , "Site has been added"
  @test.assertExists "div[class='sites-edit']" , "Edit button present besides site"

  


casper.run ->
  @test.done 
  @test.comment "wohoo"     
  @exit()



**COFFEE SCRIPT**
for id, className of {1: 'chart-inactive-text', 2: 'income-large'}
chartPath = "//div[@class='site-stats-details graphs']/span/div[#{id}]/div[2]/div[@class='chart']"

if !browser.hasElementByXPath chartPath
assert browser.elementByClassName('chart-inactive-text').isDisplayed(), 'error with stat display for age/Income'