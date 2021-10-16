<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>

    <div class="row">
        <div class="col-md-12 mx-auto">
            <div class="card mb-4 wow pink lighten-3 fadeIn">
                <div class="card-body d-sm-flex justify-content-between">
                    <h4 class="mb-2 mb-sm-0 pt-1">
                        <a href="/projects" target="_blank">Проекты</a>
                        <span>/</span>
                        <span>Проект "${project.projectName?upperCase}"</span>
                    </h4>
                </div>
            </div>
        </div>
    </div>

    <!--Section: Project-->
    <section>

        <!--Grid row-->
        <div class="row">

            <!--Grid column-->
            <div class="col-md-8 mb-4 mx-auto">

                <#if project.projectImage?hasContent>
                    <!--Featured Image-->
                    <div class="card mb-4 wow fadeIn">

                        <img src="/files/${project.projectImage}" class="img-fluid img-thumbnail" alt="">

                    </div>
                    <!--/.Featured Image-->
                </#if>

                <!--Card-->
                <div class="card mb-4 wow fadeIn">

                    <!--Card content-->
                    <div class="card-body text-center">

                        <p class="h5 my-4"><b>${project.projectName!''}</b></p>

                        <#if project.projectStatus.name() == '_1_BACKLOG'>
                            <h5><span class="badge badge-dark">В ожидании</span></h5>
                        <#elseIf project.projectStatus.name() == '_2_TO_DO'>
                            <h5><span class="badge badge-light">Надо сделать</span></h5>
                        <#elseIf project.projectStatus.name() == '_3_IN_PROGRESS'>
                            <h5><span class="badge badge-primary">В работе</span></h5>
                        <#elseIf project.projectStatus.name() == '_4_DONE'>
                            <h5><span class="badge badge-warning">Выполнен</span></h5>
                        <#elseIf project.projectStatus.name() == '_5_ON_CHECK'>
                            <h5><span class="badge badge-danger">На проверке</span></h5>
                        <#elseIf project.projectStatus.name() == '_6_VERIFIED'>
                            <h5><span class="badge badge-secondary">Проверен</span></h5>
                        <#elseIf project.projectStatus.name() == '_7_COMPLETED'>
                            <h5><span class="badge badge-success">Завершен</span></h5>
                        </#if>

                        <#if currentUser == project.projectLead>

                            <hr>

                            <#if !project.projectStarted && stages?hasContent && teams?hasContent && teamsWithCaptains>
                                <button type="button"
                                        onClick='location.href="/projects/project/${project.projectId}/start"'
                                        class="btn btn-success btn-md mr-0"><i class="fas fa-play pr-2"></i>Запустить
                                    проект
                                </button>
                            <#elseIf project.projectStarted && project.projectStatus.name() == '_7_COMPLETED' && !project.projectFinished>
                                <button type="button"
                                        onClick='location.href="/projects/project/${project.projectId}/finish"'
                                        class="btn btn-danger btn-md mr-0"><i class="fas fa-play pr-2"></i>Завершить
                                    проект
                                </button>
                            <#elseIf project.projectStarted && project.projectFinished>
                                <button type="button"
                                        onClick='location.href="/projects/project/${project.projectId}/statistics"'
                                        class="btn btn-outline-secondary btn-md mr-0"><i
                                            class="fas fa-calculator pr-2"></i>Статистика
                                </button>
                            </#if>

                            <div class="d-block btn-group" role="group">
                                <#if !project.projectStarted>
                                    <button type="button"
                                            onClick='location.href="/projects/project/${project.projectId}/stage/create"'
                                            class="btn btn-secondary btn-md mr-0">Добавить этап
                                    </button>
                                </#if>
                                <#if !project.projectStarted && users?hasContent>
                                    <button type="button"
                                            onClick='location.href="/projects/project/${project.projectId}/team/create"'
                                            class="btn btn-secondary btn-md">Добавить участников
                                    </button>
                                </#if>
                                <#if project.projectStarted && !project.projectFinished>
                                    <div class="btn-group" role="group">
                                        <button id="btnGroupDrop1" type="button"
                                                class="btn btn-pink btn-md dropdown-toggle"
                                                data-toggle="dropdown"
                                                aria-haspopup="true" aria-expanded="false">Сменить статус
                                        </button>
                                        <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                            <#if project.projectStatus.name() == '_2_TO_DO'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/status/update?status=_1_BACKLOG">В
                                                    ожидании</a>
                                            </#if>
                                            <#if project.projectStatus.name() == '_1_BACKLOG' || project.projectStatus.name() == '_3_IN_PROGRESS'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/status/update?status=_2_TO_DO">Надо
                                                    сделать</a>
                                            </#if>
                                            <#if project.projectStatus.name() == '_2_TO_DO' || project.projectStatus.name() == '_4_DONE'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/status/update?status=_3_IN_PROGRESS">В
                                                    работе</a>
                                            </#if>
                                            <#if project.projectStatus.name() == '_3_IN_PROGRESS' || project.projectStatus.name() == '_5_ON_CHECK'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/status/update?status=_4_DONE">Выполнен</a>
                                            </#if>
                                            <#if project.projectStatus.name() == '_4_DONE' || project.projectStatus.name() == '_6_VERIFIED'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/status/update?status=_5_ON_CHECK">На
                                                    проверке</a>
                                            </#if>
                                            <#if project.projectStatus.name() == '_5_ON_CHECK' || project.projectStatus.name() == '_7_COMPLETED'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/status/update?status=_6_VERIFIED">Проверен</a>
                                            </#if>
                                            <#if project.projectStatus.name() == '_6_VERIFIED'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/status/update?status=_7_COMPLETED">Завершен</a>
                                            </#if>

                                        </div>
                                    </div>
                                </#if>
                            </div>
                        <#else>
                            <hr>
                            <#if project.projectStarted && project.projectFinished>
                                <button type="button"
                                        onClick='location.href="/projects/project/${project.projectId}/statistics"'
                                        class="btn btn-outline-secondary btn-md mr-0"><i
                                            class="fas fa-calculator pr-2"></i>Статистика
                                </button>
                            </#if>
                        </#if>
                        <#if currentUser == project.projectLead || userInProjectTeam>
                            <div class="d-block btn-group" role="group">
                                <a href="/projects/project/${project.projectId}/chat" type="button"
                                   class="btn btn-outline-primary waves-effect">
                                    <i class="fas fa-comment-alt pr-2" aria-hidden="true"></i>Чат</a>
                            </div>
                        </#if>

                    </div>
                    <!-- Card footer -->
                    <div class="rounded-bottom mdb-color lighten-3 text-center pt-3">
                        <ul class="list-unstyled list-inline font-small white-text">
                            <li>Сдача ${(project.projectTheoreticalLeadTime.format("dd/MM/yyyy, HH:mm"))!''}</li>
                            <#if project.projectStartTime?hasContent>
                                <li>Старт ${(project.projectStartTime.format("dd/MM/yyyy, HH:mm"))!''}</li>
                            </#if>
                            <#if project.projectEndTime?hasContent>
                                <li>Завершение ${(project.projectEndTime.format("dd/MM/yyyy, HH:mm"))!''}</li>
                            </#if>
                        </ul>
                    </div>
                </div>
                <!--/.Card-->

                <div class="card mb-4 wow fadeIn">
                    <div class="card-header font-weight-bold">Цели проекта</div>
                    <div class="card-body">
                        <blockquote class="blockquote">
                            <p class="mb-0">${project.projectGoals!''}</p>
                        </blockquote>
                    </div>
                </div>
                <div class="card mb-4 wow fadeIn">
                    <div class="card-header font-weight-bold">Задачи проекта</div>
                    <div class="card-body">
                        <blockquote class="blockquote">
                            <p class="mb-0">${project.projectTasks!''}</p>
                        </blockquote>
                    </div>
                </div>

                <div class="card mb-4 wow fadeIn">
                    <div class="card-header font-weight-bold">Описание проекта</div>
                    <div class="card-body">
                        <p>${project.projectDescription!''}</p>
                    </div>
                </div>

                <#if project.projectFiles?hasContent>
                    <div class="card mb-4 wow fadeIn">
                        <div class="card-header font-weight-bold">Файлы проекта</div>
                        <div class="card-body">
                            <div class="list-group">
                                <#list project.projectFiles as file>
                                    <a href="/files/${file.encodedFilename}" download="${file.filename}"
                                       class="list-group-item list-group-item-action">${file.filename}</a>
                                </#list>
                            </div>
                        </div>
                    </div>
                </#if>


                <#if project.projectStages?hasContent>
                    <h5 class="section-heading mb-4">
                        Этапы проекта
                    </h5>

                    <hr>

                    <#if stages?hasContent>
                        <#list stages?chunk(3) as stagesrow>
                            <!-- Grid row -->
                            <div class="row mb-4 wow fadeIn">
                                <#list stagesrow as stage>
                                    <!-- Grid column -->
                                    <div class="col-lg-4 col-md-12 mb-4">


                                        <!-- Panel -->
                                        <div class="card rounded-top text-center">
                                            <div class="ml-auto pr-1">${stage_index + (stagesrow_index * 3) + 1}/${stages?size}</div>


                                            <#if stage.stageImage?hasContent>
                                                <!-- Card image -->
                                                <div class="view overlay">
                                                    <img class="card-img-top" src="/files/${stage.stageImage}"
                                                         alt="Card image cap">
                                                    <a>
                                                        <div class="mask rgba-white-slight"></div>
                                                    </a>
                                                </div>
                                            </#if>

                                            <!-- Card content -->
                                            <div class="card-body">
                                                <!-- Title -->
                                                <h4 class="card-title">
                                                    <#if currentUser == project.projectLead>
                                                        <a href="/projects/project/${project.projectId}/stage/${stage.stageId}">${stage.stageName}</a>
                                                    <#else>
                                                        ${stage.stageName}
                                                    </#if>
                                                </h4>
                                                <#if stage.stageStatus.name() == '_1_BACKLOG'>
                                                    <h5><span class="badge badge-dark">В ожидании</span></h5>
                                                <#elseIf stage.stageStatus.name() == '_2_TO_DO'>
                                                    <h5><span class="badge badge-light">Надо сделать</span></h5>
                                                <#elseIf stage.stageStatus.name() == '_3_IN_PROGRESS'>
                                                    <h5><span class="badge badge-primary">В работе</span></h5>
                                                <#elseIf stage.stageStatus.name() == '_4_DONE'>
                                                    <h5><span class="badge badge-warning">Выполнен</span></h5>
                                                <#elseIf stage.stageStatus.name() == '_5_ON_CHECK'>
                                                    <h5><span class="badge badge-danger">На проверке</span></h5>
                                                <#elseIf stage.stageStatus.name() == '_6_VERIFIED'>
                                                    <h5><span class="badge badge-secondary">Проверен</span></h5>
                                                <#elseIf stage.stageStatus.name() == '_7_COMPLETED'>
                                                    <h5><span class="badge badge-success">Завершен</span></h5>
                                                </#if>

                                                <#if currentUser == project.projectLead>

                                                    <hr>

                                                    <#if stage.stageStatus.name() != '_1_BACKLOG' && teams?hasContent>
                                                        <div class="btn-group-vertical" role="group">
                                                            <button id="stageTeam" type="button"
                                                                    class="btn btn-info btn-md dropdown-toggle"
                                                                    data-toggle="dropdown"
                                                                    aria-haspopup="true" aria-expanded="false">
                                                                Перейти к
                                                            </button>
                                                            <div class="dropdown-menu"
                                                                 aria-labelledby="stageTeam">
                                                                <#list teams as team>
                                                                    <a class="dropdown-item"
                                                                       href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}">${team.teamName}</a>
                                                                </#list>
                                                            </div>
                                                        </div>
                                                    </#if>

                                                    <#if project.projectStarted && !project.projectFinished>
                                                        <div class="btn-group" role="group">
                                                            <button id="btnGroupDrop1" type="button"
                                                                    class="btn btn-pink btn-md dropdown-toggle"
                                                                    data-toggle="dropdown"
                                                                    aria-haspopup="true" aria-expanded="false">Сменить
                                                                статус
                                                            </button>
                                                            <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                                                <#if stage.stageStatus.name() == '_2_TO_DO'>
                                                                    <a class="dropdown-item"
                                                                       href="/projects/project/${project.projectId}/stage/${stage.stageId}/status/update?status=_1_BACKLOG">В
                                                                        ожидании</a>
                                                                </#if>
                                                                <#if stage.stageStatus.name() == '_1_BACKLOG' || stage.stageStatus.name() == '_3_IN_PROGRESS'>
                                                                    <a class="dropdown-item"
                                                                       href="/projects/project/${project.projectId}/stage/${stage.stageId}/status/update?status=_2_TO_DO">Надо
                                                                        сделать</a>
                                                                </#if>
                                                                <#if stage.stageStatus.name() == '_2_TO_DO' || stage.stageStatus.name() == '_4_DONE'>
                                                                    <a class="dropdown-item"
                                                                       href="/projects/project/${project.projectId}/stage/${stage.stageId}/status/update?status=_3_IN_PROGRESS">В
                                                                        работе</a>
                                                                </#if>
                                                                <#if stage.stageStatus.name() == '_3_IN_PROGRESS' || stage.stageStatus.name() == '_5_ON_CHECK'>
                                                                    <a class="dropdown-item"
                                                                       href="/projects/project/${project.projectId}/stage/${stage.stageId}/status/update?status=_4_DONE">Выполнен</a>
                                                                </#if>
                                                                <#if stage.stageStatus.name() == '_4_DONE' || stage.stageStatus.name() == '_6_VERIFIED'>
                                                                    <a class="dropdown-item"
                                                                       href="/projects/project/${project.projectId}/stage/${stage.stageId}/status/update?status=_5_ON_CHECK">На
                                                                        проверке</a>
                                                                </#if>
                                                                <#if stage.stageStatus.name() == '_5_ON_CHECK' || stage.stageStatus.name() == '_7_COMPLETED'>
                                                                    <a class="dropdown-item"
                                                                       href="/projects/project/${project.projectId}/stage/${stage.stageId}/status/update?status=_6_VERIFIED">Проверен</a>
                                                                </#if>
                                                                <#if stage.stageStatus.name() == '_6_VERIFIED'>
                                                                    <a class="dropdown-item"
                                                                       href="/projects/project/${project.projectId}/stage/${stage.stageId}/status/update?status=_7_COMPLETED">Завершен</a>
                                                                </#if>
                                                            </div>
                                                        </div>
                                                    </#if>
                                                </#if>

                                                <#if project.projectStarted>
                                                    <#if userInProjectTeam>
                                                        <hr>
                                                        <button type="button"
                                                                onClick='location.href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${userTeam}"'
                                                                class="btn btn-info btn-md mr-0">Перейти
                                                        </button>
                                                    </#if>
                                                </#if>


                                            </div>
                                            <!-- Card footer -->
                                            <div class="rounded-bottom mdb-color lighten-3 text-center pt-3">
                                                <ul class="list-unstyled list-inline font-small white-text">
                                                    <li>
                                                        Сдача ${(stage.stageTheoreticalLeadTime.format("dd/MM/yyyy, HH:mm"))!''}</li>
                                                    <#if stage.stageStartTime?hasContent>
                                                        <li>
                                                            Старт ${(stage.stageStartTime.format("dd/MM/yyyy, HH:mm"))!''}</li>
                                                    </#if>
                                                    <#if stage.stageEndTime?hasContent>
                                                        <li>
                                                            Завершение ${(stage.stageEndTime.format("dd/MM/yyyy, HH:mm"))!''}</li>
                                                    </#if>
                                                </ul>
                                            </div>


                                        </div>
                                        <!-- Panel -->

                                    </div>

                                </#list>

                            </div>
                        </#list>
                    </#if>
                </#if>

            </div>
            <!--Grid column-->

            <#if project.projectTeams?hasContent>
                <!--Grid column-->
                <div class="col-md-4 mb-4">

                    <h5 class="section-heading mb-4">
                        Создатель проекта
                    </h5>

                    <hr>
                    <!--Card-->
                    <div class="card mb-4 wow fadeIn">

                        <!--Card content-->
                        <div class="card-body">
                            <ul class="list-group list-group-flush">

                                <li class="list-group-item d-flex justify-content-start align-items-center">
                                    <#if project.projectLead.userImage?hasContent>
                                        <a href="/user/profile/${project.projectLead.userId}"><img
                                                    alt="${project.projectLead.fullname}"
                                                    src="/files/${project.projectLead.userImage}"
                                                    class="ava-min rounded-circle"></a>
                                    <#else>
                                        <a href="/user/profile/${project.projectLead.userId}"><img
                                                    alt="${project.projectLead.fullname}"
                                                    class="ava-min rounded-circle"
                                                    src="/files/c81ff85f11db9ff8a23d6dc29c8b8b7e.png"></a>
                                    </#if>
                                    <span>&ensp;</span>
                                    <a href="/user/profile/${project.projectLead.userId}">${project.projectLead.fullname}</a>
                                </li>
                            </ul>
                        </div>

                    </div>
                    <!--/.Card-->

                    <h5 class="section-heading mb-4">
                        Участники проекта
                    </h5>

                    <hr>

                    <#if teams?hasContent>
                        <#list teams as team>
                            <!--Card-->
                            <div class="card mb-4 wow fadeIn">

                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <#if currentUser == project.projectLead || team.teamUsers?seqContains(currentUser)>
                                        <a href="/projects/project/${project.projectId}/team/${team.teamId}">${team.teamName}</a>
                                        <a href="/projects/project/${project.projectId}/team/${team.teamId}/chat"
                                           type="button" class="btn btn-outline-primary btn-sm waves-effect"><i
                                                    class="fas fa-comment-alt pr-2" aria-hidden="true"></i>Чат</a>
                                    <#else>
                                        ${team.teamName}
                                    </#if>
                                </div>

                                <!--Card content-->
                                <div class="card-body">
                                    <ul class="list-group list-group-flush">
                                        <#list team.teamUsers as teamUser>

                                            <li class="list-group-item d-flex justify-content-start align-items-center">
                                                <#if teamUser.userImage?hasContent>
                                                    <a href="/user/profile/${teamUser.userId}"><img
                                                                alt="${teamUser.fullname}"
                                                                src="/files/${teamUser.userImage}"
                                                                class="ava-min rounded-circle"></a>
                                                <#else>
                                                    <a href="/user/profile/${teamUser.userId}"><img
                                                                alt="${teamUser.fullname}"
                                                                class="ava-min rounded-circle"
                                                                src="/files/c81ff85f11db9ff8a23d6dc29c8b8b7e.png"></a>
                                                </#if>
                                                <span>&ensp;</span>
                                                <a href="/user/profile/${teamUser.userId}">${teamUser.fullname}</a>
                                                <#if !team.teamCaptain?hasContent && currentUser == project.projectLead && !project.projectFinished>
                                                    <a class="ml-auto"
                                                       href="/projects/project/${project.projectId}/team/${team.teamId}/assign/captain/${teamUser.userId}">
                                                        <i style="color: #9933cc" class="far fa-check-circle"></i>
                                                    </a>
                                                <#elseIf team.teamCaptain?hasContent>
                                                    <#if (currentUser == project.projectLead || currentUser == team.teamCaptain)  && !project.projectFinished>
                                                        <#if teamUser == team.teamCaptain>
                                                            <span style="color: #9933cc"
                                                                  class="fas fa-check-circle ml-auto"></span>
                                                        <#else>
                                                            <a class="ml-auto"
                                                               href="/projects/project/${project.projectId}/team/${team.teamId}/assign/captain/${teamUser.userId}">
                                                                <i style="color: #9933cc"
                                                                   class="far fa-check-circle"></i>
                                                            </a>
                                                        </#if>
                                                    <#else>
                                                        <#if teamUser == team.teamCaptain>
                                                            <span style="color: #9933cc"
                                                                  class="fas fa-check-circle ml-auto"></span>
                                                        </#if>
                                                    </#if>
                                                </#if>
                                            </li>

                                        </#list>
                                    </ul>
                                </div>

                            </div>
                            <!--/.Card-->
                        </#list>
                    </#if>

                </div>
            <#else>
                <div class="col-md-4 mb-4">

                    <h5 class="section-heading mb-4">
                        Создатель проекта
                    </h5>

                    <hr>
                    <!--Card-->
                    <div class="card mb-4 wow fadeIn">

                        <!--Card content-->
                        <div class="card-body">
                            <ul class="list-group list-group-flush">

                                <li class="list-group-item d-flex justify-content-start align-items-center">
                                    <#if project.projectLead.userImage?hasContent>
                                        <a href="/user/profile/${project.projectLead.userId}"><img
                                                    alt="${project.projectLead.fullname}"
                                                    src="/files/${project.projectLead.userImage}"
                                                    class="ava-min rounded-circle"></a>
                                    <#else>
                                        <a href="/user/profile/${project.projectLead.userId}"><img
                                                    alt="${project.projectLead.fullname}"
                                                    class="ava-min rounded-circle"
                                                    src="/files/c81ff85f11db9ff8a23d6dc29c8b8b7e.png"></a>
                                    </#if>
                                    <span>&ensp;</span>
                                    <a href="/user/profile/${project.projectLead.userId}">${project.projectLead.fullname}</a>
                                </li>
                            </ul>
                        </div>

                    </div>
                    <!--/.Card-->
                </div>
                <!--Grid column-->
            </#if>


        </div>
        <!--Grid row-->

    </section>
    <!--Section: Project-->
</@c.page>