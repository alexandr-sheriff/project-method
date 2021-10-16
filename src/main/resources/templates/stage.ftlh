<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>

    <!-- Heading -->
    <div class="col-md-8 mx-auto card mb-4 wow pink lighten-3 fadeIn ">

        <!--Card content-->
        <div class="card-body d-sm-flex justify-content-between">

            <h4 class="mb-2 mb-sm-0 pt-1">
                <span><a href="/projects/project/${project.projectId}">Проект "${project.projectName?upperCase}"</a></span>
                <span>/</span>
                <span>Этап "${stage.stageName?upperCase}"</span>
            </h4>

        </div>

    </div>
    <!-- Heading -->

    <!--Section: Project-->
    <section class="mt-4">

        <!--Grid row-->
        <div class="row">

            <div class="col-md-2 mb-4"></div>

            <!--Grid column-->
            <div class="col-md-8 mb-4">

                <#if stage.stageImage?hasContent>
                    <div class="card mb-4 wow fadeIn">
                        <img src="/files/${stage.stageImage}" class="img-fluid" alt="">
                    </div>
                </#if>

                <!--Card-->
                <div class="card mb-4 wow fadeIn">

                    <!--Card content-->
                    <div class="card-body text-center">

                        <p class="h5 my-4"><b>${stage.stageName!''}</b></p>

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

                            <div class="d-block btn-group" role="group">
                                <#if !project.projectStarted>
                                    <button type="button"
                                            onClick='location.href="/projects/project/${project.projectId}/stage/create"'
                                            class="btn btn-secondary btn-md mr-0">Добавить этап
                                    </button>
                                </#if>

                                <#if project.projectStarted>
                                    <div class="btn-group-vertical" role="group">
                                        <button id="stageTeam" type="button"
                                                class="btn btn-pink btn-md dropdown-toggle"
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
                            </div>

                        <#--<div class="btn-group" role="group">
                            <button type="button"
                                    onClick='location.href="/projects/project/${project.projectId}"'
                                    class="btn btn-unique">Проект
                            </button>-->

                            <#if previousStage?hasContent || nextStage?hasContent>
                                <div class="btn-group" role="group">
                                    <#if previousStage?hasContent>
                                        <button type="button"
                                                onClick='location.href="/projects/project/${project.projectId}/stage/${previousStage.stageId}"'
                                                class="btn btn-info">Предыдущий этап
                                        </button>
                                    </#if>
                                    <#if nextStage?hasContent>
                                        <button type="button"
                                                onClick='location.href="/projects/project/${project.projectId}/stage/${nextStage.stageId}"'
                                                class="btn btn-info">Следующий этап
                                        </button>
                                    </#if>
                                </div>
                            </#if>
                        <#--</div>-->
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
                <!--/.Card-->

                <div class="card mb-4 wow fadeIn">
                    <div class="card-header font-weight-bold">Описание этапа</div>
                    <div class="card-body">
                        <p>${stage.stageDescription!''}</p>
                    </div>
                </div>

                <#if stage.stageFiles?hasContent>
                    <div class="card mb-4 wow fadeIn">
                        <div class="card-header font-weight-bold">Файлы этапа</div>
                        <div class="card-body">
                            <div class="list-group">
                                <#list stage.stageFiles as file>
                                    <a href="/files/${file.encodedFilename}" download="${file.filename}"
                                       class="list-group-item list-group-item-action">${file.filename}</a>
                                </#list>
                            </div>
                        </div>
                    </div>
                </#if>

            </div>
            <!--Grid column-->

            <div class="col-md-2 mb-4"></div>

        </div>
        <!--Grid row-->

    </section>
    <!--Section: Project-->
</@c.page>