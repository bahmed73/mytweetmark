<td id="side_base" class="column round-right">
                                  
                  <div id="side">
                      <div id="profile" class="section">
                              
</div>

<p class="promotion round" style="font-size:9px" >
  <b>mytweetmark.com/${userName}</b><br> 
</p>

<g:if test="${session.profile==false}">

<g:if test="${isFaceBookUser == 0}">
<p class="promotion round" style="font-size:9px" >
Create instant blog by importing your tweets, finding bookmarks and friends! 
<br>
<br>
<g:link url="[action:'calculateUrls',controller:'tweetUrl']"><img src="${createLinkTo(dir:'images', file:'feedbookmark.gif')}" title="Analyze my tweets for bookmarks"/></g:link>
<g:link url="[action:'calculateFriends',controller:'tweetFriend']"><img src="${createLinkTo(dir:'images', file:'feedfriends.gif')}" title="Analyze my tweets for friends"/></g:link>
</p>
<br> 
</g:if>			
			
<div>
  <g:form method="post" url="[action:'saveMyHash',controller:'myHash']">
  <div class="promotion round">
          <b>Custom hashtag #</b>: <input type="text" name="hash" value="${myHash}">
  </div>
	<div>
	<br>
	<g:actionSubmit class="flow-button green-arrow-small" value="Hashtag" action="saveMyHash"/>
	</div>
  </g:form>
  <br>
  <hr/>


<div>
<g:if test="${displaySend==0}">
<div class="promotion round" style="align:center;width:150">
  <g:link action="sendMyTweets" controller="users">
	            		<img src="${createLinkTo(dir:'images', file:'turnon.gif')}" title="Send my tweets or feeds"/>
	            	</g:link>
Tweets/feeds currently off

</div>
</g:if>
<g:else>
<div class="promotion round" style="float:center">
  <g:link action="dontSendMyTweets" controller="users">
	            		<img src="${createLinkTo(dir:'images', file:'turnoff.gif')}" title="Don't send my tweets or feeds"/>
	            	</g:link>
Tweets/feeds currently on

</div>
</g:else>  
<br>
  <hr/>

<g:if test="${isFaceBookUser == 0}">


<div>
<g:if test="${autoTweet==0}">
<div class="promotion round" style="align:center;width:150">
  <g:link action="autoTweetOn" controller="users">
	            		<img src="${createLinkTo(dir:'images', file:'turnon.gif')}" title="Send tweet randomly from a category every two hours for traffic"/>
	            	</g:link>
<br>Auto tweets currently off.  Please make sure to set your password in edit section.

</div>
</g:if>
<g:else>
<div class="promotion round" style="float:center">
  <g:link action="autoTweetOff" controller="users">
	            		<img src="${createLinkTo(dir:'images', file:'turnoff.gif')}" title="Stop sending auto tweets"/>
	            	</g:link>
<br>Auto tweets currently on.  Please make sure to set your password in edit section.

</div>
</g:else>  

<div>
  <g:form method="post" url="[action:'statusUpdate',controller:'users']">
  <div class="promotion round" style="float:center">
          <b>twitter update</b>: <input type="text" name="update" value="">
  </div>
	<div>
	<br>
	<g:actionSubmit class="flow-button green-arrow-small" value="Update" action="statusUpdate"/>
	</div>
  </g:form>
  <br>
  <hr/>
</div>
</g:if>
</g:if>  


<div>
<b>All previous hashtags:</b><br>
<g:each in="${myHashes}" status="i" var="hash">
<br> 
<g:if test="${session.userId==hash.userId}">
<g:link action="deleteMyHash" controller="myHash" params="[id: hash.id]">
                    		<img src="${createLinkTo(dir:'images', file:'cross.png')}" width="10" height="10" title="Remove Hash"/>
                    	</g:link>
</g:if> &nbsp;
<a href="http://www.wefollow.com/twitter/${hash.hash}">${hash.hash}</a>
</g:each>
<br class="clear"/> 
</div>

