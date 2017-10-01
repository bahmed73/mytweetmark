

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Blog List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Blog</g:link></span>
        </div>
        <div class="body">
            <h1>Blog List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="userId" title="User Id" />
                        
                   	        <g:sortableColumn property="status" title="Status" />
                        
                   	        <g:sortableColumn property="createTime" title="Create Time" />
                        
                   	        <g:sortableColumn property="description" title="Description" />
                        
                   	        <g:sortableColumn property="updateTime" title="Update Time" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${blogInstanceList}" status="i" var="blogInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${blogInstance.id}">${fieldValue(bean:blogInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:blogInstance, field:'userId')}</td>
                        
                            <td>${fieldValue(bean:blogInstance, field:'status')}</td>
                        
                            <td>${fieldValue(bean:blogInstance, field:'createTime')}</td>
                        
                            <td>${fieldValue(bean:blogInstance, field:'description')}</td>
                        
                            <td>${fieldValue(bean:blogInstance, field:'updateTime')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${blogInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
