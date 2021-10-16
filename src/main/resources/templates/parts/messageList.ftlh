<#import "pager.ftlh" as p>

<div class="row row-cols-1 row-cols-md-3">
    <#list page.content as message>
        <div class="col mb-4">
            <div class="card my-3" style="width: 18rem;">
                <#if message.fileName??>
                    <img src="/img/${message.fileName}" class="card-img-top" alt="...">
                </#if>
                <div class="card-body">
                    <h5 class="card-title"></h5>
                    <p class="card-text">${message.text}</p>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">${message.tag}</li>
                </ul>
                <div class="card-footer text-muted container">
                    <div class="row">
                        <a class="col align-self-center" href="/user-messages/${message.author.id}">${message.author.username}</a>
                        <a class="col align-self-center" href="/messages/${message.id}/like">
                            <#if message.meLiked>
                                <i class="fas fa-heart"></i>
                                <#else>
                                <i class="far fa-heart"></i>
                            </#if>
                            ${message.likes}
                        </a>
                        <#if message.author.id == currentUserId>
                            <input type="button" class="col btn btn-primary" value="Edit"
                                   onclick='location.href="/user-messages/${message.author.id}?message=${message.id}"'/>
                        </#if>
                    </div>
<#--                    <input type="hidden" name="id" value="<#if message??>${message.id}</#if>"/>
                    <a href="/main-delete/${message.author.id}">Удалить ${message.author.username}</a>
                    <form action="/main/${message.id}" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                        <input type="hidden" name="_method" value="delete"/>
                        <button type="submit" class="btn btn-primary">Удалить</button>
                    </form>-->
                </div>
            </div>
        </div>
<#--        <form action="/main/${message.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="hidden" name="_method" value="delete"/>
        <button type="submit">Удалить</button>
        </form>-->
    <#else>
        No message
    </#list>
</div>

