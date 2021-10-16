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
                <span>Команда "${team.teamName?upperCase}"</span>
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

                <!--Card-->
                <div class="card mb-4 wow fadeIn">

                    <!--Card content-->
                    <div class="card-body text-center">

                        <p class="h5 my-4"><b>Участники команды "${team.teamName!''}"</b></p>

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
                                                    <i style="color: #9933cc" class="far fa-check-circle"></i>
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

                        <#if currentUser == project.projectLead>
                            <hr>

                            <#if !project.projectStarted && users?hasContent>
                                <div class="d-block btn-group" role="group">
                                    <button type="button"
                                            onClick='location.href="/projects/project/${project.projectId}/team/create"'
                                            class="btn btn-secondary btn-md mr-0">Добавить участников
                                    </button>
                                </div>
                            </#if>

                            <div class="d-block btn-group" role="group">
                                <a href="/projects/project/${project.projectId}/team/${team.teamId}/chat" type="button" class="btn btn-outline-primary waves-effect">
                                    <i class="fas fa-comment-alt pr-2" aria-hidden="true"></i>Чат</a>
                            </div>
                        <#--<div class="btn-group" role="group">
                            <button type="button"
                                    onClick='location.href="/projects/project/${project.projectId}"'
                                    class="btn btn-unique">Проект
                            </button>-->

                            <div class="btn-group" role="group">
                                <#if previousTeam?hasContent>
                                    <button type="button"
                                            onClick='location.href="/projects/project/${project.projectId}/team/${previousTeam}"'
                                            class="btn btn-info">Предыдущие участники
                                    </button>
                                </#if>
                                <#if nextTeam?hasContent>
                                    <button type="button"
                                            onClick='location.href="/projects/project/${project.projectId}/team/${nextTeam}"'
                                            class="btn btn-info">Следующие участники
                                    </button>
                                </#if>
                            </div>
                        <#--</div>-->
                        </#if>

                    </div>
                </div>
                <!--/.Card-->

            </div>
            <!--Grid column-->

            <div class="col-md-2 mb-4"></div>

        </div>
        <!--Grid row-->

    </section>
    <!--Section: Project-->
</@c.page>