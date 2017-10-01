<div style="float:left;margin:40px;">
	
	<div style="float: left;">
			  <br>
			  <br>
			  <g:form method="post" url="[action:'searchMyTweetmarks',controller:'myTweetMark']">
			  <div>
			          <b>Search</b>: <input type="text" name="search" value="">
			  </div>
				<div>
				<br>
				<g:actionSubmitImage value="Search" action="searchMyTweetmarks" src="${createLinkTo(dir:'images',file:'search-new.png')}"/>
				</div>
			  </g:form>
			  <br>
			  <br>
			</div>
    
    <br class="clear"/>
    <g:each in="${searchResults}" status="i" var="result">
        <div style="float:left;width:50">
        	<g:if test="${result.profilePhoto}">
        	<g:link url="/$result.userName">
        	<img src="${result.profilePhoto}" 
        	<g:if test="${result.facebookUid}">
        	width="48" height="48" 
        	</g:if>
        	class="profile_border"> 
        	</g:link>
        	&nbsp;
        	</g:if>
        	<g:link url="/$result.userName">${result.userName}</g:link> &nbsp;
        </div>
        
        <g:if test="${result.aboutMe}">
    	<br>
    	<div style="float:left;width:600px">
    	<i>${result.aboutMe}</i> 
    	</div>
    	</g:if>
    	
    	
        <br class="clear"/>
        <div class="update-separator-grey">&nbsp;</div>
    </g:each>
    <br class="clear"/>
</div>
