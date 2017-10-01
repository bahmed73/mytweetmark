class Link {

	Long id
	String url
	Date createTime
	
	static constraints = {
		id(nullable:true)
		url(nullable:false)
		createTime(nullable:false)
	}
	
	static mapping = {
		version false
		table 'link'
		id generator:'sequence', params:[sequence:'link_seq']
	}
}
