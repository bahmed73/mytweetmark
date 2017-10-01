<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">

  <head>
        <script type="text/javascript">
//<![CDATA[
var page={};var onCondition=function(D,C,A,B){D=D;A=A?Math.min(A,5):5;B=B||100;if(D()){C()}else{if(A>1){setTimeout(function(){onCondition(D,C,A-1,B)},B)}}};
//]]>
</script>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="en-us" http-equiv="Content-Language" />
<meta content="myTweetMark is without a doubt the best way to share and discover what is happening right now." name="description" />
<meta content="no" http-equiv="imagetoolbar" />
<meta content="width = 780" name="viewport" />
<meta content="4FTTxY4uvo0RZTMQqIyhh18HsepyJOctQ+XTOu1zsfE=" name="verify-v1" />
<meta content="" name="page" />

<meta content="NOODP" name="robots" />
<meta content="n" name="session-loggedin" />
    <title id="page_title">myTweetMark / myTweetMark Terms of Service</title>
    <link href="https://s3.amazonaws.com/twitter_production/a/1253301564/images/favicon.ico" rel="shortcut icon" type="image/x-icon" />
<link href="https://s3.amazonaws.com/twitter_production/a/1253301564/images/twitter_57.png" rel="apple-touch-icon" />
    
    <link href="https://s3.amazonaws.com/twitter_production/a/1253301564/stylesheets/twitter-https.css" media="screen" rel="stylesheet" type="text/css" />
<link href="https://s3.amazonaws.com/twitter_production/a/1253301564/stylesheets/forgot_password-https.css" media="screen" rel="stylesheet" type="text/css" />
        <style type="text/css">
      
        
      
    </style>
      <link href="https://s3.amazonaws.com/twitter_production/a/1253301564/stylesheets/internal-https.css" media="screen, projection" rel="stylesheet" type="text/css" />
  <link href="https://s3.amazonaws.com/twitter_production/a/1253301564/stylesheets/terms-https.css" media="screen, projection" rel="stylesheet" type="text/css" />

  </head>

  <body class="help firefox-windows" id="terms">
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
      <script type="text/javascript">
//<![CDATA[
if (window.top !== window.self) {document.write = "";window.top.location = window.self.location; setTimeout(function(){document.body.innerHTML='';},1);window.self.onload=function(evt){document.body.innerHTML='';};}
//]]>
</script>
    
    
    <div id="dim-screen"></div>
    <ul id="accessibility" class="offscreen">
  <li><a href="#content" accesskey="0">Skip past navigation</a></li>
  <li>On a mobile phone? Check out <a href="http://m.twitter.com/">m.twitter.com</a>!</li>

  <li><a href="#footer" accesskey="2">Skip to navigation</a></li>
    <li><a href="#signin">Skip to sign in form</a></li>
