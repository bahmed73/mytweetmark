<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">

  <head>
       
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="en-us" http-equiv="Content-Language" />
<meta http-equiv="Cache-Control" content="No-Cache" />

<meta name="description" content="Share your categorized business links and blogs on twitter!" />
<meta name="keywords" content="mytweetmark,mytweetmark.com,brand,share posts,post information,organize bookmarks,share bookmarks,share knowledge,organize bookmarks,categorize bookmarks,email bookmarks, share bookmarks and posts, share posts and bookmarks, share with friends,tweet,twitter" />
<meta http-equiv="window-target" content="_top" />
    <title id="page_title">mytweetmark.com / Share links and blogs on twitter!</title>
<LINK REL="SHORTCUT ICON"
       HREF="${createLinkTo(dir:'images', file:'mytweetmark-icon.ico')}">
<g:javascript library="scriptaculous" />    

<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'reset.css')}" />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'main-home.css')}" />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'post.css')}" />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'mytweetmark.css')}" />
    <style type="text/css">
      
        body {
  body { background: #9AE4E8 url('${user.backgroundUrl}') fixed no-repeat top left; }


a,
#content tr.hentry:hover a,
body#profile #content div.hentry:hover a,
#side .stats a:hover span.stats_count,
#side div.user_icon a:hover,
li.verified-profile a:hover,
#side .promotion .definition strong {
  color: #2FC2EF;
}

body,
ul#tabMenu li a, #side .section h1,
#side .stat a,
#side .stats a span.stats_count,
#side div.section-header h1,
#side div.user_icon a,
#side div.user_icon a:hover,
#side div.section-header h3.faq-header,
ul.sidebar-menu li.active a,
li.verified-profile a,
#side .promotion a {
  color: #666666;
}

#side_base {
  border-left:1px solid #181A1E;
  background-color: #252429;
}

ul.sidebar-menu li.active a,
ul.sidebar-menu li a:hover,
#side div#custom_search.active,
#side .promotion,
.notify div {
  background-color: #3D3C41;
}

#side .actions,
#side .promo {
  border: 1px solid #181A1E;
}

#side div.section-header h3 {
  border-bottom: 1px solid #181A1E;
}

#side hr {
  background: #181A1E;
  color: #181A1E;
}

ul.sidebar-menu li.loading a {
  background: #3D3C41 url('http://a1.twimg.com/a/1250103249/images/spinner.gif') no-repeat 171px 0.5em !important;
}

#side .collapsible h2.sidebar-title {
  background: transparent url('http://a2.twimg.com/a/1250103249/images/toggle_up_light.png') no-repeat center right !important;
}

#side .collapsible.collapsed h2.sidebar-title {
  background: transparent url('http://a1.twimg.com/a/1250103249/images/toggle_down_light.png') no-repeat center right !important;
}      
      
    </style>
    
  </head>

  <body class="timeline firefox-windows" id="home">    
<div id="fb-root"></div>
<script>
  // Additional JS functions here
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '216791399738', // App ID
      channelUrl : '//www.mytweetmark.com/images/channel.html', // Channel File
      status     : true, // check login status
      cookie     : true, // enable cookies to allow the server to access the session
      xfbml      : true  // parse XFBML
    });

    // Additional init code here

	FB.getLoginStatus(function(response) {
	  if (response.status === 'connected') {
	    // connected
	    doNothing()
	  } else if (response.status === 'not_authorized') {
	    // not_authorized
	    doNothing()
	  } else {
	    // not_logged_in
	    doNothing()
	  }
	 });
  };

  // Load the SDK Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
   }(document));
   
   function verifyFBLogin() {
    FB.login(function(response) {
        if (response.authResponse) {
            // connected
            onConnect()
        } else {
            // cancelled
            doNothing()
        }
    });
	}

	function doNothing() {
	}
	
	function onConnect() {
    	FB.api('/me?fields=id, name, username, first_name, last_name, picture', function(response) {
        	var url = "/users/handleFacebook?userName="+response.username+"&firstName="+response.first_name+"&lastName="+response.last_name+"&profilePhoto="+response.picture.data.url+"&facebookUid="+response.id
            parent.window.location = url
        });
    }
		
	function onLogout() {
	<g:if test="${session.userName!=null}">
	<g:if test="${session.fuid!=null}">
		FB.logout(function(response) {
  		// user is now logged out
  		parent.window.location = "/"
		});
	</g:if>
	</g:if>
	}
</script>
<div style="background-image:url('${user.backgroundUrl}');">
    <div id="header">
	
	<div id="top-nav">
		<div id="nav-login" style="float:left;width:500px;">
		
		<g:if test="${flash.message}">
			<div id="fade_message" style="width:500px; height:20px; background:#c5e2f8; border:1px solid #ddffcc;">${flash.message}</div>
            </g:if>
		
		
      
	</div>
		</div>
</div>
<br>

