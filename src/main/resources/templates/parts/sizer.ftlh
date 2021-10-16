<#macro sizer url page s1 s2 s3 s4>
    <#if page.getTotalPages() gt 7>
        <#assign
        totalPages = page.getTotalPages()
        pageNumber = page.getNumber() + 1
        head = (pageNumber > 4)?then([1, -1], [1, 2, 3])
        tail = (pageNumber < totalPages - 3)?then([-1, totalPages], [totalPages - 2, totalPages - 1, totalPages])
        bodyBefore = (pageNumber > 4 && pageNumber < totalPages - 1)?then([pageNumber - 2, pageNumber - 1], [])
        bodyAfter = (pageNumber > 2 && pageNumber < totalPages - 3)?then([pageNumber + 1, pageNumber + 2], [])
        body = head + bodyBefore + (pageNumber > 3 && pageNumber < totalPages - 2)?then([pageNumber], []) + bodyAfter + tail
        >
    <#else>
        <#assign body = 1..page.getTotalPages()>
    </#if>

    <div class="btn-group dropright justify-content-start">
        <button type="button" class="btn btn-primary btn-sm">Показать записей</button>
        <div class="dropdown-menu" aria-labelledby="dropdownMenu">
            <#list [s1, s2, s3, s4] as s>
                <#if s == page.getSize()>
                    <a class="dropdown-item mdb-dropdownLink-1 active" href="#">${s}</a>
                <#else>
                    <a class="dropdown-item mdb-dropdownLink-1" href="${url}?page=${page.getNumber()}&size=${s}&search=${search!''}">${s}</a>
                </#if>
            </#list>
        </div>
        <button type="button" class="btn btn-primary btn-sm dropdown-toggle px-3" data-toggle="dropdown" aria-haspopup="true"
                aria-expanded="false">
        </button>
    </div>

</#macro>