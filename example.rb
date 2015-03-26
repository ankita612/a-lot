shared_examples 'test' do
  
  describe 'test' do  
    $b = Browser.inst
    
    it 'should has liveFilterButton button' do
      $b.div(:id, "liveFilterButton").wait_until_present
    end
  end
end