<div id="main">
<g:render template="/common/navBar"/>

      
                  
        <div style="float:left;width:986px;background-color:<g:if test='${user.color}'>#${user.color}</g:if><g:else>#ffffff</g:else>;margin: 10px auto 10px;border:2px solid #E0F0FB;">
         <br class="clear"/>   
          <br class="clear"/>   
        
        	<br>
			<div class="rounded" style="float:right;width:250px;text-align:left;background-color:#000000;border:2px solid #E0F0FB;background-image:url(${createLinkTo(dir:'images', file:'black-Linen.png')});">
			<div style="margin:3px;">
			<!--
			<div style="float:left;width:250px;text-align:center;">
	  			<h4>Quick Tip:</h4>
	  			Create a # hashtag that describes your business, e.g. farmersmarket.<br>  
	  			</div>
	  		<br>
	  		<g:form method="post" url="[action:'saveMyHash',controller:'myHash']">
			          <input maxlength="30" size="11" type="text" name="hash" value="${myHash}">
				
				<g:actionSubmit value="Hashtag" action="saveMyHash"/>
				</g:form>
				upto 30 characters.
				<br>
			-->		
			<div style="float:center;width:250px;text-align:center;">
	  			<br>
	  			<h4><g:link url="[action:'list',controller:'autoTweet']">Configure Auto Tweets.</g:link></h4>  
	  			</div>
	  			
	  			
				
				
	  			<div style="float:center;width:250px;text-align:center;">
	  			<br><br>
	  			<g:link url="[action:'unFollowers',controller:'myTweetMark']"><img src="${createLinkTo(dir:'images', file:'unfollowers.png')}" title="Unfollowers"/></g:link> <br>
	  			<g:link url="[action:'unFollowers',controller:'myTweetMark']">Unfollow</g:link> users that are not following back 
	  			</div>
	  			
	  			<div style="float:center;width:250px;text-align:center;">
	  			<br class="clear"/>
				<object width="112" height="100"><param name="movie" value="http://www.youtube.com/v/fkNuQy1zoiI&hl=en&fs=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/fkNuQy1zoiI&hl=en&fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="112" height="100"></embed></object><br>
				</div>
				
				<div style="float:center;width:250px;text-align:center;">
	  			<br>
	  			
			  <g:form method="post" url="[action:'searchMyTweetmarks',controller:'myTweetMark']">
			  <div style="width:125px;margin:7px;">
			          <input type="text" name="search" value="">
			  </div>
				<div>
				<br>
				<g:actionSubmitImage value="Search" action="searchMyTweetmarks" src="${createLinkTo(dir:'images',file:'search-new.png')}"/>
				</div>
			  </g:form>
			  
			  <br>
			  <br>
			  <h4>Toggle Automatic Tweets</h4>
			  <g:if test="${autoTweet==0}">
				<div style="float:center;width:250px;text-align:center;">
				
				  <g:link action="autoTweetOn" controller="users">
					            		<img src="${createLinkTo(dir:'images', file:'bluebutton_autotweeton.png')}" title="Start sending auto tweets"/>
					            	</g:link>
					            	
				</div>
				</g:if>
				<g:else>
				<div style="float:center;width:250px;text-align:center;">
				  <g:link action="autoTweetOff" controller="users">
					            		<img src="${createLinkTo(dir:'images', file:'bluebutton_autotweetoff.png')}" title="Stop sending auto tweets"/>
					            	</g:link>
					            	
					            	
				</div>
				</g:else>  
				
				<br class="clear"/>   
          		<br class="clear"/>  
				<h4>Toggle Regular Tweets</h4>
				<g:if test="${displaySend==0}">
				<div style="float:center;width:250px;text-align:center;">
				
				  <g:link action="sendMyTweets" controller="users">
					            		<img src="${createLinkTo(dir:'images', file:'bluebutton_tweeton.png')}" title="Start sending my tweets on actions"/>
					            	</g:link>
					            	
				</div>
				</g:if>
				<g:else>
				
				<div style="float:center;width:250px;text-align:center;">
				  <g:link action="dontSendMyTweets" controller="users">
					            		<img src="${createLinkTo(dir:'images', file:'bluebutton_tweetoff.png')}" title="Stop sending tweets on actions"/>
					            	</g:link>
					            	
				</div>
				</g:else>  
			    
			    
			    
				
				<br><br>
				
				<!--
	  			<div style="float:center;width:250px;text-align:center;">
	  			<br><br>
	  			<g:link url="[action:'calculateFriends',controller:'tweetFriend']"><img src="${createLinkTo(dir:'images', file:'exportcontacts.png')}" title="Export business contacts"/></g:link> <br>
	  			Export <g:link url="[action:'list',controller:'tweetFriend']">business contacts</g:link> from Twitter feeds 
	  			</div>
	  			
	  			<div style="float:center;width:250px;text-align:center;">
	  			<br>
	  			Monitor search terms and people by <g:link url="[action:'list',controller:'tweetFinder']">Tweet Finder.</g:link>  
	  			</div>
	  			-->
	  			
			</div>
	  		</div>	
	  		</div>
        
        
        <g:render template="/common/miniProfile"/>
        <g:render template="/common/profile"/>
        </div>
                        
      
  <div id="footer" >
    
    <g:render template="/common/footer"/>
  </div>



      <hr />

</div>    
    <div id="notifications"></div>
    </div>
<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-10124777-1");
pageTracker._trackPageview();
} catch(err) {}</script>

<g:facebookConnectJavascript base="http://www.mytweetmark.com" />
  </body>

</html>