</ul>

    

    <div id="container" class="subpage">
            <span id="loader" style="display:none"><img alt="Loader" src="https://s3.amazonaws.com/twitter_production/a/1253301564/images/loader.gif" /></span>
      <div id="header">
  <a href="https://myTweetMark.com/" title="myTweetMark / Home" accesskey="1" id="logo">
          <img src="${createLinkTo(dir:'images',file:'twitter-hash-logo-for-fluid2-qh.jpg')}">    
  </a>

            <form method="post" id="sign_out_form" action="/sessions/destroy" style="display:none;">
        <input name="authenticity_token" value="f39feed1f26a32b0e9503f29c056b56c47b2e75d" type="hidden" />
      </form>

      
      
      <ul class="top-navigation round">
                  <g:if test="${session.userName!=null}">
          <li><g:link url="[action:'myTweetMarks',controller:'myTweetMark']">Profile</g:link></li>
          <g:if test="${session.fuid==null}">
          <li><g:link url="[action:'list',controller:'tweetFriend']">TweetFriends</g:link></li>
          <li><g:link url="[action:'list',controller:'tweetUrl']">TweetUrls</g:link></li>
          </g:if>
          <li><g:link url="[action:'list',controller:'myTweetMark']">Bookmarks</g:link></li>
          <!--<li><g:link url="[action:'list',controller:'post']">Posts</g:link></li>-->
          <!--<li><g:link url="[action:'list',controller:'profileReferer']">Analytics</g:link></li>-->
		  <li><g:link url="[action:'logout',controller:'users']" id="sign_out_link" onClick="onLogout();">Sign out</g:link></li>
		  <g:form controller="users">
                    <input type="hidden" name="id" value="${session.userId}" />
                    <span class="button"><g:actionSubmit class="edit" value="edit" /></span>
                </g:form>
          </g:if>
          <g:if test="${session.userName==null}">
          <!--<li><g:link url="[action:'signup',controller:'users']">Sign up!</g:link></li>-->
          <li><g:link url="/">No need to sign up!  Login with your Twitter account.  Click here :)</g:link></li>
          </g:if>
              </ul>

      </div>




      

      
        <div class="content-bubble-arrow"></div>
      
      
        <table cellspacing="0" class="columns">
          <tbody>
            <tr>
              <td id="content" class="round-left column">
                                <div class="wrapper">

 <br>                 
 <br>                 
                  
<h2>Terms of Service</h2>

<p>These Terms of Service (�<strong>Terms</strong>�) govern your access to and use of the services and myTweetMark�s websites (the �<strong>Services</strong>�), and any information, text, graphics, or other materials uploaded, downloaded or appearing on the Services (collectively referred to as �<strong>Content</strong>�). Your access to and use of the Services is conditioned on your acceptance of and compliance with these Terms. By accessing or using the Services you agree to be bound by these Terms.
</p>

<h3>Basic Terms</h3>

<p>You are responsible for your use of the Services, for any content you post to the Services, and for any consequences thereof. The Content you submit, post, or display will be able to be viewed by other users of the Services and through  third party  services and websites (go to the edit page to control who sees your Content). You should only provide Content that you are comfortable sharing with others under these Terms.</p>

<!--<p class="tip">What you say on myTweetMark may be viewed all around the world instantly.  You are what you Tweet!</p>-->

<p>You may use the Services only if you can form a binding contract with myTweetMark and are not a person barred from receiving services under the laws of the United States or other applicable jurisdiction. You may use the Services only in compliance with these Terms and all applicable local, state, national, and international laws, rules and regulations.</p>

<p>The Services that myTweetMark provides are always evolving and the form and nature of the Services that myTweetMark provides may change from time to time without prior notice to you.  In addition, myTweetMark may stop (permanently or temporarily) providing the Services (or any features within the Services) to you or to users generally and may not be able to provide you with prior notice. We also retain the right to create limits on use and storage at our sole discretion at any time without prior notice to you.</p>

<p>The Services may include advertisements, which may be targeted to the Content or information on the Services, queries made through the Services, or other information. The types and extent of advertising by myTweetMark on the Services are subject to change. In consideration for myTweetMark granting you access to and use of the Services, you agree that myTweetMark and its third party providers and partners may place such advertising on the Services or in connection with the display of Content or information from the Services whether submitted by you or others.</p>

<!--<p class="tip">We're leaving the door open for exploration in this area but we don't have anything to announce.</p>-->

<h3>Privacy</h3>

<p>Any information that you provide to myTweetMark is subject to our <g:link url="[action:'privacy',controller:'users']">Privacy Policy</g:link>, which governs our collection and use of your information. You understand that through your use of the Services you consent to the collection and use (as set forth in the Privacy Policy) of this information, including the transfer of this information to the United States and/or other countries for storage, processing and use by myTweetMark. As part of providing you the Services, we may need to provide you with certain communications, such as service announcements and administrative messages. These communications are considered part of the Services and your myTweetMark account, which you may not be able to opt-out from receiving.</p>

