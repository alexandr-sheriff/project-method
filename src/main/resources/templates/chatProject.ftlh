<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>

    <!-- Heading -->
    <div class="col-md-12 mx-auto card mb-4 wow pink lighten-3 fadeIn ">

        <!--Card content-->
        <div class="card-body d-sm-flex justify-content-between">

            <h4 class="mb-2 mb-sm-0 pt-1">
                <span><a
                            href="/projects/project/${project.projectId}">Проект "${project.projectName?upperCase}"</a></span>
                <span>/</span>
                <span>Чат проекта</span>
            </h4>

        </div>

    </div>
    <!-- Heading -->

    <!--Section: Project-->
    <section class="mt-4">

        <!--Grid row-->
        <div class="row">

            <!--Grid column-->
            <div class="col-md-12 mb-4">

                <div class="card">
                    <div class="text-center">
                        <div class="card-header"><p class="h5"><b>Чат проекта</b></p></div>
                    </div>
                    <div class="row row-divided">
                        <div class="col-md-4">
                            <ul class="list-group">
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
                                    <span style="color: #9933cc" class="fas fa-crown ml-auto"></span>
                                </li>
                                <#list projectUsers as projectUser>
                                    <li class="list-group-item d-flex justify-content-start align-items-center">
                                        <#if projectUser.userImage?hasContent>
                                            <a href="/user/profile/${projectUser.userId}"><img
                                                        alt="${projectUser.fullname}"
                                                        src="/files/${projectUser.userImage}"
                                                        class="ava-min rounded-circle"></a>
                                        <#else>
                                            <a href="/user/profile/${projectUser.userId}"><img
                                                        alt="${projectUser.fullname}"
                                                        class="ava-min rounded-circle"
                                                        src="/files/c81ff85f11db9ff8a23d6dc29c8b8b7e.png"></a>
                                        </#if>
                                        <span>&ensp;</span>
                                        <a href="/user/profile/${projectUser.userId}">${projectUser.fullname}</a>
                                        <#list project.projectTeams as team>
                                            <#if team.teamUsers?seqContains(projectUser) && !team.teamCaptain?hasContent && currentUser == project.projectLead && !project.projectFinished>
                                                <a class="ml-auto"
                                                   href="/projects/project/${project.projectId}/team/${team.teamId}/assign/captain/${projectUser.userId}">
                                                    <i style="color: #9933cc" class="far fa-check-circle"></i>
                                                </a>
                                            <#elseIf team.teamCaptain?hasContent>
                                                <#if team.teamUsers?seqContains(projectUser) && (currentUser == project.projectLead || currentUser == team.teamCaptain)  && !project.projectFinished>
                                                    <#if projectUser == team.teamCaptain>
                                                        <span style="color: #9933cc"
                                                              class="fas fa-check-circle ml-auto"></span>
                                                    <#else>
                                                        <a class="ml-auto"
                                                           href="/projects/project/${project.projectId}/team/${team.teamId}/assign/captain/${projectUser.userId}">
                                                            <i style="color: #9933cc" class="far fa-check-circle"></i>
                                                        </a>
                                                    </#if>
                                                <#else>
                                                    <#if projectUser == team.teamCaptain>
                                                        <span style="color: #9933cc"
                                                              class="fas fa-check-circle ml-auto"></span>
                                                    </#if>
                                                </#if>
                                            </#if>
                                        </#list>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                        <div class="col-md-8">
                            <div class="card-body scroll">
                                <ul class="chat-list">
                                    <#list projectMessages as message>
                                        <#if currentUser == message.chatMessageSender>
                                            <li class="in">
                                                <div class="chat-img">
                                                    <#if message.chatMessageSender.userImage?hasContent>
                                                        <img alt="Avtar"
                                                             src="/files/${message.chatMessageSender.userImage}">
                                                    <#else>
                                                        <img alt="Avtar"
                                                             src="/files/c81ff85f11db9ff8a23d6dc29c8b8b7e.png">
                                                    </#if>
                                                </div>
                                                <div class="chat-body">
                                                    <div class="chat-message">
                                                        <h5 class="text-dark">${message.chatMessageSender.fullname}</h5>
                                                        <hr class="mb-2 mt-1">
                                                        <p>${message.chatMessageText}</p>
                                                        <#if message.chatMessageFiles?hasContent>
                                                            <hr class="mb-2 mt-1">
                                                            <div class="list-group mb-2">
                                                                <#list message.chatMessageFiles as file>
                                                                    <a href="/files/${file.encodedFilename}"
                                                                       download="${file.filename}"
                                                                       class="list-group-item list-group-item-action">${file.filename}</a>
                                                                </#list>
                                                            </div>
                                                        </#if>
                                                    </div>
                                                </div>
                                            </li>
                                        <#else>
                                            <li class="out">
                                                <div class="chat-img">
                                                    <#if message.chatMessageSender.userImage?hasContent>
                                                        <img alt="Avtar"
                                                             src="/files/${message.chatMessageSender.userImage}">
                                                    <#else>
                                                        <img alt="Avtar"
                                                             src="/files/c81ff85f11db9ff8a23d6dc29c8b8b7e.png">
                                                    </#if>
                                                </div>
                                                <div class="chat-body">
                                                    <div class="chat-message">
                                                        <h5 class="text-dark">${message.chatMessageSender.fullname}</h5>
                                                        <hr class="mb-2 mt-1">
                                                        <p>${message.chatMessageText}</p>
                                                        <#if message.chatMessageFiles?hasContent>
                                                            <hr class="mb-2 mt-1">
                                                            <div class="list-group mb-2">
                                                                <#list message.chatMessageFiles as file>
                                                                    <a href="/files/${file.encodedFilename}"
                                                                       download="${file.filename}"
                                                                       class="list-group-item list-group-item-action">${file.filename}</a>
                                                                </#list>
                                                            </div>
                                                        </#if>
                                                    </div>
                                                </div>
                                            </li>
                                        </#if>
                                    </#list>
                                </ul>
                            </div>
                            <form action="/projects/project/${project.projectId}/chat?${_csrf.parameterName}=${_csrf.token}"
                                  method="post" enctype="multipart/form-data">

                                <!-- CSRF Token -->
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                                <input id="chatMessageText" name="chatMessageText" type="text"
                                       class="form-control mx-auto mb-2 ${(chatMessageTextError??)?string('is-invalid', '')}"
                                       required style="width: 97%"
                                       placeholder="Напишите сообщение..." autocomplete="off">
                                <#if chatMessageTextError??>
                                    <div class="invalid-feedback">
                                        ${chatMessageTextError}
                                    </div>
                                </#if>
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input mx-auto" id="files" name="files"
                                           multiple="multiple"
                                           style="width: 97%">
                                    <label class="custom-file-label mx-auto" for="file" data-browse="Выбрать"
                                           style="width: 97%">Выберите файл</label>
                                </div>
                                <div class="text-center">
                                    <button type="submit"
                                            class="btn btn-info btn-md waves-effect waves-light mt-3 mb-3">Отправить
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
            <!--Grid column-->

        </div>
        <!--Grid row-->

    </section>
    <!--Section: Project-->
</@c.page>