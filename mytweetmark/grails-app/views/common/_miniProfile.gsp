<div class="rounded" style="float:left;width:700px;margin-left:20px;text-align:left;border:3px solid #E0F0FB;background-image:url('${user.backgroundUrl}');">
<div style="margin-left:100px;margin-top:50px;margin-bottom:50px;border:1px solid #E0F0FB;width:500px;background-color:#000000;">
<div style="margin:20px;">
        <g:if test="${user}">
	        <g:if test="${user.profilePhoto}">
	        <div style="float:left;width:60px;">
	        <img src="${user.profilePhoto}" width="48" height="48" class="profile_border">    
	        </div>
	        </g:if>
        
	        <g:if test="${isFaceBookUser == 0}">
			    <div style="float:left;width:500px;">
			    <h3><a href="http://www.twitter.com/${user.userName}" target="_blank">${user.userName}</a></h3>
			    </div>
			    <br>
			    <div style="float:left;width:400px;">
			    Followers: ${user.followersCount}
			    </div>
			    <br>
			    <div style="float:left;width:400px;">
			    Following: ${user.friendsCount}
			    </div>
			    
		    </g:if>
	    	
	    	<g:if test="${user.businessName}">
		    <div style="float:left;width:400px;font-size:16px;">
		    <h4>${user.businessName}</h4>
		    </div>
		    </g:if>
		    
		    <g:if test="${user.businessPhone}">
		    <div style="float:left;width:400px;">
		    ${user.businessPhone}
		    </div>
		    </g:if>
		    <br>
		    <g:if test="${user.businessAddress}">
		    <div style="float:left;width:400px;">
		    ${user.businessAddress}
		    </div>
		    </g:if>
		    <br>
	        <g:if test="${user.lastName}">
	        <div style="float:left;width:400px;">
	        <g:if test="${user.firstName}">
	        <b>${user.firstName}</b>
	        </g:if>
	        &nbsp;<b>${user.lastName}</b>
	        </div>
	        </g:if>
            
	    	<br>
		    
		    <div style="float:left;width:400px;">
		    <b>Page views: ${views}</b>
		    </div>
		    
		    
		    <br>
		    <g:if test="${pageViewChange}">
		    <div style="float:left;width:400px;">
		    Daily change: ${pageViewChange} views
		    </div>
		    </g:if>
	    
	    	<br>
		    <g:if test="${pageViewChangePercentage}">
		    <div style="float:left;width:400px;">
		    Daily Change %: <g:formatNumber number="${pageViewChangePercentage}" type="number" maxFractionDigits="2" />
		    </div>
		    </g:if>
	    
	    	<br>
	        <g:if test="${user.aboutMe}">
	        <div style="float:left;width:400px;">
	        About Me: ${user.aboutMe}
	        </div>
	        </g:if>
	        
	    	<br>
	        <g:if test="${user.website}">
	        <div style="float:left;width:400px;">
	        <b><a href="${user.website}" target="_blank">${user.website}</a></b>
	        </div>
	        </g:if>
        
        	<br>
	        <g:if test="${user.blog}">
	        <div style="float:left;width:400px;">
	        <b><a href="${user.blog}" target="_blank">${user.blog}</a></b>
	        </div>
	        </g:if>
	        
	        <br>
	        
	        <br class="clear"/>
	        <br>
	        
	        <div class="fb-share-button" data-href="http://www.mytweetmark.com/${user.userName}" data-type="button"></div>
	        <br>
	        <br>
	        
	        <a href="http://www.mytweetmark.com/${user.userName}" class="twitter-share-button" data-lang="en" data-count="none">Tweet</a>
			<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script> 
			
	        <br class="clear"/>
	        
		    
        </g:if>
        </div>
        </div>
        </div>
        
        