<!--<p class="tip">You can opt-out of most communications from myTweetMark including our newsletter, new follower emails, etc. Please see the Notices tab of Settings for more.</p>-->

<h3>Passwords</h3>

<p>You are responsible for safeguarding the password that you use to access the Services and for any activities or actions under your password.  We encourage you to use �strong� passwords (passwords that use a combination of upper and lower case letters, numbers and symbols) with your account.  myTweetMark cannot and will not be liable for any loss or damage arising from your failure to comply with the above requirements.</p>

<h3>Content on the Services</h3>

<p>All Content, whether publicly posted or privately transmitted, is the sole responsibility of the person who originated such Content.  We may not monitor or control the Content posted via the Services and, we cannot take responsibility for such Content.  Any use or reliance on any Content or materials posted via the Services or obtained by you through the Services is at your own risk.</p>

<p>We do not endorse, support, represent or guarantee the completeness, truthfulness, accuracy, or reliability of any Content or communications posted via the Services or endorse any opinions expressed via the Services. You understand that by using the Services, you may be exposed to Content that might be offensive, harmful, inaccurate or otherwise inappropriate, or in some cases, postings that have been mislabeled or are otherwise deceptive.  Under no circumstances will myTweetMark be liable in any way for any Content, including, but not limited to, any errors or omissions in any Content, or any loss or damage of any kind incurred as a result of the use of any Content posted, emailed, transmitted or otherwise made available via the Services or broadcast elsewhere.</p>

<h3>Your Rights</h3>

<p>You retain your rights to any Content you submit, post or display on or through the Services. By submitting, posting or displaying Content on or through the Services, you grant us  a worldwide, non-exclusive, royalty-free license (with the right to sublicense) to use, copy, reproduce, process, adapt, modify, publish, transmit, display and distribute such Content in any and all media or distribution methods (now known or later developed).</p>

<p class="tip">This license is you authorizing us  to make your Tweets available to the rest of the world and to let others do the same. But what�s yours is yours � you own your content.</p>

<p>You agree that this license includes the right for myTweetMark to make such Content available to other companies, organizations or individuals who partner with myTweetMark for the syndication, broadcast, distribution or publication of such Content on other media and services, subject to our terms and conditions for such Content use. </p>

<!--<p class="tip">myTweetMark has an evolving set of <a href="/apirules">rules</a> for how API developers can interact with your content. These rules exist to enable an open ecosystem with your rights in mind.</p>-->

<p>Such additional uses by myTweetMark, or other companies, organizations or individuals who partner with myTweetMark, may be made with no  compensation paid to you with respect to the Content that you submit, post, transmit or otherwise make available through the Services.</p>

<p>We may modify or adapt your Content in order to transmit, display or distribute it over computer networks and in various media and/or make changes to your Content as are necessary to conform and adapt that Content to any requirements or limitations of any networks, devices, services or media.</p>

<p>You are responsible for your use of the Services, for any Content you provide, and for any consequences thereof, including the use of your Content by other users and our third party partners.  You understand that your Content may be rebroadcasted by our partners and if you do not have the right to submit Content for such use, it may subject you to liability.  myTweetMark will not be responsible or liable for any use of your Content by myTweetMark in accordance with these Terms.  You represent and warrant that you have all the rights, power and authority necessary to grant the rights granted herein to any Content that you submit.</p>

<p>myTweetMark gives you a personal, worldwide, royalty-free, non-assignable and non-exclusive license to use the software that is provided to you by myTweetMark as part of the Services. This license is for the sole purpose of enabling you to use and enjoy the benefit of the Services as provided by myTweetMark, in the manner permitted by these Terms.</p>

<h3>myTweetMark Rights</h3>

