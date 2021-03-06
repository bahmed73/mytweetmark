//deprecated, do not use

class Viral {
	Long id
	Date createTime
	Date updateTime
	Integer lastTimeAddressImported
	Integer totalAddressImported
	Integer lastInvitesSent
	Integer totalInvitesSent
	Integer totalInvitesOpened
	Integer totalInvitesClicked
	Integer totalInvitesAccepted
	
	static constraints = {
		id(nullable:false)
		createTime(nullable:false)
		updateTime(nullable:false)
		lastTimeAddressImported(nullable:true)
		totalAddressImported(nullable:true)
		lastInvitesSent(nullable:true)
		totalInvitesSent(nullable:true)
		totalInvitesOpened(nullable:true)
		totalInvitesClicked(nullable:true)
		totalInvitesAccepted(nullable:true)
		
	}
	
	static mapping = {
		version false
		table 'users_viral'
	}
}