<br>
<hr/>

<g:if test="${isFaceBookUser == 0}">
<script src="http://widgets.twimg.com/j/2/widget.js"></script>
<script>
new TWTR.Widget({
  version: 2,
  type: 'profile',
  rpp: 4,
  interval: 6000,
  width: 198,
  height: 300,
  theme: {
    shell: {
      background: '#59cdf7',
      color: '#ffffff'
    },
    tweets: {
      background: '#ddffcc',
      color: '#333333',
      links: '#0084b4'
    }
  },
  features: {
    scrollbar: false,
    loop: false,
    live: false,
    hashtags: true,
    timestamp: true,
    avatars: false,
    behavior: 'all'
  }
}).render().setUser('${userName}').start();
</script>
</g:if>
<div>
   
  <g:form method="post" url="[action:'searchMyTweetmarks',controller:'myTweetMark']">
  <div class="promotion round">
          <b>Search</b>: <input type="text" name="search" value="">
  </div>
	<div>
	<br>
	<g:actionSubmitImage value="Search" action="searchMyTweetmarks" src="${createLinkTo(dir:'images',file:'search-new.png')}"/>
	</div>
  </g:form>
  <hr/>
  <br>
</div>
  
<g:if test="${session.profile==false}">
<div>
  <hr/>
  
  <g:form method="post" url="[action:'emailMyTweetMarks',controller:'users']">
  <div class="promotion round" style="font-size:8px">
	
          If you want a copy of myTweetMarks emailed to you, please click below.<br><br>
  </div>
	<div>
	<g:actionSubmit class="flow-button green-arrow-small" value="Email me" action="emailMyTweetMarks"/>
	</div>
  </g:form>

</div>

<!--
<div>
  <hr/>
  
  <g:form method="post" url="[action:'invite',controller:'users']">
  <div class="promotion round" style="font-size:8px">
		Click below to import your email address book and email your friends.<br><br>
		<img src="${createLinkTo(dir:'images',file:'yahoo-logo.gif')}" width="70" height="30">
		<img src="${createLinkTo(dir:'images',file:'gmail-logo.gif')}" width="70" height="30"><br>
		<img src="${createLinkTo(dir:'images',file:'hotmail-logo.gif')}" width="70" height="30">
		<img src="${createLinkTo(dir:'images',file:'aol-logo.gif')}" width="70" height="30"><br><br>
          <b>Your Email</b>: <input type="text" name="email" value="">
    
	<b>Password</b>: <input type="password" name="password" value="">
  </div>
	<div>

	<g:actionSubmit class="flow-button green-arrow-small" value="Share" action="invite"/>
	</div>
  </g:form>

  <hr/>
</div>
-->
</g:if>
<script type="text/javascript"><!--
google_ad_client = "pub-6710235735393070";
/* 160x600, created 3/6/10 */
google_ad_slot = "1321537492";
google_ad_width = 160;
google_ad_height = 600;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>

    <div id="saved_searches" class="collapsible"
    
       style="display:none;">
      <h2 class="sidebar-title" id="ss_menu"><span>Saved Searches</span></h2>
      <ul class="sidebar-menu saved-search-links">
      
      </ul>
      <hr/>
      </div>

  

      
    <div id="trends" class="collapsible">

      
        
      
    </div>
  

<g:if test="${session.profile==true}">
<div class="promotion round" style="align:center">
<b>Retweet:</b>
<br>
  <script type="text/javascript" src="http://tweetmeme.com/i/scripts/button.js"></script>
<hr/>
  <br>
<b>Share on facebook:</b>
<br>
<a name="fb_share" type="button_count" href="http://www.facebook.com/sharer.php">Share</a><script src="http://static.ak.fbcdn.net/connect.php/js/FB.Share" type="text/javascript"></script>
</div>
</g:if>

                  </div>
                                </td>