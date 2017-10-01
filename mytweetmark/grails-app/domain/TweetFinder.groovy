class TweetFinder {

	static transients = ["tweets"]
	Long id
	Date createTime
	Integer status
	List tweets
	Long userId
	String finder
	
	static constraints = {
		id(nullable:true)
		createTime(nullable:false)
		status(nullable:false)
		userId(nullable:false)
		finder(nullable:false)
	}
	
	static mapping = {
		version false
		table 'tweet_finder'
		id generator:'sequence', params:[sequence:'tweet_finder_seq']
	}
}