<p>All right, title, and interest in and to the Services (excluding Content provided by users) are and will remain the exclusive property of myTweetMark and its licensors. The Services are protected by copyright, trademark, and other laws of both the United States and foreign countries. Nothing in the Terms gives you a right to use the myTweetMark name or any of the myTweetMark trademarks, logos, domain names, and other distinctive brand features. Any feedback, comments, or suggestions you may provide regarding myTweetMark, or the Services is entirely voluntary and we will be free to use such feedback, comments or suggestions as we see fit and without any obligation to you.</p>

<h3>Restrictions on Content and Use of the Services</h3>

<p>We reserve the right at all times (but will not have an obligation) to remove or refuse to distribute any Content on the Services and to terminate users or reclaim usernames.  We also reserve the right to access, read, preserve, and disclose any information as we reasonably believe is necessary to (i) satisfy any applicable law, regulation, legal process or governmental request, (ii) enforce the Terms, including investigation of potential violations hereof, (iii) detect, prevent, or otherwise address fraud, security or technical issues, (iv) respond to user support requests, or (v) protect the rights, property or safety of myTweetMark, its users and the public.</p>

<p class="tip">myTweetMark does not disclose personally identifying information to third parties except in accordance with our Privacy Policy.</p>

<p>You may not do any of the following while accessing or using the Services: (i) access, tamper with, or use non-public areas of the Services, myTweetMark�s computer systems, or the technical delivery systems of myTweetMark�s providers; (ii) probe, scan, or test the vulnerability of any system or network or breach or circumvent any security or authentication measures; (iii) access or search or attempt to access or search the Services by any means (automated or otherwise) other than through our currently available, published interfaces that are provided by myTweetMark (and only pursuant to those terms and conditions), unless you have been specifically allowed to do so in a separate agreement with myTweetMark (NOTE: crawling the Services is permissible if done in accordance with the provisions of the robots.txt file, however, scraping the Services without the prior consent of myTweetMark is expressly prohibited); (iv) forge any TCP/IP packet header or any part of the header information in any email or posting, or in any way use the Services to send altered, deceptive or false source-identifying information; or (v) interfere with, or disrupt, (or attempt to do so), the access of any user, host or network, including, without limitation, sending a virus, overloading, flooding, spamming, mail-bombing the Services, or by scripting the creation of Content in such a manner as to interfere with or create an undue burden on the Services.</p>

<h3>Copyright Policy</h3>

<p>myTweetMark respects the intellectual property rights of others and expects users of the Services to do the same.  We will respond to notices of alleged copyright infringement that comply with applicable law and are properly provided to us.  If you believe that your Content has been copied in a way that constitutes copyright infringement, please provide us with the following information: (i) a physical or electronic signature of the copyright owner or a person authorized to act on their behalf; (ii) identification of the copyrighted work claimed to have been infringed; (iii) identification of the material that is claimed to be infringing or to be the subject of infringing activity and that is to be removed or access to which is to be disabled, and information reasonably sufficient to permit us to locate the material; (iv) your contact information, including your address, telephone number, and an email address; (v) a statement by you that you have a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law; and (vi) a statement that the information in the notification is accurate, and, under penalty of perjury, that you are authorized to act on behalf of the copyright owner.</p>

<p>We reserve the right to remove Content alleged to be infringing without prior notice and at our sole discretion. In appropriate circumstances, myTweetMark will also terminate a user�s account if the user is determined to be a repeat infringer.  Our designated copyright agent for notice of alleged copyright infringement appearing on the Services is:</p>

<address>myTweetMark, Inc. <br/> Attn: Copyright Agent <br/> 1771 Laguna Street, #14 <br/> Concord, CA 94520 <br/> Email: <a href="mailto:mytweetmark@gmail.com"></a></address>

<h3>The Services are Available �AS-IS�</h3>

