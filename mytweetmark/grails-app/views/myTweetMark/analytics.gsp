<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">

  <head>
       
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="en-us" http-equiv="Content-Language" />
<meta http-equiv="Cache-Control" content="No-Cache" />

<meta name="description" content="Share your categorized business links and blogs on twitter!" />
<meta name="keywords" content="mytweetmark,mytweetmark.com,brand,share posts,post information,organize bookmarks,share bookmarks,share knowledge,organize bookmarks,categorize bookmarks,email bookmarks, share bookmarks and posts, share posts and bookmarks, share with friends,tweet,twitter" />
<meta http-equiv="window-target" content="_top" />
    <title id="page_title">mytweetmark.com / analytics</title>
<LINK REL="SHORTCUT ICON"
       HREF="${createLinkTo(dir:'images', file:'mytweetmark-icon.ico')}">
<g:javascript library="scriptaculous" />    

<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'reset.css')}" />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'main-home.css')}" />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'post.css')}" />
<link rel="stylesheet" type="text/css" href="${createLinkTo(dir:'css', file:'mytweetmark.css')}" />

<script type="text/javascript" src="${createLinkTo(dir:'js', file:'characterCounter.js')}"></script>

    <style type="text/css">
      
        body {
  body { background: #9AE4E8 url('http://a2.twimg.com/a/1250203207/images/bg.gif') fixed no-repeat top left; }


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
  window.fbAsyncInit = function() {
    // init the FB JS SDK
    FB.init({
      appId      : '216791399738', // App ID from the App Dashboard
      channelUrl : '//www.mytweetmark.com/images/channel.html', // Channel File for x-domain communication
      status     : true, // check the login status upon init?
      cookie     : true, // set sessions cookies to allow your server to access the session?
      xfbml      : true  // parse XFBML tags on this page?
    });

    // Additional initialization code such as adding Event Listeners goes here

  };

  // Load the SDK's source Asynchronously
  (function(d){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/en_US/all.js";
     ref.parentNode.insertBefore(js, ref);
   }(document));
   
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
<div style="background-image:url(${createLinkTo(dir:'images', file:'blue_gradient.png')});">
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

      
                  
        <div style="float:left;width:986px;background-color:#ffffff;margin: 10px auto 10px;border:2px solid #E0F0FB;">
        
        <br class="clear"/>   
        <g:if test="${session.userName!=null}">
        
        	<br>
			<div class="rounded" style="float:right;width:250px;text-align:center;background-image: url(${createLinkTo(dir:'images', file:'bg_slideshow.jpg')});">
			
				
				<div style="float:center;width:250px;text-align:center;">
	  			<h4>Quick Tip:</h4>
	  			Turn email report on to get daily analytics report emailed to you.    
	  			</div>
	  			<br><br>
				<g:if test="${emailReport==0}">
				<div style="float:center;">
				  <g:link action="emailReportOn" controller="users">
					            		<img src="${createLinkTo(dir:'images', file:'bluebutton_emailreporton.png')}" title="Email daily reports"/>
					            	</g:link>
				</div>
				</g:if>
				<g:else>
				<div style="float:center;">
				  <g:link action="emailReportOff" controller="users">
					            		<img src="${createLinkTo(dir:'images', file:'bluebutton_emailreportoff.png')}" title="Stop emailing daily reports"/>
					            	</g:link>
				</div>
				</g:else>
				<br><br>  
				
	  		</div>
              	
         </g:if>
         <g:else>
        
        	<br>
			<div class="rounded" style="float:right;width:250px;text-align:center;background-image: url(${createLinkTo(dir:'images', file:'bg_slideshow.jpg')});">
			
				
				<div style="float:center;width:250px;text-align:center;margin:5px;">
	  			<h4>Analytics:</h4>
	  			<div style="margin:3px;">
	  			By using mytweetmark, you can view which sites the traffic comes to your profile page. The traffic distribution chart is displayed. The daily, 5 day and monthly page view aggregation chart. Following and followers growth chart is also available.   
	  			</div>
	  			</div>
	  			<br><br>
				
	  		</div>
              	
         </g:else>
        <g:render template="/common/analytics"/>
             
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
