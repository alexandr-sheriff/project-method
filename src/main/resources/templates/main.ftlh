<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<#if !isAuthorized>
    <meta http-equiv="refresh" content="0; url=/login"/>
</#if>
<@c.page>
    <form action="/main" method="get">
        <div class="form-row">
            <div class="form-group col-md-10">
                <input type="text" name="filter" placeholder="Enter filter" class="form-control"
                       value="${filter?ifExists}"/>
            </div>
            <div class=" form-group col-md-2">
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </div>
    </form>

    <#include "parts/messageEdit.ftlh"/>
    <#include "parts/messageList.ftlh"/>

</@c.page>