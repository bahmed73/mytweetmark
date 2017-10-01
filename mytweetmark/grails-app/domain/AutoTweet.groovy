class AutoTweet {
	static searchable = true
	Long id
	Date createTime
	Integer status
	String tweet
	Long userId
	
	static constraints = {
		id(nullable:true)
		createTime(nullable:false)
		status(nullable:false)
		tweet(nullable:false)
		userId(nullable:false)
	}
	
	static mapping = {
		version false
		table 'auto_tweet'
		id generator:'sequence', params:[sequence:'auto_tweet_seq']
	}
}
