<div class="rounded" style="float:left;width:990px;background-color:#ffffff;height:100px;border:2px solid #E0F0FB;">
			<div style="float:left;width:300px;">
        	<a href="http://www.mytweetmark.com" title="Go to home page"><img src="${createLinkTo(dir:'images',file:'mytweetmark-logo.jpg')}"/></a>
        	</div>
        	<g:if test="${session.userName!=null}">
        		<g:link url="[action:'unFollowers',controller:'myTweetMark']"><img border="0" src="${createLinkTo(dir:'images', file:'mUnfollowers.jpg')}" title="Unfollowers"/></g:link>&nbsp;&nbsp;
        		<!--<g:link url="[action:'userTweetMarks',controller:'myTweetMark']"><img border="0" src="${createLinkTo(dir:'images', file:'mView.jpg')}" title="View"></g:link>&nbsp;&nbsp;-->
	          	<g:link url="[action:'myTweetMarks',controller:'myTweetMark']"><img border="0" src="${createLinkTo(dir:'images', file:'mProfile.jpg')}" title="Profile"></g:link>&nbsp;&nbsp;
	          	<g:link url="[action:'create',controller:'blog']"><img border="0" src="${createLinkTo(dir:'images', file:'mCreateBlog.jpg')}" title="Create Blog"></g:link>&nbsp;&nbsp;
	          	<g:link url="[action:'analytics',controller:'myTweetMark']"><img border="0" src="${createLinkTo(dir:'images', file:'mAnalytics.jpg')}" title="Analytics"></g:link>&nbsp;&nbsp;
	          	<g:link url="[action:'list',controller:'autoTweet']"><img border="0" src="${createLinkTo(dir:'images', file:'mAutoTweet.jpg')}" title="Auto Tweet"></g:link>&nbsp;&nbsp;
	          	<g:link url="[action:'edit',controller:'users']"><img border="0" src="${createLinkTo(dir:'images', file:'mSettings.jpg')}" title="Settings"></g:link>&nbsp;&nbsp;
	          	<g:link url="[action:'logout',controller:'users']" onClick="onLogout();"><img border="0" src="${createLinkTo(dir:'images', file:'mSignOut.jpg')}" title="Sign Out"></g:link>
        	</g:if>
        	<g:else>
        	<div style="float:left;width:550px;font-size:14px;margin:15px;border:0px solid #E0F0FB;background-color:#ffffff;">
        	<b>Create blogs and auto tweets. Analytics. Unfollow users that do not follow back. Go to <a href="/">Home.</a> </b> 
        	       
        	</div>
        	</g:else>
        	<br class="clear"/>
</div>