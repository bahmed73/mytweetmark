

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'tweetFinder.label', default: 'TweetFinder')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${tweetFinderInstance}">
            <div class="errors">
                <g:renderErrors bean="${tweetFinderInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${tweetFinderInstance?.id}" />
                <g:hiddenField name="version" value="${tweetFinderInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="createTime"><g:message code="tweetFinder.createTime.label" default="Create Time" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tweetFinderInstance, field: 'createTime', 'errors')}">
                                    <g:datePicker name="createTime" precision="day" value="${tweetFinderInstance?.createTime}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="tweetFinder.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tweetFinderInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: tweetFinderInstance, field: 'status')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="userId"><g:message code="tweetFinder.userId.label" default="User Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tweetFinderInstance, field: 'userId', 'errors')}">
                                    <g:textField name="userId" value="${fieldValue(bean: tweetFinderInstance, field: 'userId')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="finder"><g:message code="tweetFinder.finder.label" default="Finder" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tweetFinderInstance, field: 'finder', 'errors')}">
                                    <g:textField name="finder" value="${tweetFinderInstance?.finder}" />
                                </td>
                            </tr>
                        
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tweets"><g:message code="tweetFinder.tweets.label" default="Tweets" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tweetFinderInstance, field: 'tweets', 'errors')}">
                                    
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
