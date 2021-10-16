<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <!-- Heading -->
    <div class="card mb-4 wow pink lighten-3 fadeIn">

        <!--Card content-->
        <div class="card-body d-sm-flex justify-content-between">

            <h4 class="mb-2 mb-sm-0 pt-1">
                <a href="/projects" target="_blank">Проекты</a>
                <span>/</span>
                <span>Панель проектов<#-- <a href="/projects/user/${user.username}">--> ${user.username}<#--</a>--></span>
            </h4>

        </div>

    </div>
    <!-- Heading -->

    <!--Grid row-->
    <div class="row wow fadeIn">

        <!--Grid column-->
        <div class="col-md-12 mb-4">

            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Статистика</h3>
                </div>
                <div class="card-body">

                    <div class="col-md-12">
                        <div class="row text-center">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="card mb-3" style="max-width: 20rem;">
                                            <div class="card-body white-background">
                                                <h3>${projectsCount!''}</h3>
                                            </div>
                                            <div class="card-header text-white secondary-color">Всего проектов</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card mb-3" style="max-width: 20rem;">
                                            <div class="card-body white-background">
                                                <h3>${projectsRating!''} <i class="far fa-gem"></i></h3>
                                            </div>
                                            <div class="card-header text-white secondary-color">Рейтинг проектов
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card mb-3" style="max-width: 20rem;">
                                            <div class="card-body white-background">
                                                <h3>${projectSuccess!''}%</h3>
                                            </div>
                                            <div class="card-header text-white secondary-color">Успешных проектов
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Grid column-->
        <div class="col-md-12 mb-4">

            <!-- projects table -->
            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">История проектов</h3>
                </div>
                <div class="card-body">


                    <div class="table-responsive-sm table-responsive-md table-responsive-lg table-responsive-xl">

                        <table id="sortedHistoryProjectsTable" class="table table-bordered table-striped text-center">

                            <thead>

                            <tr>

                                <th class="text-center font-weight-bold">
                                    № п/п
                                </th>

                                <th class="text-center font-weight-bold">
                                    Название
                                </th>

                                <th class="text-center font-weight-bold">
                                    Создатель
                                </th>

                                <th class="text-center font-weight-bold">
                                    Статус
                                </th>

                                <th class="text-center font-weight-bold">
                                    Рейтинг
                                </th>

                                <th class="text-center font-weight-bold">
                                    Кол-во этапов
                                </th>

                                <th class="text-center font-weight-bold">
                                    Кол-во команд
                                </th>

                                <th class="text-center font-weight-bold">
                                    Перейти
                                </th>

                            </tr>

                            </thead>

                            <tbody>

                            <#list projects as project>
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
                                        <#if project.projectStatus.name() == '_1_BACKLOG'>
                                            <h5><span class="badge badge-dark"><span style="display: none">1</span>В ожидании</span></h5>
                                        <#elseIf project.projectStatus.name() == '_2_TO_DO'>
                                            <h5><span class="badge badge-light"><span style="display: none">2</span>Надо сделать</span></h5>
                                        <#elseIf project.projectStatus.name() == '_3_IN_PROGRESS'>
                                            <h5><span class="badge badge-primary"><span style="display: none">3</span>В работе</span></h5>
                                        <#elseIf project.projectStatus.name() == '_4_DONE'>
                                            <h5><span class="badge badge-warning"><span style="display: none">4</span>Выполнен</span></h5>
                                        <#elseIf project.projectStatus.name() == '_5_ON_CHECK'>
                                            <h5><span class="badge badge-danger"><span style="display: none">5</span>На проверке</span></h5>
                                        <#elseIf project.projectStatus.name() == '_6_VERIFIED'>
                                            <h5><span class="badge badge-secondary"><span style="display: none">6</span>Проверен</span></h5>
                                        <#elseIf project.projectStatus.name() == '_7_COMPLETED'>
                                            <h5><span class="badge badge-success"><span style="display: none">7</span>Завершен</span></h5>
                                        </#if>
                                    </td>

                                    <td class="pt-3-half">
                                        ${project.projectRating!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${project.projectStages?size!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${project.projectTeams?size!''}
                                    </td>

                                    <td class="pt-3-half">
                                        <a href="/projects/project/${project.projectId}" type="button"
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
        <!-- projects table -->

    </div>

</@c.page>