<p>Your access to and use of the Services or any Content is at your own risk.  You understand and agree that the Services is provided to you on an �AS IS� and �AS AVAILABLE� basis.  Without limiting the foregoing, myTweetMark AND ITS PARTNERS DISCLAIM ANY WARRANTIES, EXPRESS OR IMPLIED, OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.  We make no warranty and disclaim all responsibility and liability for the completeness, accuracy, availability, timeliness, security or reliability of the Services or any content thereon.  myTweetMark will not be responsible or liable for any harm to your computer system, loss of data, or other harm that results from your access to or use of the Services, or any Content.  You also agree that myTweetMark has no responsibility or liability for the deletion of, or the failure to store or to transmit, any Content and other communications maintained by the Services.  We make no warranty that the Services will meet your requirements or be available on an uninterrupted, secure, or error-free basis.  No advice or information, whether oral or written, obtained from myTweetMark or through the Services, will create any warranty not expressly made herein.</p>

<h3>Links</h3>
<p>The Services may contain links to third-party websites or resources.  You acknowledge and agree that we are not responsible or liable for: (i) the availability or accuracy of such websites or resources; or (ii) the content, products, or services on or available from such websites or resources.  Links to such websites or resources do not imply any endorsement by myTweetMark of such websites or resources or the content, products, or services available from such websites or resources.  You acknowledge sole responsibility for and assume all risk arising from your use of any such websites or resources.</p>

<h3>Limitation of Liability</h3>
<p>TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, myTweetMark AND ITS SUBSIDIARIES, AFFILIATES, OFFICERS, EMPLOYEES, AGENTS, PARTNERS AND LICENSORS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL OR PUNITIVE DAMAGES, INCLUDING WITHOUT LIMITATION, LOSS OF PROFITS, DATA, USE, GOOD-WILL, OR OTHER INTANGIBLE LOSSES, RESULTING FROM (i) YOUR ACCESS TO OR USE OF OR INABILITY TO ACCESS OR USE THE SERVICES; (ii) ANY CONDUCT OR CONTENT OF ANY THIRD PARTY ON THE SERVICES, INCLUDING WITHOUT LIMITATION, ANY DEFAMATORY, OFFENSIVE OR ILLEGAL CONDUCT OF OTHER USERS OR THIRD PARTIES; (iii) ANY CONTENT OBTAINED FROM THE SERVICES; AND (iv) UNAUTHORIZED ACCESS, USE OR ALTERATION OF YOUR TRANSMISSIONS OR CONTENT, WHETHER BASED ON WARRANTY, CONTRACT, TORT (INCLUDING NEGLIGENCE) OR ANY OTHER LEGAL THEORY, WHETHER OR NOT myTweetMark HAS BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGE, AND EVEN IF A REMEDY SET FORTH HEREIN IS FOUND TO HAVE FAILED OF ITS ESSENTIAL PURPOSE.</p>

<h3>Exclusions</h3>
<p>Some jurisdictions do not allow the exclusion of certain warranties or the exclusion or limitation of liability for consequential or incidental damages, so the limitations above may not apply to you.</p>

<h3>Waiver and Severability</h3>
<p>The failure of myTweetMark to enforce any right or provision of these Terms will not be deemed a waiver of such right or provision. In the event that any provision of these Terms is held to be invalid or unenforceable, the remaining provisions of these Terms will remain in full force and effect.</p>

<h3>Controlling Law and Jurisdiction</h3>
<p>These Terms and any action related thereto will be governed by the laws of the State of California without regard to or application of its conflict of law provisions or your state or country of residence.  All claims, legal proceedings or litigation arising in connection with the Services will be brought solely in San Francisco County, California, and you consent to the jurisdiction of and venue in such courts and waive any objection as to inconvenient forum. If you are accepting these Terms on behalf of a United States federal government entity that is legally unable to accept the controlling law, jurisdiction or venue clauses above, then those clauses do not apply to you but instead these Terms and any action related thereto will be will be governed by the laws of the United States of America (without reference to conflict of laws) and, in the absence of federal law and to the extent permitted under federal law, the laws of the State of California (excluding choice of law).</p>

