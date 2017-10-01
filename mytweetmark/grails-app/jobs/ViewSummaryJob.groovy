import twitter4j.*;
import twitter4j.http.*;
import twitter4j.auth.*;

class ViewSummaryJob {
	static triggers = {
	    simple name: 'mySimpleTrigger2', startDelay: 60000, repeatInterval: 1000*60*60*24l, repeatCount:0    
	  }
    //def timeout = 1000*60*60*2l // execute job once in 2 hours

    def myTweetMarkService
    def twitterService
    def mailService
    
    def execute() {
    	System.out.println("Inside ViewSummaryJob")
    	
    	Date currentTime = new Date();
    	System.out.println("Job start time: " + currentTime.toString())
        // execute task
        
        
        while (1) {
        	def views = Views.findAll()
            
	        if (views != null && !views.isEmpty()) {
	        	for (int i=0; i<views.size(); i++) {
	        		try {
		        		ViewSummary summary = new ViewSummary()
		        		summary.userId = views.get(i).userId
		        		summary.createTime = new Date()
		        		summary.num = views.get(i).num
		        		
		        		def user = myTweetMarkService.getUser(summary.userId)
		        		Twitter twitter = null
		        		
		        		if (user != null) {
		        			
		        			twitter = twitterService.getTwitterWithOauth(user.userName)
		        			System.out.println("Processing user: " + user.userName)
		        			if (twitter != null) {
			        			User twitterUser = twitter.showUser(user.userName)
			        			
			        			if (user.facebookUid==null) {
			        				if (twitterUser != null) {
			        					summary.followersCount = twitterUser.getFollowersCount()
			          			  		summary.friendsCount = twitterUser.getFriendsCount()
			          			  		
			          			  		user.backgroundUrl = twitterUser.getProfileBackgroundImageUrl().toString()
			          			  		user.profilePhoto = twitterUser.getProfileImageURL().toString()
			          			  		user.followersCount = twitterUser.getFollowersCount()
			          			  		user.friendsCount = twitterUser.getFriendsCount()
			          			  		
			          			  		if  (user.hasErrors() || !user.save()) {
			          			  			System.out.println("Error storing user data, userid:" + views.get(i).userId)
			          			  		}
			          			  		
			        				}
			        			} 
		        			}
		        		}
		        		
		        		
		        		if  (summary.hasErrors() || !summary.save()) {
		        			System.out.println("Error storing summary data userid:" + views.get(i).userId)
		        		}
		        		if (user != null) {
		        			if (twitter == null) {
		        				twitter = twitterService.getTwitterWithOauth(user.userName)
		        			}
			        		if (user.emailReport != null) {
			        			if (user.emailReport == MyTweetMarkService.ON) {
			        				List mentions = twitter.getMentions()
			        				List messages = twitter.getDirectMessages()
				        			//let email it
				        			mailService.sendMail {
									   to user.email
									   subject "Daily Mytweetmark Metrics Report"
									   html myTweetMarkService.getEmailReportStats(summary, mentions, messages)
									}
			        			}
			        		}
		        		}
	        		} catch (Exception e) {
	        			e.printStackTrace()
	        		}
	        	}
	        } else {
	        	System.out.println("Didn't find any views")
	        }
        	Thread.sleep(86400*1000)
        }
    }
}
