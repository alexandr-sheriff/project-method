<#include "security.ftlh">

<!-- Navbar -->
<nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
    <div class="container">

        <!-- Image and text -->
        <nav class="">
            <a class="" href="https://www.psu.by">
                <img src="https://www.psu.by/images/psu-logo.png" height="35" class="d-inline-block align-top"
                     alt="Полоцкий государственный университет">
            </a>
        </nav>

        <!-- Collapse -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <#if isAuthorized>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">

                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/admin" target="_blank">Админ панель</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/admin/users" target="_blank">Пользователи</a>
                    </li>
                    <#if isTeacher || isStudent>
                        <li class="nav-item">
                            <a class="nav-link" href="/projects" target="_blank">Проекты</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/projects/user/${currentUserId}" target="_blank">Мои проекты</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/projects/statistics-history/user/${currentUserId}" target="_blank">Панель
                                проектов</a>
                        </li>
                    </#if>
                </ul>

                <ul class="navbar-nav ml-auto nav-flex-icons">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-333" data-toggle="dropdown"
                           aria-haspopup="true" aria-expanded="false">
                            <#if currentUser.userImage?hasContent>
                                <img alt="" class="ava-min rounded-circle mx-auto"
                                     src="/files/${currentUser.userImage}">
                            <#else>
                                <img alt="" class="ava-min rounded-circle mx-auto"
                                     src="/files/c81ff85f11db9ff8a23d6dc29c8b8b7e.png">
                            </#if>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-default"
                             aria-labelledby="navbarDropdownMenuLink-333">
                            <a class="dropdown-item" href="/user/profile/${currentUserId}">Профиль</a>
                            <a class="dropdown-item" href="/user/profile/${currentUserId}/settings">Настройки</a>
                            <a class="dropdown-item" href="/projects/statistics-history/user/${currentUserId}">Панель
                                проектов</a>
                            <a class="dropdown-item" href="/logout">Выйти</a>
                        </div>
                    </li>
                </ul>

            </div>
        </#if>

    </div>
</nav>
<!-- Navbar -->