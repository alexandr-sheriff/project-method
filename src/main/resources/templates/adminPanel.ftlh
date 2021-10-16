<#import "parts/adminCommon.ftlh" as aC>

<@aC.adminPage '/admin'>

    <!-- Heading -->
    <div class="card mb-4 wow pink lighten-3 fadeIn">

        <!--Card content-->
        <div class="card-body d-sm-flex justify-content-between">

            <h4 class="mb-2 mb-sm-0 pt-1">
                <span>Админ панель</span>
            </h4>

        </div>

    </div>
    <!-- Heading -->

    <!--Grid row-->
    <div class="row wow fadeIn">

        <!--Grid column-->
        <div class="col-md-9 mb-4">

            <!--Card-->
            <div class="card">

                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Всего проектов</h3>
                </div>

                <!--Card content-->
                <div class="card-body">

                    <canvas id="myChart">
                        <#list countProjectStatuses as countProjectStatus>
                            <input type="hidden" id="countProjectStatus[${countProjectStatus_index}]"
                                   value="${countProjectStatus}"></input>
                        </#list>
                    </canvas>

                </div>

            </div>
            <!--/.Card-->

        </div>
        <!--Grid column-->

        <!--Grid column-->
        <div class="col-md-3 mb-4">

            <!--Card-->
            <div class="card">

                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">% проектов</h3>
                </div>

                <!--Card content-->
                <div class="card-body">

                    <!-- List group links -->
                    <div class="list-group list-group-flush">
                        <a class="list-group-item list-group-item-action waves-effect">Завершено
                            <span class="badge badge-success badge-pill pull-right">${percentageProjectStatuses[6]}%</span>
                        </a>
                        <a class="list-group-item list-group-item-action waves-effect">Проверено
                            <span class="badge badge-secondary badge-pill pull-right">${percentageProjectStatuses[5]}%</span>
                        </a>
                        <a class="list-group-item list-group-item-action waves-effect">На проверке
                            <span class="badge badge-danger badge-pill pull-right">${percentageProjectStatuses[4]}%</span>
                        </a>
                        <a class="list-group-item list-group-item-action waves-effect">Выполнено
                            <span class="badge badge-warning badge-pill pull-right">${percentageProjectStatuses[3]}%</span>
                        </a>
                        <a class="list-group-item list-group-item-action waves-effect">В работе
                            <span class="badge badge-primary badge-pill pull-right">${percentageProjectStatuses[2]}%</span>
                        </a>
                        <a class="list-group-item list-group-item-action waves-effect">Надо сделать
                            <span class="badge badge-light badge-pill pull-right">${percentageProjectStatuses[1]}%</span>
                        </a>
                        <a class="list-group-item list-group-item-action waves-effect">В ожидании
                            <span class="badge badge-dark badge-pill pull-right">${percentageProjectStatuses[0]}%</span>
                        </a>
                    </div>
                    <!-- List group links -->

                </div>

            </div>
            <!--/.Card-->

        </div>
        <!--Grid column-->

    </div>
    <!--Grid row-->

    <!--Grid row-->
    <div class="row wow fadeIn">

        <!--Grid column-->
        <div class="col-lg-12 col-md-12 mb-4">

            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Рейтинг проектов</h3>
                </div>
                <div class="card-body">


                    <div class="table-responsive-sm table-responsive-md table-responsive-lg table-responsive-xl">

                        <table name="sortedRatingsTable" class="table table-bordered table-striped text-center">

                            <thead>

                            <tr>

                                <th class="text-center font-weight-bold">
                                    № п/п
                                </th>

                                <th class="text-center font-weight-bold">
                                    Проект
                                </th>

                                <th class="text-center font-weight-bold">
                                    Создатель
                                </th>

                                <th class="text-center font-weight-bold">
                                    Рейтинг
                                </th>

                                <th class="text-center font-weight-bold">
                                    Перейти
                                </th>

                            </tr>

                            </thead>

                            <tbody>

                            <#list projects?sort_by("projectRating")?reverse as project>
                                <tr>

                                    <td class="pt-3-half">
                                        ${project_index+1!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${project.projectName!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${project.projectLead.fullname!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${project.projectRating!''}
                                    </td>

                                    <td class="pt-3-half">
                                        <a href="/projects/project/${project.projectId}"
                                           type="button"
                                           target="_blank"
                                           class="text-primary btn-sm my-0">
                                            <i class="fas fa-external-link-alt fa-2x"></i>
                                        </a>
                                    </td>

                                </tr>
                            </#list>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

        </div>
        <!--Grid column-->

    </div>
    <!--Grid row-->

    <!--Grid row-->
    <div class="row wow fadeIn">

        <!--Grid column-->
        <div class="col-lg-12 col-md-12 mb-4">

            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Рейтинг студентов</h3>
                </div>
                <div class="card-body">


                    <div class="table-responsive-sm table-responsive-md table-responsive-lg table-responsive-xl">

                        <table name="sortedRatingsTable" class="table table-bordered table-striped text-center">

                            <thead>

                            <tr>

                                <th class="text-center font-weight-bold">
                                    № п/п
                                </th>

                                <th class="text-center font-weight-bold">
                                    Студент
                                </th>

                                <th class="text-center font-weight-bold">
                                    Проектов
                                </th>

                                <th class="text-center font-weight-bold">
                                    Рейтинг
                                </th>

                                <th class="text-center font-weight-bold">
                                    Перейти
                                </th>

                            </tr>

                            </thead>

                            <tbody>

                            <#list students?sort_by("userRating")?reverse as student>
                                <tr>

                                    <td class="pt-3-half">
                                        ${student_index+1!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${student.fullname!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${student.userTeams?size!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${student.userRating!''}
                                    </td>

                                    <td class="pt-3-half">
                                        <a href="/user/profile/${student.userId}"
                                           type="button"
                                           target="_blank"
                                           class="text-primary btn-sm my-0">
                                            <i class="fas fa-external-link-alt fa-2x"></i>
                                        </a>
                                    </td>

                                </tr>
                            </#list>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

        </div>
        <!--Grid column-->

    </div>
    <!--Grid row-->

    <!--Grid row-->
    <div class="row wow fadeIn">

        <!--Grid column-->
        <div class="col-lg-12 col-md-12 mb-4">

            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Рейтинг преподавателей</h3>
                </div>
                <div class="card-body">


                    <div class="table-responsive-sm table-responsive-md table-responsive-lg table-responsive-xl">

                        <table name="sortedRatingsTable" class="table table-bordered table-striped text-center">

                            <thead>

                            <tr>

                                <th class="text-center font-weight-bold">
                                    № п/п
                                </th>

                                <th class="text-center font-weight-bold">
                                    Преподаватель
                                </th>

                                <th class="text-center font-weight-bold">
                                    Проектов
                                </th>

                                <th class="text-center font-weight-bold">
                                    Рейтинг
                                </th>

                                <th class="text-center font-weight-bold">
                                    Перейти
                                </th>

                            </tr>

                            </thead>

                            <tbody>

                            <#list teachers?sort_by("userRating")?reverse as teacher>
                                <tr>

                                    <td class="pt-3-half">
                                        ${teacher_index+1!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${teacher.fullname!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${teacher.userProjects?size!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${teacher.userRating!''}
                                    </td>

                                    <td class="pt-3-half">
                                        <a href="/user/profile/${teacher.userId}"
                                           type="button"
                                           target="_blank"
                                           class="text-primary btn-sm my-0">
                                            <i class="fas fa-external-link-alt fa-2x"></i>
                                        </a>
                                    </td>

                                </tr>
                            </#list>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

        </div>
        <!--Grid column-->

    </div>
    <!--Grid row-->

</@aC.adminPage>
