<#macro adminSidebar activeUrl>

    <!-- Sidebar -->
    <div class="sidebar-fixed position-fixed">

        <a class="logo-wrapper waves-effect d-flex justify-content-center">
            <img src="https://www.psu.by/images/psu-logo.png" class="img-fluid" alt="">
        </a>

        <div class="list-group list-group-flush">
            <a href="/admin"
               class="list-group-item list-group-item<#if  activeUrl == '/admin'> active<#else>-action</#if> waves-effect">
                <i class="fas fa-chart-pie mr-3"></i>Админ панель</a>
            <a href="/admin/users"
               class="list-group-item list-group-item<#if activeUrl == '/admin/users'> active<#else>-action</#if> waves-effect">
                <i class="fas fa-users mr-3"></i>Пользователи</a>
        </div>

    </div>
    <!-- Sidebar -->

</#macro>