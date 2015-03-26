﻿require '../helper.rb'

require './common/test'

# to run on command line - set BROWSER=<browsermame>
# once set then rspec <script.rb>



describe 'Publisher TEST Suite' do
  
  before (:all) do # initiate the phantomjs browser
    $browser = ENV['BROWSER']
    $browser = 'ie' if $browser.nil?
    $site = ENV['URL']
    $site = 'http://badslot.com.au' if $site.nil?
    
	if $browser == 'chrome'
      $b = Watir::Browser.new :chrome
    else
      if $browser == 'firefox'
        $b = Watir::Browser.new :ff
      else
        if $browser == 'ie'
          $b = Watir::Browser.new :ie
        else 
          if $browser == 'phantomjs'
            $b = Watir::Browser.new :phantomjs
          end
        end
      end
    end
      
    Browser.inst = $b
    $b.goto $site
  end
  
  

  
  describe 'Go to  Login screen' do
    
    it 'should click on Login button' do
      $b.a(:href, '/login').when_present.fire_event 'onclick'
    end    
  end
  
  describe 'Login as siteadmin' do
    
    it 'should enter username' do
      Login.username.when_present.send_keys('ankita@abc.com')
    end
    
    it 'should enter password' do
      Login.password.when_present.send_keys('ankita!')
    end
    
    it 'should click Login' do
      Login.login.fire_event 'onclick'
    end
  
    it 'should check if login successful else login with developer credentials' do
      sleep 6 #implicit wait - REFACTOR ME
      if !$b.a(:href, '/siteadmin/').exist?
        Login.username.when_present.send_keys('ankita@abc.com')
        Login.password.when_present.send_keys('IamTheBoss!')
        Login.login.fire_event 'onclick'
      end
    end
    
    it 'should click on Link' do
      $b.a(:href, '/siteadmin/').when_present.fire_event 'onclick'
    end
    
    it 'should click on details button' do
      @detail = $b.element(:xpath, "//table[@id='report-table']/tbody/tr[1]/td/ul/li/a[contains(.,'Details')]")
      @detail.when_present.fire_event 'onclick'
    end
    
   it 'should enable Site customisation checkbox' do
      $b.checkbox(:id, 'enable-site-customisation').wait_until_present
      $b.execute_script("$('#enable-site-customisation').attr('checked', 'checked');")
    end          
               

    it 'should add fee' do
      @mediafee = $b.element(:css, "div.well > div[data-demand-source-id='bad'] > div:nth-child(3) > div")
      @mediafee.text_field(:name, 'feeRate').wait_until_present
      @mediafee.text_field(:name, 'feeRate').focus
      @mediafee.text_field(:name, 'feeRate').when_present.set('11')
      @mediasave = $b.element(:css, "div.well > div[data-demand-source-id='bad'] > div:nth-child(3) > div > a")
      @mediasave.when_present.fire_event 'onclick'
      @mediasave.wait_while_present
    end        
    

    it 'should Activate  source' do
      @marketplace = $b.element(:css, "div.well > div[data-demand-source-id='bad'] > div > select.change-bad-source-state")
      @marketplace.option(:xpath, 'option[5]').when_present.select # Activated Drop down selection
    end
    

    it 'should Activate Source' do
      @salesrole = $b.element(:css, "div.well > div[data-demand-source-id='role'] > div > select.change-source-state")
      @salesrole.option(:xpath, 'option[5]').when_present.select # Activated Drop down selection
    end
       

    it 'should impersonate Login' do
      @impersonatelogin = $b.element(:xpath, "//div[@class='form-actions']/div/div/a[contains(.,'Login')]")
      @impersonatelogin.wait_until_present
      alert_message_text = $b.confirm(true) {@impersonatelogin.fire_event 'onclick'}
    end
        
    it 'should find dashboard tab ' do
      $b.div(:class, 'container navbar').ul.li.a(:href, '/dashboard').wait_until_present
    end
    
    after :all do
      screenshot 'Login_Status'
    end
  end

  # ---------------------------------------- #
  # * All the Test scripts would be here
  # ---------------------------------------- #
  describe 'All Test Scripts' do
    include_examples 'test'
  end

  # ---------------------------------------- #
  # * Log Off once after executing all the scripts
  # ---------------------------------------- #
  describe 'Logout' do 
    it 'should logout successfully' do
      if $b.a(:href, '/logout').exist?
        $b.a(:href, '/logout').fire_event 'onclick'
        Login.username.wait_until_present
      end
    end
  end
  
  
  after (:all) do
    $b.close
  end
end

