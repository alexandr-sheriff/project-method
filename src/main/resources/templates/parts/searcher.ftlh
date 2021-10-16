<#macro searcher page>

    <div id="searchForm" class="form-inline ml-auto">
        <input type="search" id="search" name="search" value="${search!''}" onsearch="OnSearch(this)"
               placeholder="Поиск" aria-label="Поиск" class="form-control">

        <button class="btn btn-primary btn-rounded btn-sm my-0 ml-sm-2" type="button"
                onclick="search()"
        >
            Найти
            <#--<i class="fas fa-search"></i>-->
        </button>
        <script>
            function search() {
                const searchValue = document.getElementById('search').value
                window.location.href = '${url}?page=${page.getNumber()}&size=${page.getSize()}&search=' + searchValue
            }

            function OnSearch(input) {
                if (input.value == "") {
                    window.location.href = '${url}?page=${page.getNumber()}&size=${page.getSize()}&search='
                }
            }
        </script>
    </div>

</#macro>
