<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<html>
	<head>
		<meta name="description" content="Helps your business on Twitter.  Business startup. Create, target and measure marketing campaigns on twitter. Gain market influence. Also visit @homecookme for California farmers markets." />
<meta name="keywords" content="farmersmarket, farmers, farms, farm, farmer, california, food, farmers market, local food, real food, localfood, realfood, campaign, campaigns, analytics, metrics, referrer, referer, blogger, socialmedia, socialmedia blogger, social media blogger, facebook, facebook feed, twitter, twitter update, twitter, twitter hash, twitter hashtag, hash, hashtag,viral,mytweetmark,mytweetmark.com,myhash, brand,share posts,post information,organize bookmarks,share bookmarks,share knowledge,organize bookmarks,categorize bookmarks,email bookmarks, share bookmarks and posts, share posts and bookmarks, share with friends,tweet,twitter" />
<meta http-equiv="window-target" content="_top" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="PUBLIC">
<g:if test="${!request.getRequestURL().toString().contains('http://www') && !request.getRequestURL().toString().contains('localhost')}">
<meta http-equiv="refresh" content="0;URL=http://www.mytweetmark.com"/>
</g:if>
<title>mytweetmark.com - Helps your business on Twitter</title>

<link rel="stylesheet" href="${createLinkTo(dir:'css', file:'skel-noscript.css')}" />
			<link rel="stylesheet" href="${createLinkTo(dir:'css', file:'style.css')}" />
			<link rel="stylesheet" href="${createLinkTo(dir:'css', file:'style-desktop.css')}" />

<LINK REL="SHORTCUT ICON"
       HREF="${createLinkTo(dir:'images', file:'mytweetmark-icon.ico')}">
<g:javascript library="scriptaculous" />

		<link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,900,300italic" rel="stylesheet" />
		<link href='http://fonts.googleapis.com/css?family=Alegreya+SC:700,400|Alegreya+Sans' rel='stylesheet' type='text/css'>
		<script src="${createLinkTo(dir:'js', file:'jquery.min.js')}"></script>
		<script src="${createLinkTo(dir:'js', file:'jquery.dropotron.min.js')}"></script>
		<script src="${createLinkTo(dir:'js', file:'config.js')}"></script>
		<script src="${createLinkTo(dir:'js', file:'skel.min.js')}"></script>
		<script src="${createLinkTo(dir:'js', file:'skel-panels.min.js')}"></script>
		<!--<noscript>
			<link rel="stylesheet" href="css/skel-noscript.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-desktop.css" />
		</noscript>-->
		<!--[if lte IE 8]><script src="js/html5shiv.js"></script><link rel="stylesheet" href="css/ie8.css" /><![endif]-->
	</head>
	<body class="homepage" onload="<g:if test='${flash.message}'> 
  $('fade_message').fade({ duration: 5.0, from: 5, to: 0 }); return false;
  </g:if>
  ">
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

<%def myTweetMarkService = new MyTweetMarkService() %>
<%myTweetMarkService.trackReferer() %>

<% session.ipAddress=request.getRemoteAddr()%>
<% session.referer=request.getHeader("REFERER")%>

<img src="${createLinkTo(dir:'images', file:'mytweetmark-logo.jpg')}" alt="" />
		<!-- Header Wrapper -->
			<div id="header-wrapper">
				<div class="container">
					
					<div class="row">
						<div class="12u">

							<!-- Banner -->
								<section id="banner">
									<a href="http://www.mytweetmark.com">
										<span class="image image-full"><img src="${createLinkTo(dir:'images', file:'mytweetmark-homepage3.jpg')}" alt="" /></span>
										<header>
											<h2><!--mytweetmark.com--></h2>
											<!--span class="byline">welcome!</span-->
										</header>
									</a>
									<section id="search">
