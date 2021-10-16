<#import "parts/adminCommon.ftlh" as aC>

<@aC.adminPage '/admin/users'>

    <!-- Heading -->
    <div class="card mb-4 wow pink lighten-3 fadeIn">

        <!--Card content-->
        <div class="card-body d-sm-flex justify-content-between">

            <h4 class="mb-2 mb-sm-0 pt-1">
                <a href="/admin" target="_blank">Админ панель</a>
                <span>/</span>
                <span>Пользователи</span>
            </h4>

            <#--<form action="/admin/users" method="get" class="d-flex justify-content-center">
                <input type="search" name="search" value="${search?ifExists}"
                       placeholder="Введите имя для поиска" aria-label="Поиск" class="form-control">
                <button class="btn btn-primary btn-sm my-0 p" type="submit">
                    <i class="fas fa-search"></i>
                </button>

            </form>-->
            <#--            <form id="searchUsers" action="/admin/users" method="get" class="d-flex justify-content-center">

                            <input type="search" name="search" value="${search!''}"
                                   placeholder="Введите имя для поиска" aria-label="Поиск" class="form-control">

                            <button class="btn btn-primary btn-sm my-0 p" type="submit"
                                    &lt;#&ndash;onclick="location.href = '/admin/users?page=${users.getNumber()}&size=${users.getSize()}&sort=${sort}&dir=${dir}&search=${search}'"&ndash;&gt;
                            >
                                <i class="fas fa-search"></i>
                            </button>


                        </form>-->

        </div>

    </div>
    <!-- Heading -->

    <!--Grid row-->
    <div class="row wow fadeIn">

        <!--Grid column-->
        <div class="col-md-12 mb-4">

            <!-- Users table -->
            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Пользователи</h3>
                </div>

                <div class="card-body">

                    <a href="/admin/user/create" type="button"
                       class="text-success my-0 float-right mb-3 mr-2">
                        <i class="fas fa-user-plus fa-2x"></i>
                    </a>

                    <div class="table-responsive-sm table-responsive-md table-responsive-lg table-responsive-xl">

                        <table id="sortedUsersTable" class="table table-bordered table-striped text-center">

                            <thead>

                            <tr>

                                <th class="text-center font-weight-bold">
                                    № п/п
                                </th>

                                <th class="text-center font-weight-bold">
                                    Имя
                                </th>

                                <th class="text-center font-weight-bold">
                                    Логин
                                </th>

                                <th class="text-center font-weight-bold">
                                    E-mail
                                </th>

                                <th class="text-center font-weight-bold">
                                    Статус
                                </th>

                                <th class="text-center font-weight-bold">
                                    Роль
                                </th>

                                <th class="text-center font-weight-bold">
                                    Редактировать
                                </th>

                                <th class="text-center font-weight-bold">
                                    Управлять
                                </th>

                            </tr>

                            </thead>

                            <tbody>

                            <#list users as user>
                                <tr>

                                    <td class="pt-3-half font-weight-bold">
                                        ${user.userId!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${user.fullname!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${user.username!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${user.email!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${user.active?then('Активный', 'Неактивный')}
                                    </td>

                                    <td class="pt-3-half">
                                        <#list user.roles as role>
                                            <#if role.name() == '_1_ADMIN'>
                                                Администратор
                                            <#elseIf role.name() == '_2_TEACHER'>
                                                Преподаватель
                                            <#elseIf role.name() == '_3_STUDENT'>
                                                Студент
                                            </#if>
                                            <#sep><br/>
                                        </#list>
                                    </td>

                                    <td class="pt-3-half">
                                        <a href="/admin/user/${user.userId}/update" type="button"
                                           class="text-primary btn-sm my-0">
                                            <i class="fas fa-user-edit fa-2x"></i>
                                        </a>
                                    </td>

                                    <td class="pt-3-half">
                                        <form id="deleteUser${user.userId}" action="/admin/user/${user.userId}/activate"
                                              method="get">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                            <#--{user.active?then('ДЕАКТИВИРОВАТЬ', 'АКТИВИРОВАТЬ')}-->
                                            <#if user.active>
                                                <a href="#" type="submit"
                                                   onclick="document.getElementById('deleteUser${user.userId}').submit()"
                                                   class="text-danger my-0">
                                                    <i class="fas fa-user-times fa-2x"></i>
                                                </a>
                                            <#else>
                                                <a href="#" type="submit"
                                                   onclick="document.getElementById('deleteUser${user.userId}').submit()"
                                                   class="text-info my-0">
                                                    <#--<i class="fas fa-user-check"></i>-->
                                                    <i class="fas fa-user-check fa-2x"></i>
                                                </a>
                                            </#if>
                                        </form>
                                    </td>

                                </tr>
                            </#list>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>
        </div>
        <!-- Users table -->

    </div>
    <!--Grid column-->

    </div>
    <!--Grid row-->

</@aC.adminPage>
