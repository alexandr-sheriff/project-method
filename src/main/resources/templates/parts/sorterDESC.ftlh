<#macro sorterDESC sortBy page>

    <span class="table-down">
        <a href="${url}?page=${page.getNumber()}&size=${page.getSize()}&sort=${sortBy}&dir=DESC&search=${search!''}" class="indigo-text">
            <i class="fas fa-long-arrow-alt-down" aria-hidden="true"></i>
        </a>
    </span>

</#macro>