<g:form method="post" url="[action:'searchMyTweetmarks',controller:'myTweetMark']">
			  <div>
			          <b>Search</b>: <input type="text" name="search" size="25" value="">
			  </div>
				<div>
				<br>
				<g:actionSubmitImage value="Search" action="searchMyTweetmarks" src="${createLinkTo(dir:'images',file:'search-new.png')}"/>
				</div>
			  </g:form>
								<!--<input type="text" placeholder="Search" size="35" style="border:none">-->
								</section>
								</section>
								
						</div>
					</div>
					
								<!-- Nav -->
										<nav id="nav">
											<ul>
												<li><a href="http://www.mytweetmark.com/blog/show/109">Auto Tweets</a></li>
												<li><a href="http://www.mytweetmark.com/blog/show/110">Unfollowers</a></li>
												<!--<li><a href="left-sidebar.html">Login</a></li>-->
											</ul>
										</nav>
							<!-- Intro -->
							<div class="row">
						<div class="12u">
								<section>
									<div>
										<div class="row">
											<div class="6u">
												<section class="box">
													<header>
														<h2><span style="color:#000000">Twitter for Business: Auto Tweets, blogs, analytics and manage unfollowers!</span></h2>
													</header>
		<p>mytweetmark allows business to gain more traffic through auto tweets. Login with your twitter account, use the console to set auto tweets. Once ready, turn on the auto tweet switch to start sending periodic tweets. mytweetmark also allows you to write blogs, provides analytics and unfollowers module where you can unfollow users that don't follow back.
		</p>											<p><a href="http://www.homecook.me">Homecook.me</a> allows local business and farmers markets to create their social media profile. Include markets, products, price, blog, recipes, contact information. On twitter, tweets are generated to bring online traffic to the business. The business can be searched on google. As a customer, register to connect with your favorite farmers market business. <a href="http://www.mediabistro.com/alltwitter/farmers-markets-going-high-tech-with-twitter_b1976" >Continue Reading...</a></p>
<g:link url="[action:'verifyToken',controller:'users']"><img src="${createLinkTo(dir:'images', file:'Sign-in-with-Twitter-lighter.png')}" title="Login"/></g:link>
<br/>
		<fb:login-button onlogin="verifyFBLogin();"></fb:login-button>												</section>
											</div>
											<div class="6u">
												<section class="box">
													<a href="http://www.foundersspace.com/contributors/bilal-ahmed-founder-of-mytweetmark-homecookme/" class="image image-full"><img src="${createLinkTo(dir:'images', file:'bilal2-2.jpg')}" alt="Woman with flowers smiling at Farmers Market" /></a>
													<!--header>
														<h3>Aptent veroeros et aliquam</h3>
														<span class="byline">Posted 45 minutes ago</span>
													</header>
													<p>Lorem ipsum dolor sit amet sit veroeros sed et blandit consequat sed veroeros lorem et blandit  adipiscing feugiat phasellus tempus hendrerit, tortor vitae mattis tempor, sapien sem feugiat sapien, id suscipit magna felis nec elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos lorem ipsum dolor sit amet.</p>
													<footer class="actions">
														<a href="#" class="button fa fa-file-text">Continue Reading</a>
														<a href="#" class="button alt fa fa-comment">33 comments</a>
													</footer-->
												</section>
											</div>
										</div>
									</div>
								</section>

						</div>
					</div>
				</div>
			</div>
		
		<!-- Main Wrapper -->
			<div id="main-wrapper">
				<div class="container">
					<div class="row">
						<div class="12u">
							
							<!-- Portfolio -->
								<section>
									<<h2>Also see:</h2>
									
									<div>
										<div class="row">
											<!--<div class="4u" >
												<section class="box">
													<a href="http://www.homecook.me/farmerMarket/all" class="image image-full"><img src="images/customer1.jpg" alt="" /></a>
												
													<p><a href="http://www.homecook.me/farmerMarket/all">Alphabetical customer listing</a></p>
												
												</section>
											</div>
											<div class="4u">
												<section class="box">
													<a href="http://www.homecook.me/homecookme" class="image image-full"><img src="images/customer3.jpg" alt="" /></a>
													<p><a href="http://www.homecook.me/homecookme">Local food API and programming</a></p>
												</section>
											</div>
											<div class="4u">
												<section class="box">
													<a href="http://www.mytweetmark.com" class="image image-full"><img src="images/customer2.jpg" alt="" /></a>
													<p><a href="http://www.mytweetmark.com">Twitter marketing tool</a></p>
												</section>
											</div>
