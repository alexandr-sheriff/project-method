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
                <span>Этап "${stage.stageName?upperCase}"</span>
            </h4>

        </div>

    </div>
    <!-- Heading -->

    <!--Section: Project-->
    <section class="mt-4">

        <!--Grid row-->
        <div class="row">

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

                        <#if answer.answerStatus.name() == '_1_BACKLOG'>
                            <h5><span class="badge badge-dark">В ожидании</span></h5>
                        <#elseIf answer.answerStatus.name() == '_2_TO_DO'>
                            <h5><span class="badge badge-light">Надо сделать</span></h5>
                        <#elseIf answer.answerStatus.name() == '_3_IN_PROGRESS'>
                            <h5><span class="badge badge-primary">В работе</span></h5>
                        <#elseIf answer.answerStatus.name() == '_4_DONE'>
                            <h5><span class="badge badge-warning">Выполнен</span></h5>
                        <#elseIf answer.answerStatus.name() == '_5_ON_CHECK'>
                            <h5><span class="badge badge-danger">На проверке</span></h5>
                        <#elseIf answer.answerStatus.name() == '_6_VERIFIED'>
                            <h5><span class="badge badge-secondary">Проверен</span></h5>
                        <#elseIf answer.answerStatus.name() == '_7_COMPLETED'>
                            <h5><span class="badge badge-success">Завершен</span></h5>
                        </#if>

                        <#if (currentUser == project.projectLead && project.projectStarted) ||
                        ((currentUser == project.projectLead && project.projectStarted && !project.projectFinished) || (currentUser == team.teamCaptain && (answer.answerStatus.name() == '_2_TO_DO' || answer.answerStatus.name() == '_3_IN_PROGRESS'))) ||
                        (previousStage?hasContent || nextStage?hasContent)>

                            <hr>

                        </#if>

                        <div class="d-block btn-group" role="group">

                            <#if currentUser == project.projectLead && project.projectStarted>
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

                            <#if (currentUser == project.projectLead && project.projectStarted && !project.projectFinished) || (currentUser == team.teamCaptain && (answer.answerStatus.name() == '_2_TO_DO' || answer.answerStatus.name() == '_3_IN_PROGRESS'))>
                                <div class="btn-group" role="group">
                                    <button id="btnGroupDrop1" type="button"
                                            class="btn btn-pink btn-md dropdown-toggle"
                                            data-toggle="dropdown"
                                            aria-haspopup="true" aria-expanded="false">Сменить статус
                                    </button>
                                    <#if currentUser == project.projectLead>
                                        <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                            <#if answer.answerStatus.name() == '_2_TO_DO'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/status/update?status=_1_BACKLOG">В
                                                    ожидании</a>
                                            </#if>
                                            <#if answer.answerStatus.name() == '_1_BACKLOG' || answer.answerStatus.name() == '_3_IN_PROGRESS'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/status/update?status=_2_TO_DO">Надо
                                                    сделать</a>
                                            </#if>
                                            <#if answer.answerStatus.name() == '_2_TO_DO' || answer.answerStatus.name() == '_4_DONE'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/status/update?status=_3_IN_PROGRESS">В
                                                    работе</a>
                                            </#if>
                                            <#if answer.answerStatus.name() == '_3_IN_PROGRESS' || answer.answerStatus.name() == '_5_ON_CHECK'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/status/update?status=_4_DONE">Выполнен</a>
                                            </#if>
                                            <#if answer.answerStatus.name() == '_4_DONE' || answer.answerStatus.name() == '_6_VERIFIED'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/status/update?status=_5_ON_CHECK">На
                                                    проверке</a>
                                            </#if>
                                            <#if answer.answerStatus.name() == '_5_ON_CHECK' || answer.answerStatus.name() == '_7_COMPLETED'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/status/update?status=_6_VERIFIED">Проверен</a>
                                            </#if>
                                            <#if answer.answerStatus.name() == '_6_VERIFIED'>
                                                <a class="dropdown-item"
                                                   href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/status/update?status=_7_COMPLETED">Завершен</a>
                                            </#if>
                                        </div>
                                    <#elseIf currentUser == team.teamCaptain>
                                        <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
                                            <#if answer.answerStatus.name() == '_2_TO_DO' || answer.answerStatus.name() == '_4_DONE'>
                                                <a class="dropdown-item <#if answer.answerStatus.name() != '_2_TO_DO'>disabled</#if>"
                                                   href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/status/update?status=_3_IN_PROGRESS">В
                                                    работе</a>
                                            </#if>
                                            <#if answer.answerStatus.name() == '_3_IN_PROGRESS'>
                                                <a class="dropdown-item <#if answer.answerStatus.name() != '_3_IN_PROGRESS' || !answer.answerResponseTime?hasContent>disabled</#if>"
                                                   href="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/status/update?status=_4_DONE">Выполнен</a>
                                            </#if>
                                        </div>
                                    </#if>
                                </div>
                            </#if>
                        </div>

                        <#if previousStage?hasContent || nextStage?hasContent>
                            <div class="btn-group" role="group">
                                <#if previousStage?hasContent && previousStage.stageStatus.name() != '_1_BACKLOG'>
                                    <button type="button"
                                            onClick='location.href="/projects/project/${project.projectId}/stage/${previousStage.stageId}/team/${team.teamId}"'
                                            class="btn btn-info">Предыдущий этап
                                    </button>
                                </#if>
                                <#if nextStage?hasContent && nextStage.stageStatus.name() != '_1_BACKLOG'>
                                    <button type="button"
                                            onClick='location.href="/projects/project/${project.projectId}/stage/${nextStage.stageId}/team/${team.teamId}"'
                                            class="btn btn-info">Следующий этап
                                    </button>
                                </#if>
                            </div>
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
                <!--Grid column-->

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

                <#if  currentUser == team.teamCaptain && answer.answerStatus == '_3_IN_PROGRESS' && stage.stageTheoreticalLeadTime.isAfter(stage.stageTheoreticalLeadTime.now())>
                    <!--Captain Answer-->
                    <div class="card mb-3 wow fadeIn">
                        <div class="card-header font-weight-bold">Отправить ответ</div>
                        <div class="card-body">

                            <form action="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/create?${_csrf.parameterName}=${_csrf.token}"
                                  method="post" enctype="multipart/form-data">

                                <!-- CSRF Token -->
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                                <!-- Captain Answer -->
                                <div class="form-group">
                                    <label for="answerText">Ваш ответ</label>
                                    <textarea id="answerText" name="answerText"
                                              class="md-textarea form-control ${(answerTextError??)?string('is-invalid', '')}"
                                              rows="5">${answer.answerText!''}</textarea>
                                    <#if answerTextError??>
                                        <div class="invalid-feedback">
                                            ${answerTextError}
                                        </div>
                                    </#if>
                                </div>

                                <div class="form-group">
                                    <label for="files">Файлы ответа</label>
                                    <#if answer.answerFiles?hasContent>
                                        <div class="list-group mb-2">
                                            <#list answer.answerFiles as file>
                                                <a href="/files/${file.encodedFilename}" download="${file.filename}"
                                                   class="list-group-item list-group-item-action">${file.filename}</a>
                                            </#list>
                                        </div>
                                    </#if>
                                    <div class="custom-file">
                                        <input type="file" multiple="multiple" id="file" name="files"
                                               class="custom-file-input"
                                               aria-describedby="file">
                                        <label class="custom-file-label" for="files" data-browse="Выбрать">Выберите
                                            файл</label>
                                    </div>
                                </div>

                                <div class="text-center mt-4">
                                    <button class="btn btn-unique btn-md" type="submit">Отправить</button>
                                </div>

                            </form>

                        </div>
                    </div>
                <#elseIf currentUser == project.projectLead && answer.answerStatus == '_3_IN_PROGRESS' && stage.stageTheoreticalLeadTime.isBefore(stage.stageTheoreticalLeadTime.now())>
                    <div class="card mb-3 wow fadeIn">
                        <div class="card-header font-weight-bold">Отправить ответ</div>
                        <div class="card-body">

                            <form action="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/create?${_csrf.parameterName}=${_csrf.token}"
                                  method="post" enctype="multipart/form-data">

                                <!-- CSRF Token -->
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                                <!-- Captain Answer -->
                                <div class="form-group">
                                    <label for="answerText">Ваш ответ</label>
                                    <textarea id="answerText" name="answerText"
                                              class="md-textarea form-control ${(answerTextError??)?string('is-invalid', '')}"
                                              rows="5">${answer.answerText!''}</textarea>
                                    <#if answerTextError??>
                                        <div class="invalid-feedback">
                                            ${answerTextError}
                                        </div>
                                    </#if>
                                </div>

                                <div class="form-group">
                                    <label for="files">Файлы ответа</label>
                                    <#if answer.answerFiles?hasContent>
                                        <div class="list-group mb-2">
                                            <#list answer.answerFiles as file>
                                                <a href="/files/${file.encodedFilename}" download="${file.filename}"
                                                   class="list-group-item list-group-item-action">${file.filename}</a>
                                            </#list>
                                        </div>
                                    </#if>
                                    <div class="custom-file">
                                        <input type="file" multiple="multiple" id="file" name="files"
                                               class="custom-file-input"
                                               aria-describedby="file">
                                        <label class="custom-file-label" for="files" data-browse="Выбрать">Выберите
                                            файл</label>
                                    </div>
                                </div>

                                <div class="text-center mt-4">
                                    <button class="btn btn-unique btn-md" type="submit">Отправить</button>
                                </div>

                            </form>

                        </div>
                    </div>
                </#if>
                <#if answer.answerResponseTime?hasContent>
                    <!--See Answer-->
                    <div class="card mb-3 wow fadeIn">
                        <div class="card-header font-weight-bold">Посмотреть ответ</div>
                        <div class="card-body">

                            <!-- Team Answer -->
                            <div class="form-group">
                                <label for="answerText">Ответ команды</label>
                                <textarea id="answerText" name="answerText"
                                          class="md-textarea form-control"
                                          rows="5"
                                          readonly>${answer.answerText!''}</textarea>
                            </div>

                            <#if answer.answerFiles?hasContent>
                                <div class="list-group">
                                    <label for="answerText">Файлы ответа</label>
                                    <#list answer.answerFiles as file>
                                        <a href="/files/${file.encodedFilename}" download="${file.filename}"
                                           class="list-group-item list-group-item-action">${file.filename}</a>
                                    </#list>
                                </div>
                            </#if>

                        </div>
                        <div class="rounded-bottom mdb-color lighten-3 text-center pt-3">
                            <ul class="list-unstyled list-inline font-small white-text">
                                Ответ отправлен ${(answer.answerResponseTime.format("dd/MM/yyyy, HH:mm"))!''}
                            </ul>
                        </div>
                    </div>
                </#if>
                <!--/.See Answer-->
                <#if currentUser == project.projectLead && answer.answerResponseTime?hasContent && answer.answerStatus == '_5_ON_CHECK'>
                    <!--Teacher Answer Assessment-->
                    <div class="card mb-3 wow fadeIn">
                        <div class="card-header font-weight-bold">Оценить ответ</div>
                        <div class="card-body">

                            <form action="/projects/project/${project.projectId}/stage/${stage.stageId}/team/${team.teamId}/answer/${answer.answerId}/assessment/create"
                                  method="post">

                                <!-- CSRF Token -->
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                                <div class="form-group">
                                    <label for="answerText">Ваш комментарий</label>
                                    <textarea id="answerAssessment" name="answerAssessment"
                                              class="md-textarea form-control ${(answerAssessmentError??)?string('is-invalid', '')}"
                                              rows="5">${answer.answerAssessment!''}</textarea>
                                    <#if answerAssessmentError??>
                                        <div class="invalid-feedback">
                                            ${answerAssessmentError}
                                        </div>
                                    </#if>
                                </div>

                                <div class="md-form">
                                    <input type="number" id="answerRating" name="answerRating"
                                           value="${answer.answerRating!''}"
                                           class="form-control ${(answerRatingError??)?string('is-invalid', '')}">
                                    <label for="answerRating">Ваша оценка</label>
                                    <#if answerRatingError??>
                                        <div class="invalid-feedback">
                                            ${answerRatingError}
                                        </div>
                                    </#if>
                                </div>

                                <div class="text-center mt-4">
                                    <button class="btn btn-unique btn-md" type="submit">Оценить</button>
                                </div>

                            </form>

                        </div>
                    </div>
                </#if>
                <!--/.Teacher Answer Assessment-->
                <#if answer.answerAssessmentTime?hasContent>
                    <!--See Answer Assessment-->
                    <div class="card mb-3 wow fadeIn">
                        <div class="card-header font-weight-bold">Посмотреть оценку</div>
                        <div class="card-body">

                            <div class="form-group">
                                <label for="answerText">Комментарий ответа</label>
                                <textarea id="answerText" name="answerText"
                                          class="md-textarea form-control"
                                          rows="5"
                                          readonly>${answer.answerAssessment!''}</textarea>
                            </div>

                            <div class="md-form">
                                <input type="number" id="answerRating" name="answerRating"
                                       value="${answer.answerRating!''}"
                                       class="form-control"
                                       readonly>
                                <label for="answerRating">Оценка ответа</label>
                            </div>

                        </div>
                        <div class="rounded-bottom mdb-color lighten-3 text-center pt-3">
                            <ul class="list-unstyled list-inline font-small white-text">
                                Оценка отправлена ${(answer.answerAssessmentTime.format("dd/MM/yyyy, HH:mm"))!''}
                            </ul>
                        </div>
                    </div>
                    <!--/.See Answer Assessment-->
                </#if>

            </div>
            <!--Grid column-->

            <!--Grid column-->
            <div class="col-md-4 mb-4">

                <h5 class="section-heading mb-4">
                    Участники команды
                </h5>

                <hr>

                <!--Card-->
                <div class="card mb-4 wow fadeIn">

                    <div class="card-header d-flex justify-content-between align-items-center">
                        ${team.teamName}
                        <a href="/projects/project/${project.projectId}/team/${team.teamId}/chat"
                           type="button" class="btn btn-outline-primary btn-sm waves-effect"><i
                                    class="fas fa-comment-alt pr-2" aria-hidden="true"></i>Чат</a>
                    </div>

                    <!--Card content-->
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <#list team.teamUsers as teamUser>

                                <li class="list-group-item d-flex justify-content-start align-items-center">
                                    <#if !team.teamCaptain?hasContent && currentUser == project.projectLead>
                                        <a href="/projects/project/${project.projectId}/team/${team.teamId}/assign/captain/${teamUser.userId}"><span
                                                    style="color: #9933cc"
                                                    class="far fa-check-circle"></span></a>
                                    <#elseIf team.teamCaptain?hasContent>
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
                                        <#if currentUser == project.projectLead || currentUser == team.teamCaptain>
                                            <#if teamUser == team.teamCaptain>
                                                <span style="color: #9933cc" class="fas fa-check-circle ml-auto"></span>
                                            <#else>
                                                <span style="color: #9933cc" class="far fa-check-circle ml-auto">
                                                    <a href="/projects/project/${project.projectId}/team/${team.teamId}/assignА/captain/${teamUser.userId}"></a>
                                                </span>
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

            </div>
            <!--Grid column-->

        </div>
        <!--Grid row-->

    </section>
    <!--Section: Project-->
</@c.page>