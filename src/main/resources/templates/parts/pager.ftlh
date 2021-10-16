<#macro pager page place>
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

    <nav class="d-flex justify-content-${place} wow fadeIn">
        <ul class="pagination pg-blue-grey">
            <li class="page-item<#if page.getNumber() == 0> disabled</#if>">
                <a class="page-link"
                   href="${url}?page=${page.getNumber() - 1}&size=${page.getSize()}&search=${search!''}"
                   aria-label="Предыдущая">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <#list body as p>
                <#if (p - 1) == page.getNumber()>
                    <li class="page-item active" aria-current="page">
                        <a class="page-link" href="#" tabindex="-1">${p}<span
                                    class="sr-only">(current)</span></a>
                    </li>
                <#elseif p == -1>
                    <li class="page-item disabled" aria-current="page">
                        <a class="page-link" href="#"
                           tabindex="-1">...</a>
                    </li>
                <#elseif p != 0>
                    <li class="page-item" aria-current="page">
                        <a class="page-link"
                           href="${url}?page=${p - 1}&size=${page.getSize()}&search=${search!''}"
                           tabindex="-1">${p}</a>
                    </li>
                </#if>
            </#list>
            <li class="page-item<#if page.getNumber() == page.getTotalPages() - 1> disabled</#if>">
                <a class="page-link"
                   href="${url}?page=${page.getNumber() + 1}&size=${page.getSize()}&search=${search!''}"
                   aria-label="Следующая">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>

</#macro>