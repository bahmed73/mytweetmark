import twitter4j.*;
import twitter4j.http.*;
import twitter4j.auth.*;

class AutoTweetJob {
	static triggers = {
	    simple name: 'mySimpleTrigger', startDelay: 300000, repeatInterval: 1000*60*60*240l, repeatCount:0  
	  }
    //def timeout = 1000*60*60*2l // execute job once in 2 hours

    def myTweetMarkService
    def twitterService
    
    def execute() {
    	System.out.println("Inside AutoTweetJob")
    	Date currentTime = new Date();
    	System.out.println("Job start time: " + currentTime.toString())
        // execute task
        
        while (1) {
        	try {
		        def autoTweets = AutoTweet.findAllByStatus(1)
		        
		        if (autoTweets != null && !autoTweets.isEmpty()) {
		        	java.util.Random randomGenerator = new java.util.Random()
		        	int randomInt = randomGenerator.nextInt(autoTweets.size())
		        	System.out.println("Now processing auto tweet: " + randomInt)
		        	def user = myTweetMarkService.getUser(autoTweets.get(randomInt).userId)
		        	
		        	if (user != null && user.autoTweet!=null && user.autoTweet == MyTweetMarkService.ON) {
		        		System.out.println("Now processing username: " + user.userName)
		        		System.out.println("Now processing tweet: " + autoTweets.get(randomInt).tweet)
		        		try {
		        			Twitter twitter = twitterService.getTwitterWithOauth(user.userName)
		        			if (twitter != null) {
		        				def status = autoTweets.get(randomInt).tweet
		        				
		        				try {
		        		        	if (status.contains("http")) {
		        		        		if (!status.contains("mytweetmark")) {
		        		        			def index = status.indexOf("http")
		        		        			if (index > -1) {
		        		        				def firstPart = status.substring(0, index)
		        		        				def secondPart = status.substring(index)
		        		        				
		        		        				def index2 = secondPart.indexOf(" ")
		        		        				def link = ""
		        		        				
		        		        				if (index2 > -1) {
		        		        					link = secondPart.substring(0, index2)
		        		        					secondPart = secondPart.substring(index2)
		        		        				} else {
		        		        					link = secondPart
		        		        					secondPart=""
		        		        				}
		        		        				
		        		        				def newLink = new Link()
		        		        				newLink.url = link
		        		        				newLink.createTime = new Date()
		        		        				
		        		        				if  (!newLink.hasErrors() && newLink.save()) {
		        		                  			link = "http://www.mytweetmark.com/link/"+newLink.id
		        		                  			status = firstPart + link + secondPart
		        		                  		} 
		        		        				
		        		        			}
		        		        		}
		        		        	}
		        	        	} catch (Exception eT) {
		        	        		eT.printStackTrace()
		        	        		System.out.println("Error setting redirect link")
		        	        	}
		        	        	while (status.length() > 140) {
		        					if (status.contains("http")) {
		        						def index = status.indexOf("http")
		        	        			if (index > -1) {
		        	        				if (index > 70) {
		        	        					def part1 = status.substring(0, 48)+ ".. "
		        	        					def part2 = status.substring(68)
		        	        					if (part2.contains(" ")) {
		        	        						def index2 = part2.indexOf(" ")
		        	        						part2 = part2.substring(index2+1)
		        	        					}
		        	        					status = part1 + part2
		        	        					
		        	        				} else {
		        	        					status = status.substring(0, 138)+".."
		        	        				}
		        	        			}
		        					} else {
		        						status = status.substring(0,138)+".."
		        					}
		        					
		        				}
		        				twitter.updateStatus(status)
		        			}
	    					Thread.sleep(900*1000)
	    				} catch (Exception e) {
	    					e.printStackTrace()
	    					Thread.sleep(900*1000)
	    				}
		        	}
		        }
        	} catch (Exception esp) {
        		esp.printStackTrace()
        		Thread.sleep(900*1000)
        	}
        }
        
    }
}