-->										</div>
										
											
					</div>
					<div class="row">
						<div class="12u">

							<!-- Blog >
								<section>
									<header class="major">
										<h2>The Blog</h2>
									</header>
									<div>
										<div class="row">
											<div class="6u">
												<section class="box">
													<a href="http://facebook.com/homecookme" class="image image-full"><img src="images/pic08.jpg" alt="" /></a>
													<header>
														<h3>Magna tempus consequat lorem</h3>
														<span class="byline">Posted 45 minutes ago</span>
													</header>
													<p>Lorem ipsum dolor sit amet sit veroeros sed et blandit consequat sed veroeros lorem et blandit  adipiscing feugiat phasellus tempus hendrerit, tortor vitae mattis tempor, sapien sem feugiat sapien, id suscipit magna felis nec elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos lorem ipsum dolor sit amet.</p>
													<footer class="actions">
														<a href="#" class="button fa fa-file-text">Continue Reading</a>
														<a href="#" class="button alt fa fa-comment">33 comments</a>
													</footer>
												</section>
											</div>
											<div class="6u">
												<section class="box">
													<a href="http://facebook.com/homecookme" class="image image-full"><img src="images/pic09.jpg" alt="" /></a>
													<header>
														<h3>Aptent veroeros et aliquam</h3>
														<span class="byline">Posted 45 minutes ago</span>
													</header>
													<p>Lorem ipsum dolor sit amet sit veroeros sed et blandit consequat sed veroeros lorem et blandit  adipiscing feugiat phasellus tempus hendrerit, tortor vitae mattis tempor, sapien sem feugiat sapien, id suscipit magna felis nec elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos lorem ipsum dolor sit amet.</p>
													<footer class="actions">
														<a href="#" class="button fa fa-file-text">Continue Reading</a>
														<a href="#" class="button alt fa fa-comment">33 comments</a>
													</footer>
												</section>
											</div>
										</div>
									</div>
								</section>
							
						</div>
					</div>
				</div>
			</div-->

		<!-- Footer Wrapper -->
			<div id="footer-wrapper">
				
				<!-- Footer -->
					<!--section id="footer" class="container">
						<div class="row">
							<div class="8u">

								<section>
									<header>
										<h2>Blandit nisl adipiscing</h2>
									</header>
									<ul class="dates">
										<li>
											<span class="date">Jan <strong>27</strong></span>
											<h3><a href="#">Lorem dolor sit amet veroeros</a></h3>
											<p>Ipsum dolor sit amet veroeros consequat blandit ipsum phasellus lorem consequat etiam.</p>
										</li>
										<li>
											<span class="date">Jan <strong>23</strong></span>
											<h3><a href="#">Ipsum sed blandit nisl consequat</a></h3>
											<p>Blandit phasellus lorem ipsum dolor tempor sapien tortor hendrerit adipiscing feugiat lorem.</p>
										</li>
										<li>
											<span class="date">Jan <strong>15</strong></span>
											<h3><a href="#">Magna tempus lorem feugiat</a></h3>
											<p>Dolore consequat sed phasellus lorem sed etiam nullam dolor etiam sed amet sit consequat.</p>
										</li>
										<li>
											<span class="date">Jan <strong>12</strong></span>
											<h3><a href="#">Dolore tempus ipsum feugiat nulla</a></h3>
											<p>Feugiat lorem dolor sed nullam tempus lorem ipsum dolor sit amet nullam consequat.</p>
										</li>
										<li>
											<span class="date">Jan <strong>10</strong></span>
											<h3><a href="#">Blandit tempus aliquam?</a></h3>
											<p>Feugiat sed tempus blandit tempus adipiscing nisl lorem ipsum dolor sit amet dolore.</p>
										</li>
									</ul>
								</section>
							
							</div>
							<div class="4u">
							
								<section>
									<header>
										<h2>What's this all about?</h2>
									</header>
									<a href="http://facebook.com/homecookme" class="image image-full"><img src="images/pic10.jpg" alt="" /></a>
									<p>
										This is <a href="http://html5up.net/Homecook.me/">Homecook.me</a> a free, fully responsive HTML5 site template by 
										<a href="http://n33.co">AJ</a> for <a href="http://html5up.net/">HTML5 UP</a> It's released for free under
										the <a href="http://html5up.net/license/">CCA</a> license so feel free to use it for any personal or commercial project &ndash;
										just don't forget to credit us! <strong>PS:</strong> The awesome placeholder artwork used in this design is courtesy of <a href="http://facebook.com/homecookme/">Homecookme</a>.
									</p>
									<footer>
										<a href="#" class="button">Find out more</a>
									</footer>
								</section>
							
							</div>
						</div-->
						<div class="row">
							<div class="4u">
