require 'rubygems'
require 'rspec'
require 'watir-webdriver'
require 'watir-webdriver/wait'
require 'watir-webdriver/extensions/alerts'
require 'logger'
require '../helper.rb'

  
describe "Publisher TEST Suite" do
  before (:all) do
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120 #seconds – default is 60
    driver = Selenium::WebDriver.for :phantomjs, :http_client => client
    Watir::always_locate = true
    $b= Watir::Browser.new(driver)
    
    # ----------STEPS-------------------------------------------------------------- #
    # * Login once to the system using Sysadmin credentials
    # * After executing all the scripts - logout Once
    # ----------------------------------------------------------------------------- #
    $b.goto ENV["UI_TEST_URL"]
 
    begin
      $b.a(:href, '/login').wait_until_present(timeout = 30)
      $b.a(:href, '/login').when_present.fire_event 'onclick'
    rescue Exception => e
      Capture.screenshot 'Login_Failure'
      raise "Error: #{e}"
    end
      
    $log.info 'clicked on Login button'
    begin
      Login.login.wait_until_present(timeout = 30)
      Login.username.when_present.send_keys('ankita@abc.com')
      $log.debug 'User name added'
      Login.password.when_present.send_keys('ankita!')
      $log.debug 'Password added'
      Login.login.fire_event 'onclick'
      $log.debug 'clicked Login'
    rescue Exception => e
      Capture.screenshot 'Login_Failure'
      raise "Error: #{e}"
    end
    sleep 6 # implicit wait

    if !$b.a(:href, '/siteadmin/').exist?
      $log.info 'Login with badslot credential'
      Login.username.when_present.send_keys('ankita@abc.com')
      Login.password.when_present.send_keys('IamTheBoss!')
      Login.login.fire_event 'onclick'
      begin
        $b.a(:href, '/siteadmin/').wait_until_present(timeout = 30)
      rescue Exception => e
        Capture.screenshot 'Login_Failure'
        raise "Error: #{e}"
      end
    end
    
    begin
      $b.a(:href, '/siteadmin').wait_until_present(timeout = 30)
      rescue Exception => e
      Capture.screenshot 'Login_Failure'
      raise "Error: #{e}"
    end
    
    $b.a(:href, '/siteadmin/').fire_event 'onclick'
    $log.info 'clicked on Badslot link'
    sleep 4 #Implicit wait

    @detail = $b.element(:xpath, "//table[@id='report-table']/tbody/tr[1]/td/ul/li/a[contains(.,'Details')]")
    begin
      @detail.wait_until_present(timeout = 30)
    rescue Exception => e
      Capture.screenshot 'Login_Failure'
      raise "Error: #{e}"
    end
    @detail.when_present.fire_event 'onclick'
    $log.info 'Clicked on Details link to login'

    # ---------------------------------------- #
    # * Enable Site Customisation checkbox
  # ---------------------------------------- #
    begin
      $b.checkbox(:id, 'enable-site-customisation').wait_until_present(timeout = 30)
      $b.execute_script("$('#enable-site-customisation').attr('checked', 'checked');")
      $log.info 'Site customisation checkbox checked'
    rescue Exception => e
      Capture.screenshot 'Site_customisation_Failure'
      raise "Error: #{e}"
    end          
        
    begin
      $b.checkbox(:id, 'enable-create-store').wait_until_present(timeout = 30)  
      $b.execute_script("$('#enable-create-store').attr('checked', 'checked');")
      $log.info 'Bad Store checkbox checked'
    rescue Exception => e
      Capture.screenshot 'Enable_bad_store_Failure'
      raise "Error: #{e}"
    end
                
    begin
      $b.checkbox(:id, 'enable-payment-out-of-platform').wait_until_present(timeout = 30) 
      $b.execute_script("$('#enable-payment-out-of-platform').attr('checked', 'checked');")
      $log.info 'Payment Out of Platform checkbox checked'
    rescue Exception => e
      Capture.screenshot 'Enable_POP_Failure'
      raise "Error: #{e}"
    end
                
    # ---------------------------------------- #
    # * Add Fee Rate to bad Page  
   # ---------------------------------------- #
    @mediafee = $b.element(:css, "div.well > div[data-demand-source-id='MediaPage'] > div:nth-child(3) > div")

    sleep 2
    begin
      @mediafee.text_field(:name, 'feeRate').wait_until_present(timeout = 30)
      $log.debug 'Setting Fee Rate for bad Page as 11%'
      @mediafee.text_field(:name, 'feeRate').focus
      @mediafee.text_field(:name, 'feeRate').when_present.set('11')
      $log.info 'Added 11% fee for bad Page nd now to click on Save button'
    rescue Exception => e
      Capture.screenshot 'Enable_bad_Source_Failure'
      raise "Error: #{e}"
    end        

    @mediasave = $b.element(:css, "div.well > div[data-demand-source-id='MediaPage'] > div:nth-child(3) > div > a")

    begin
      @mediasave.wait_until_present(timeout = 30)
      @mediasave.fire_event 'onclick'
      $log.debug 'Clicking Save button'
      @mediasave.wait_while_present(timeout = 30)
      $log.info 'Clicked Save button to save custom fee for bad Page'
    rescue Exception => e
      Capture.screenshot 'Save_bad_Source_Fee_Failure'
      raise "Error: #{e}"
    end
        
    @marketplace = $b.element(:css, "div.well > div[data-demand-source-id='test'] > div > select.change-state")

    begin
      @marketplace.wait_until_present(timeout = 30)
      $log.debug 'Selecting Activated Drop down'
      @marketplace.option(:xpath, 'option[5]').select # Activated Drop down selection
      $log.info 'Selected Activated for bad Option'
      sleep 1
    rescue Exception => 'Enable_bad_Source_Failure'
      raise "Error: #{e}"
    end
        
    @salesrole = $b.element(:css, "div.well > div[data-demand-source-id='test'] > div > select.state")

    begin
      @salesrole.wait_until_present(timeout = 30)
      @salesrole.option(:xpath, 'option[5]').select # Activated Drop down selection
      $log.info 'Selected Activated for Option'
      sleep 1        
    rescue Exception => e
      Capture.screenshot 'Enable_Source_Failure'
      raise "Error: #{e}"
    end
       
    # ---------------------------------------- #
    @impersonatelogin = $b.element(:xpath, "//div[@class='form-actions']/div/div/a[contains(.,'Login')]")
    begin
      @impersonatelogin.wait_until_present(timeout = 30)
      alert_message_text = $b.confirm(true) {@impersonatelogin.fire_event 'onclick'}
      $log.info 'click on OK ... and Impersonate Login'
    rescue Exception => e
      Capture.screenshot 'Impersonate_Login_Failure'
      raise "Error: #{e}"
    end
        
    begin
      $b.div(:class, 'container navbar').ul.li.a(:href, '/dashboard').wait_until_present(timeout = 30)
    rescue Exception => e
      Capture.screenshot 'Impersonate_Login_Failure'
      raise "Error: #{e}"
    end
    $log.info 'Dashboard tab present'
    
  end
  
  describe "All Test Scripts" do
  
    # ---------------------------------------- #
    # * All the Test scripts would be here
    # ---------------------------------------- #
    it "Testing Dashboard" do
      require_relative "../test.rb"
    end

  end

    
  after  (:all) do
    # ---------------------------------------- #
    # * Log Off once after executing all the scripts
    # ---------------------------------------- #
    if $b.a(:href, '/logout').exist?
      $b.a(:href, '/logout').fire_event 'onclick'
      $log.info 'clicked LogOut'
      Login.username.wait_until_present(timeout = 30)
      if Login.username.exist?
        $log.info 'Logout successful'
      else
        $log.error "Error: #{e}"
      end
    end
    $log.info '---- TEST COMPLETED ----'
    $b.close
  end
end