<h3>Entire Agreement</h3>
<p>These Terms, the myTweetMark Rules and our Privacy Policy are the entire and exclusive agreement between myTweetMark and you regarding the Services (excluding any services for which you have a separate agreement with myTweetMark that is explicitly in addition or in place of these Terms), and these Terms supersede and replace any prior agreements between myTweetMark and you regarding the Services.</p>

<p>We may revise these Terms from time to time, the most current version will always be at <g:link url="[action:'tos',controller:'users']">tos</g:link>. If the revision, in our sole discretion, is material we will notify you via an @myTweetMark update or e-mail to the email associated with your account. By continuing to access or use the Services after those revisions become effective, you agree to be bound by the revised Terms.</p>

<p>These Services are operated and provided by myTweetMark Inc., 1771 Laguna Street, #14 Concord, CA 94520.  If you have any questions about these Terms, please <a href="mailto:mytweetmark@gmail.com">contact us</a>.</p>

<p><em>Effective: September 18th, 2009</em><br />




<style type="text/css">@import url('http://assets0.zendesk.com/external/zenbox/overlay.css');</style><script type="text/javascript">zenbox_params={hide_tab: true, url:"twitter.zendesk.com"}</script><script type="text/javascript" src="http://assets0.zendesk.com/external/zenbox/overlay.js"></script>


  
                </div>
                              </td>
              
                <td id="side_base" class="column round-right">
                                  
                  <div id="side">
                      <div class="section">
    <div class="section-header">
<!--
      <h1>Supporting documents</h1>
    </div><!-- /section-header -->

    Read more specifics about myTweetMark's rules and policies:<br /><br />
    <ol>
      <li>Hey, developers! Check out our <a href="/apirules">API Rules</a>.</li>
      <li>Want to know more about Terms of Service policies? Check out the <a href="http://twitter.zendesk.com/forums/26257/entries/18311">myTweetMark Rules</a>.</li>

      <li><a href="http://twitter.zendesk.com/forums/26257/entries/41949">Law Enforcement Guidelines</a></li>
    </ol>
    <div class="section-header">
      <h1>Dealing with Terms violations</h1>
    </div><!-- /section-header -->

    <ol>
      <li><a href="http://twitter.zendesk.com/forums/26257/entries/18366">Impersonation problems?</a></li>

      <li>Trademark or business name squatting? <a href="http://twitter.zendesk.com/forums/26257/entries/18367">Find out more</a>.</li>
      <li><a href="http://twitter.zendesk.com/forums/26257/entries/15790">Find out why accounts are suspended.</a></li>
    </ol>
    -->
  </div> <!-- /section -->
  
                  </div>
                                </td>

              
            </tr>
          </tbody>
        </table>
      

      
  <div id="footer"
        class="round">
      <h3 class="offscreen">Footer</h3>
      <g:render template="/common/footer"/>
  </div>



      <hr />

    </div>

    
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js" type="text/javascript"></script>
<script src="https://s3.amazonaws.com/twitter_production/a/1253301564/javascripts/twitter.js?1253308045" type="text/javascript"></script>
<script src="https://s3.amazonaws.com/twitter_production/a/1253301564/javascripts/lib/jquery.tipsy.min.js?1253308045" type="text/javascript"></script>

<script type="text/javascript">
//<![CDATA[
      page.controller_name = 'HelpController';
      page.action_name = 'terms';
      twttr.form_authenticity_token = 'f39feed1f26a32b0e9503f29c056b56c47b2e75d';
      // FIXME: Reconcile with the kinds on the Status model.
      twttr.statusKinds = {
        UPDATE: 1,
        SHARE: 2
      };
      
    
//]]>
</script>

        <script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-10124777-1");
pageTracker._trackPageview();
} catch(err) {}</script>




    <div id="notifications"></div>


   <g:facebookConnectJavascript base="http://www.mytweetmark.com" /> 
  </body>

</html>
