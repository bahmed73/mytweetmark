<div class="rounded" style="margin:20px;">
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">
      google.load("visualization", "1", {packages:["piechart", "annotatedtimeline"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = new google.visualization.DataTable();
        
        data.addColumn('string', 'Referrer');
        data.addColumn('number', 'Amount(Count)');
        data.addRows(${profileRefererInstanceTotal});
        
        <g:each in="${profileRefererMap}" status="i" var="profileRefererMapInstance">
        data.setValue(${i}, 0, '${profileRefererMapInstance.key}');
        data.setValue(${i}, 1, ${profileRefererMapInstance.value});
        </g:each>

        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, {width: 400, height: 240, is3D: true, title: 'Referrer Distribution Chart'});
        
        var data2 = new google.visualization.DataTable();
        data2.addColumn('date', 'Date');
        data2.addColumn('number', 'Page Views');
        data2.addRows(${viewSummaryInstanceTotal});
        
        <g:each in="${viewSummaryList}" status="i" var="viewSummaryMapInstance">
        data2.setValue(${i}, 0, 
        	new Date(<g:formatDate format="yyyy" date="${viewSummaryMapInstance.createTime}" />,
        	<g:formatDate format="MM" date="${viewSummaryMapInstance.createTime}" />-1,
        	<g:formatDate format="dd" date="${viewSummaryMapInstance.createTime}" />)
        );
        data2.setValue(${i}, 1, ${viewSummaryMapInstance.num});
        </g:each>

        var chart2 = new google.visualization.AnnotatedTimeLine(document.getElementById('chart_div2'));
        chart2.draw(data2, {title: 'Page Views Distribution Chart'});
        
        var data3 = new google.visualization.DataTable();
        data3.addColumn('date', 'Date');
        data3.addColumn('number', 'Followers');
        data3.addColumn('number', 'Following');
        data3.addRows(${followerSummaryInstanceTotal});
        
        <g:each in="${followerSummaryList}" status="j" var="followInstance">
        data3.setValue(${j}, 0, 
        	new Date(<g:formatDate format="yyyy" date="${followInstance.createTime}" />,
        	<g:formatDate format="MM" date="${followInstance.createTime}" />-1,
        	<g:formatDate format="dd" date="${followInstance.createTime}" />)
        );
        data3.setValue(${j}, 1, ${followInstance.followersCount});
        data3.setValue(${j}, 2, ${followInstance.friendsCount});
        </g:each>

        var chart3 = new google.visualization.AnnotatedTimeLine(document.getElementById('chart_div3'));
        chart3.draw(data3, {title: 'Followers Distribution Chart'});
      }
    </script>
    
    <g:if test="${profileRefererMap}">
			<div style="float:left;width:650px;">
			<g:if test="${user.profilePhoto}">
		        <g:link url="/$user.userName"><img src="${user.profilePhoto}" width="48" height="48" class="profile_border"></g:link>    
		    </g:if>
	        <h2><g:link url="/$user.userName">${user.userName}</g:link></h2>
	        </div>
	        <div style="float:left;width:650px;">
	        <h4>Total Views: ${views} times.</h4>
	        <g:if test="${pageViewChange}"><h4>Daily Change: ${pageViewChange} views.</h4></g:if>
	        <g:if test="${pageViewChangePercentage}"><h4>Daily Change %: <g:formatNumber number="${pageViewChangePercentage}" type="number" maxFractionDigits="2" /></h4></g:if>
	        
	        <div class="rounded" style="float:center;width:650px;border:1px solid #cfcfcf;background:#f3ecd5;height:50px;">
	        If your daily page views are not increasing, try our auto tweet feature.
	        </div>
	        
	        </div>
        	<br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div>
	        <div style="float:left;width:650px;">
	        <h2>Profile viewers come from these sites</h2>
	        </div> 
	        <div style="float:left;width:650px;">
	        <div id="chart_div"></div>
	        </div>
	        </g:if>
        	<br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div> 
	        
        	<div style="float:left;width:650px;">
	        <h2>Daily page views chart</h2>
	        <div class="rounded" style="float:center;width:650px;border:1px solid #cfcfcf;background:#f3ecd5;height:50px;">
	        Are your page views increasing daily?
	        </div>
	        </div>
	        <br>
	        <div id="chart_div2" style="float:left;width:650px;height:240px;"></div>
	        <br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div> 
	        <div style="float:left;width:650px;">
	        <h4>Total Followers: ${totalFollowers}</h4>
	        <h4>Total Following: ${totalFollowing}</h4>
	        <g:if test="${followersChange}"><h4>Daily Followers Change: ${followersChange} users.</h4></g:if>
	        <g:if test="${followersChangePercentage}"><h4>Daily Followers Change %: <g:formatNumber number="${followersChangePercentage}" type="number" maxFractionDigits="2" /></h4></g:if>
	        <div class="rounded" style="float:center;width:650px;border:1px solid #cfcfcf;background:#f3ecd5;height:50px;">
	        If your daily followers are not increasing, try our auto tweet feature.
	        </div>
	        </div>
        	<br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div>
	        <div style="float:left;width:650px;">
	        <h2>Daily followers and following chart</h2>
	        <div class="rounded" style="float:center;width:650px;border:1px solid #cfcfcf;background:#f3ecd5;height:50px;">
	        Are your followers increasing daily?
	        </div>
	        </div>
	        <br>
	        <div id="chart_div3" style="float:left;width:650px;height:240px;"></div>
	        <br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div> 
	        
	        <g:if test="${session.userName!=null}">
	        
	        <div style="float: left;">
			  <br>
			  <br>
			  <g:form method="post" url="[action:'statusUpdate',controller:'users']">
			  <div style="float:left;align:left;">
			          <b>Twitter status update</b>: <input id="eBann" name="update" value="" size="20" maxlength="140" onKeyUp="toCount('eBann','sBann','{CHAR} characters left',140);"/>
               
      			<br>
      			<span id="sBann" class="minitext">140 characters left.</span>	
                <br />
                <div class="rounded" style="float:center;width:650px;border:1px solid #cfcfcf;background:#f3ecd5;height:50px;">
			          Type a @twitter status update and measure how many page views you get on @mytweetmark analytics.<br>
			          </div>
			  </div>
				<div>
				<br>
				<g:actionSubmit value="Update" action="statusUpdate"/>
				</div>
			  </g:form>
			  
			  <br>
			  <br>
			</div>
	        <br class="clear"/>    
	        <div class="update-separator-grey">&nbsp;</div>
	        </g:if>
</div>	        