require 'watir-webdriver'
require '../helper.rb'
+require 'uri'
+require 'json'
+
+describe 'Whitelabel Suite' do
+  before (:all) do # initiate the phantomjs browser
+    testSiteUrl = ENV['UI_TEST_URL']
+    raise 'Please provide a valid UI_TEST_URL' if testSiteUrl.nil? 
+
+    PreviewUrl = getPreviewUrl testSiteUrl 
+    $b = Watir::Browser.start PreviewUrl, :firefox
+    $b.wait 30
+  end
+
+  it 'should have correct header logo' do
+    headerLogo = $b.element :css, '.white-label .header-logo a .logo'
+    bgImg = headerLogo.style 'background-image'
+    bgImg.should eql 'url("http://d1ty3l1h3vtwy2.cloudfront.net/901e6ff0-0895-11e3-96f1-679e4cde98eb.png")'
+  end
+
+  it 'should have correct header background color' do
+    header = $b.element :css, '.white-label .header'
+    bgColor = header.style 'background-color'
+    bgColor.should eql 'rgba(255, 255, 255, 1)'
+  end
+
+  it 'should have correct nav color' do
+    navbar = $b.element :css, '.white-label .nav-bar-wrapper'
+    bgColor = navbar.style 'background-color'
+    bgColor.should eql 'rgba(0, 123, 195, 1)'
+  end
+
+  it 'should have correct banner image' do
+    banner = $b.element :css, '.white-label .banner'
+    bgImg = banner.style 'background-image'
+    bgImg.should eql 'url("http://d1ty3l1h3vtwy2.cloudfront.net/97fb6070-0895-11e3-96f1-679e4cde98eb.jpg")'
+  end
+
+
+  it 'should have correct footer logo' do
+    footerLogo = $b.element :css, '.white-label .footer .logo-container .logo'
+    bgImg = footerLogo.style 'background-image'
+    bgImg.should eql 'url("http://d1ty3l1h3vtwy2.cloudfront.net/b1540630-0895-11e3-96f1-679e4cde98eb.png")'
+  end
+
+  after (:all) do
+    screenshot 'White-Label'
+    $b.close
+  end
+
+  def getPreviewUrl(testSiteUrl)
+    partnerStr = URI.escape JSON.parse(IO.read('../testdata/test.json')).to_json
+    mediaPreviewUrl = "#{testSiteUrl}/whitelabel-preview?type=demand=#{partnerStr}"
+  end
+end
+ 