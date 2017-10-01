<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">

  <head>
       
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="en-us" http-equiv="Content-Language" />
<meta http-equiv="Cache-Control" content="No-Cache" />

<meta name="description" content="Helps your business on Twitter.  Create your brand content, tweet through us and watch the page views grow through the analytics." />
<meta name="keywords" content="mytweetmark,mytweetmark.com,brand,share posts,post information,organize bookmarks,share bookmarks,share knowledge,organize bookmarks,categorize bookmarks,email bookmarks, share bookmarks and posts, share posts and bookmarks, share with friends,tweet,twitter" />
<meta http-equiv="window-target" content="_top" />
    <title id="page_title">${user.userName}</title>
<LINK REL="SHORTCUT ICON"
       HREF="${createLinkTo(dir:'images', file:'mytweetmark-icon.ico')}">
<g:javascript library="scriptaculous" />    

<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'reset.css')}" />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'main-home.css')}" />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'post.css')}" />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'mytweetmark.css')}" />
    <style type="text/css">
      
        body {
  body { background-image: url('${user.backgroundUrl}'); }


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
          <div class="rounded" style="float:right;width:250px;text-align:left;background-color:#000000;border:2px solid #E0F0FB;background-image:url(${createLinkTo(dir:'images', file:'black-Linen.png')});">
			<div style="margin:3px;">   
        
        <div style="float:left;width:250px;text-align:center;">
	  			<h4>Quick Tip:</h4>
	  			<div style="margin:3px;">
	  			With mytweetmark, create blogs and auto tweets. We provide you analytics for your visitor traffic. Also, unfollow users that do not follow back.<br>  
	  			</div>
	  			</div>
	  		<br>
	  		<br>
        <div style="float:left;width:250px;text-align:center;">
	                    <g:link action="analytics" controller="myTweetMark" id="${user.userName}">
	            			<h2>Analytics&nbsp;&raquo;</h2>
	            		</g:link>
                    </div>
            <!--             
			<g:if test="${tweetFriends}">
	        <h3>Business contacts</h3>	
	        People you talk to on twitter.<br><br>        
	        <g:each in="${tweetFriends}" status="j" var="tweetInstance">
					
	                	<div style="float:left;width:200px;text-align:left;">  
	                		<a href="http://www.twitter.com/${tweetInstance.friendName}" target="_blank"><img src="${tweetInstance.profilePhoto}" width="30" height="30" class="profile_border"> </a> <a href="http://www.twitter.com/${tweetInstance.friendName}" target="_blank">${tweetInstance.friendName}</a>
	                 	</div>
	        			<br><br>
	                </g:each> 
	        </g:if>
	        -->
	        <br>
	  		<br>
	    <div style="float:left;width:250px;text-align:center;">
	  			<h4>Visit homecook.me</h4>
	  			<a href="http://www.homecook.me" title="Go to homecook.me"><img src="${createLinkTo(dir:'images',file:'homecook-new-logo-150.png')}"/></a>
	  			</div>
	  	<br>
	  		<br>
	    <div style="float:left;width:250px;text-align:center;">
	  			<h4>Visit drspirit.com</h4>
	  			<a href="https://twitter.com/drspiritcom" title="Go to drspirit.com"><img src="${createLinkTo(dir:'images',file:'drsprit-logo.jpg')}"/></a>
	  			</div>
	  					
	  	<br>
	  		<br>
	    <div style="float:left;width:250px;text-align:center;">
	  			<h4>Visit bilalahmed.org</h4>
	  			<a href="https://twitter.com/bahmed73" title="Go to bilalahmed.org"><img src="${createLinkTo(dir:'images',file:'drspirit_bilal_150.jpg')}"/></a>
	  			</div>
	  			
	  	<br>
	  		<br>
	    <div style="float:left;width:250px;text-align:center;">
	  			<h4>The Secret Book</h4>
	  			<a href="http://www.mytweetmark.com/link/21759" title="Go to the Secret Book"><img src="${createLinkTo(dir:'images',file:'thesecretbook-campaign-180.jpg')}"/></a>
	  			</div>
	  			<br>
	  		<br>
	    <div style="float:left;width:250px;text-align:center;">
	  			<h4>The Sacred Book</h4>
	  			<a href="http://amzn.to/1ae6uzt" title="Go to the Sacred Book"><img src="${createLinkTo(dir:'images',file:'thesacredbook-campaign-180.jpg')}"/></a>
	  			</div>
	  	<br>
	  		<br>				
	  				    
		</div>	
        </div>
        
        <g:render template="/common/miniProfile"/>
        <g:render template="/common/userProfile"/>
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
