

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'viewSummary.label', default: 'ViewSummary')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'viewSummary.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="num" title="${message(code: 'viewSummary.num.label', default: 'Num')}" />
                        
                            <g:sortableColumn property="createTime" title="${message(code: 'viewSummary.createTime.label', default: 'Create Time')}" />
                        
                            <g:sortableColumn property="userId" title="${message(code: 'viewSummary.userId.label', default: 'User Id')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${viewSummaryInstanceList}" status="i" var="viewSummaryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${viewSummaryInstance.id}">${fieldValue(bean: viewSummaryInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: viewSummaryInstance, field: "num")}</td>
                        
                            <td><g:formatDate date="${viewSummaryInstance.createTime}" /></td>
                        
                            <td>${fieldValue(bean: viewSummaryInstance, field: "userId")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${viewSummaryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
