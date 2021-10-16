<#macro sorterASC sortBy page>

    <span class="table-up">
        <a href="${url}?page=${page.getNumber()}&size=${page.getSize()}&sort=${sortBy}&dir=ASC&search=${search!''}" class="indigo-text">
            <i class="fas fa-long-arrow-alt-up" aria-hidden="true"></i>
        </a>
    </span>

</#macro>