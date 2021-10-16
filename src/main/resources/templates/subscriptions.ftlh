<#import "parts/common.ftlh" as c>

<@c.page>
    <h5>${userChannel.username}</h5>
    <h5>${type}</h5>
    <div class="list-group">
        <#list users as user>
            <a href="/user-messages/${user.userId}" class="list-group-item list-group-item-action">${user.getUsername()}</a>
        </#list>
    </div>

</@c.page>