<section>
									<header>
										<h2>Connect with us</h2>
									</header>
									<ul class="social">
										<li><a class="fa fa-facebook solo" href="https://www.facebook.com/pages/mytweetmarkcom/125516600684"><span>Facebook</span></a></li>
										<li><a class="fa fa-twitter solo" href="https://twitter.com/mytweetmark"><span>Twitter</span></a></li>
										<li><a class="fa fa-linkedin solo" href="http://www.linkedin.com/company/mytweetmark.com"><span>LinkedIn</span></a></li>
										<!--li><a class="fa fa-google-plus solo" href="#"><span>Google+</span></a></li-->
									</ul>
									<ul class="contact">
										<li>
											<h3>Address</h3>
											<p>
												1200 Arguello Blvd.<br />
																							San Francisco, CA 94122
											</p>
										</li>
										<li>
											<h3>Mail</h3>
											<p><a href="#">bilal@mytweetmark.com</a></p>
										</li>
										<!--li>
											<h3>Phone</h3>
											<p>(800) 000-0000</p>
										</li-->
									</ul>
								</section>
								

							</div>
							<div class="4u">

								<section>
									<header>
										<h2>More about us</h2>
									</header>
									<ul class="divided">
										<li><a href="http://www.slideshare.net/mytweetmark/mytweetmark-user-guide">User Guide</a></li>
										<li><a href="http://www.slideshare.net/mytweetmark/introduction-to-mytweetmark">Slides</a></li>
										<li><a href="http://www.mytweetmark.com/users/privacy">Privacy</a></li>
										<li><a href="http://www.mytweetmark.com/users/tos">Terms</a></li>
									</ul>
								</section>

							</div>
							<div class="4u">
							<section>
									<header>
										<h2>And more...</h2>
									</header>
									<ul class="divided">
										<li><a href="http://www.foundersspace.com/news-announcements/startup-splotlight-mytweetmark/">On FoundersSpace</a></li>
										<li><a href="https://twitter.com/homecookme">@homecookme on Twitter</a></li>
										<li><a href="https://angel.co/mytweetmark">On AngelList</a></li>
										<li><a href="https://twitter.com/drspiritcom">Visit @DrSpirit</a></li>
										<!--li><a href="#">Sem feugiat sapien id suscipit magna felis nec</a></li>
										<li><a href="#">Elit class aptent taciti sociosqu ad litora</a></li-->
									</ul>
								</section>
								
							
							</div>
						</div>
						<div class="row">
							<div class="12u">
							
								<!-- Copyright -->
									<div id="copyright">
										<ul class="links">
											<li>&copy; 2014 mytweetmark.com 	</li>
											<!--li>Images: <a href="http://facebook.com/homecookme">Homecookme</a></li>
											<li>Design: <a href="http://dalliusdesign.com">Dallius</a></li-->
										</ul>
									</div>

							</div>
						</div>
					</section>
				
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

	</body>
</html>