import twitter4j.*;
import twitter4j.http.*;
import twitter4j.auth.*;

class MarketingJob {
	static triggers = {
	    simple name: 'mySimpleTrigger3', startDelay: 60000, repeatInterval: 1000*60*60*240l  
	  }
    //def timeout = 1000*60*60*2l // execute job once in 2 hours

    def myTweetMarkService
    def twitterService
    
    def execute() {
    	System.out.println("Inside MarketingJob")
    	/*Date currentTime = new Date();
    	System.out.println("Job start time: " + currentTime.toString())
        // execute task
        
        def users = Users.findAllByStatus(1)
        
        if (users != null && !users.isEmpty()) {
        	for (int i=0; i<users.size(); i++) {
        		
				try {
					def promoTweet = "@" + users.get(i).userName + " please come checkout the NEW @mytweetmark and @homecookme, working #local #food #farmers #markets in #california."
					System.out.println(promoTweet)
					twitterService.updateStatusByUserIdPassword("mytweetmark", "formtek", promoTweet)
					Thread.sleep(300*1000)
				} catch (Exception e) {
					e.printStackTrace()
				}
        		
        	}
        } else {
        	System.out.println("Didn't find any users")
        }
    	*/
    	
    }
}
