<#import "parts/common.ftlh" as c>

<@c.page>
    List of Users
    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Role</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td><#list user.roles as role>${role}<#sep>, </#list></td>
                <td><a href="/user/${user.id}">Edit</a></td>
                <td><form action="/user/${user.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <input type="hidden" name="_method" value="delete"/>
                        <button type="submit">Удалить</button>
                        </form></td>
            </tr>
        </#list>
        </tbody>
    </table>
</@c.page>