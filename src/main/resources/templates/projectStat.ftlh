<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <!-- Heading -->
    <div class="card mb-4 wow pink lighten-3 fadeIn">

        <!--Card content-->
        <div class="card-body d-sm-flex justify-content-between">

            <h4 class="mb-2 mb-sm-0 pt-1">
                <a href="/projects/project/${project.projectId}" target="_blank">Проект
                    "${project.projectName?upperCase}"</a>
                <span>/</span>
                <span>Статистика проекта</span>
            </h4>

        </div>

    </div>
    <!-- Heading -->

    <div class="row wow fadeIn">

        <div class="col-md-12 mb-4">

            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Статистика по проекту <a
                                target="_blank" class="text-info"
                                href="/projects/project/${project.projectId}">"${project.projectName!''}"</a></h3>
                </div>
                <div class="card-body">

                    <div class="col-md-12">
                        <div class="row text-center">
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="card mb-3" style="max-width: 20rem;">
                                            <div class="card-body white-background">
                                                <h3>${project.projectStages?size!''}</h3>
                                            </div>
                                            <div class="card-header text-white secondary-color">Всего этапов</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card mb-3" style="max-width: 20rem;">
                                            <div class="card-body white-background">
                                                <h3>${project.projectTeams?size!''}</h3>
                                            </div>
                                            <div class="card-header text-white secondary-color">Всего команд</div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card mb-3" style="max-width: 20rem;">
                                            <div class="card-body white-background">
                                                <h3>${project.projectRating!''} <i class="far fa-gem"></i></h3>
                                            </div>
                                            <div class="card-header text-white secondary-color">Рейтинг проекта</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12 mb-4">

            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Статистика по этапам
                        проекта</h3>
                </div>
                <div class="card-body">


                    <div class="table-responsive-sm table-responsive-md table-responsive-lg table-responsive-xl">

                        <table id="sortedStatStagesTable" class="table table-bordered table-striped text-center">

                            <thead>

                            <tr>

                                <th class="text-center font-weight-bold">
                                    № п/п
                                </th>

                                <th class="text-center font-weight-bold">
                                    Этап
                                </th>

                                <th class="text-center font-weight-bold">
                                    Статус
                                </th>

                                <th class="text-center font-weight-bold">
                                    Рейтинг
                                </th>

                                <th class="text-center font-weight-bold">
                                    Сдача
                                </th>

                                <th class="text-center font-weight-bold">
                                    Старт
                                </th>

                                <th class="text-center font-weight-bold">
                                    Завершение
                                </th>

                                <th class="text-center font-weight-bold">
                                    Перейти
                                </th>

                            </tr>

                            </thead>

                            <tbody>

                            <#list project.projectStages as stage>
                                <tr>

                                    <td class="pt-3-half">
                                        ${stage_index+1!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${stage.stageName!''}
                                    </td>

                                    <td class="pt-3-half">
                                        <#if stage.stageStatus.name() == '_1_BACKLOG'>
                                            <h5><span class="badge badge-dark"><span style="display: none">1</span>В ожидании</span>
                                            </h5>
                                        <#elseIf stage.stageStatus.name() == '_2_TO_DO'>
                                            <h5><span class="badge badge-light"><span style="display: none">2</span>Надо сделать</span>
                                            </h5>
                                        <#elseIf stage.stageStatus.name() == '_3_IN_PROGRESS'>
                                            <h5><span class="badge badge-primary"><span style="display: none">3</span>В работе</span>
                                            </h5>
                                        <#elseIf stage.stageStatus.name() == '_4_DONE'>
                                            <h5><span class="badge badge-warning"><span style="display: none">4</span>Выполнен</span>
                                            </h5>
                                        <#elseIf stage.stageStatus.name() == '_5_ON_CHECK'>
                                            <h5><span class="badge badge-danger"><span style="display: none">5</span>На проверке</span>
                                            </h5>
                                        <#elseIf stage.stageStatus.name() == '_6_VERIFIED'>
                                            <h5><span class="badge badge-secondary"><span style="display: none">6</span>Проверен</span>
                                            </h5>
                                        <#elseIf stage.stageStatus.name() == '_7_COMPLETED'>
                                            <h5><span class="badge badge-success"><span style="display: none">7</span>Завершен</span>
                                            </h5>
                                        </#if>
                                    </td>

                                    <td class="pt-3-half">
                                        ${stage.stageRating!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${(stage.stageTheoreticalLeadTime.format("dd/MM/yyyy, HH:mm"))!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${(stage.stageStartTime.format("dd/MM/yyyy, HH:mm"))!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${(stage.stageEndTime.format("dd/MM/yyyy, HH:mm"))!''}
                                    </td>

                                    <td class="pt-3-half">
                                        <#if currentUser == project.projectLead>
                                            <a href="/projects/project/${project.projectId}/stage/${stage.stageId}"
                                               type="button"
                                               target="_blank"
                                               class="text-primary btn-sm my-0">
                                                <i class="fas fa-external-link-alt fa-2x"></i>
                                            </a>
                                        </#if>
                                    </td>

                                </tr>
                            </#list>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>
        </div>

        <div class="col-md-12 mb-4">

            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Статистика по командам
                        проекта</h3>
                </div>
                <div class="card-body">


                    <div class="table-responsive-sm table-responsive-md table-responsive-lg table-responsive-xl">

                        <table id="sortedStatTeamsTable" class="table table-bordered table-striped text-center">

                            <thead>

                            <tr>

                                <th class="text-center font-weight-bold">
                                    № п/п
                                </th>

                                <th class="text-center font-weight-bold">
                                    Команда
                                </th>

                                <th class="text-center font-weight-bold">
                                    Участники
                                </th>

                                <th class="text-center font-weight-bold">
                                    Капитан
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

                            <#list project.projectTeams as team>
                                <tr>

                                    <td class="pt-3-half">
                                        ${team_index+1!''}
                                    </td>

                                    <td class="pt-3-half">
                                        ${team.teamName!''}
                                    </td>

                                    <td class="pt-3-half">
                                        <#list team.teamUsers as tUser>
                                                <a target="_blank" class="text-info"
                                                   href="/user/profile/${tUser.userId}">${tUser.fullname!''}</a>
                                                <br>
                                        </#list>
                                    </td>

                                    <td class="pt-3-half">
                                        <a target="_blank" class="text-info"
                                           href="/user/profile/${team.teamCaptain.userId}">${team.teamCaptain.fullname!''}</a>
                                    </td>

                                    <td class="pt-3-half">
                                        ${team.teamRating!''}
                                    </td>

                                    <td class="pt-3-half">
                                        <#if currentUser == project.projectLead || team.teamUsers?seqContains(currentUser)>
                                            <a href="/projects/project/${project.projectId}/team/${team.teamId}"
                                               type="button"
                                               target="_blank"
                                               class="text-primary btn-sm my-0">
                                                <i class="fas fa-external-link-alt fa-2x"></i>
                                            </a>
                                        </#if>
                                    </td>

                                </tr>
                            </#list>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>
        </div>

        <div class="col-md-12 mb-4">

            <div class="card">
                <div>
                    <h3 class="card-header text-center font-weight-bold text-uppercase py-4">Статистика команд по
                        этапам проекта</h3>
                </div>
                <div class="card-body">


                    <div class="table-responsive-sm table-responsive-md table-responsive-lg table-responsive-xl">

                        <table id="sortedStatTeamsOnStagesTable" class="table table-bordered table-striped text-center">

                            <thead>

                            <tr>

                                <th class="text-center font-weight-bold">
                                    № п/п
                                </th>

                                <th class="text-center font-weight-bold">
                                    Этап
                                </th>

                                <th class="text-center font-weight-bold">
                                    Команда
                                </th>

                                <th class="text-center font-weight-bold">
                                    Статус
                                </th>

                                <th class="text-center font-weight-bold">
                                    Рейтинг
                                </th>

                                <th class="text-center font-weight-bold">
                                    Сдача
                                </th>

                                <th class="text-center font-weight-bold">
                                    Ответ
                                </th>

                                <th class="text-center font-weight-bold">
                                    Ассессмент
                                </th>

                                <th class="text-center font-weight-bold">
                                    Перейти
                                </th>

                            </tr>

                            </thead>

                            <tbody>

                            <#list project.projectStages as stage>
                                <#list stage.stageAnswers as answer>
                                    <tr>

                                        <td class="pt-3-half">
                                            ${answer_index+1+stage_index*2!''}
                                        </td>

                                        <td class="pt-3-half">
                                            ${answer.answerStage.stageName!''}
                                        </td>

                                        <td class="pt-3-half">
                                            ${answer.answerTeam.teamName!''}
                                        </td>

                                        <td class="pt-3-half">
                                            <#if answer.answerStatus.name() == '_1_BACKLOG'>
                                                <h5><span class="badge badge-dark"><span style="display: none">1</span>В ожидании</span>
                                                </h5>
                                            <#elseIf answer.answerStatus.name() == '_2_TO_DO'>
                                                <h5><span class="badge badge-light"><span style="display: none">2</span>Надо сделать</span>
                                                </h5>
                                            <#elseIf answer.answerStatus.name() == '_3_IN_PROGRESS'>
                                                <h5><span class="badge badge-primary"><span
                                                                style="display: none">3</span>В работе</span></h5>
                                            <#elseIf answer.answerStatus.name() == '_4_DONE'>
                                                <h5><span class="badge badge-warning"><span
                                                                style="display: none">4</span>Выполнен</span></h5>
                                            <#elseIf answer.answerStatus.name() == '_5_ON_CHECK'>
                                                <h5><span class="badge badge-danger"><span
                                                                style="display: none">5</span>На проверке</span></h5>
                                            <#elseIf answer.answerStatus.name() == '_6_VERIFIED'>
                                                <h5><span class="badge badge-secondary"><span
                                                                style="display: none">6</span>Проверен</span></h5>
                                            <#elseIf answer.answerStatus.name() == '_7_COMPLETED'>
                                                <h5><span class="badge badge-success"><span
                                                                style="display: none">7</span>Завершен</span></h5>
                                            </#if>
                                        </td>

                                        <td class="pt-3-half">
                                            ${answer.answerRating!''}
                                        </td>

                                        <td class="pt-3-half">
                                            ${(stage.stageTheoreticalLeadTime.format("dd/MM/yyyy, HH:mm"))!''}
                                        </td>

                                        <td class="pt-3-half">
                                            ${(answer.answerResponseTime.format("dd/MM/yyyy, HH:mm"))!''}
                                        </td>

                                        <td class="pt-3-half">
                                            ${(answer.answerAssessmentTime.format("dd/MM/yyyy, HH:mm"))!''}
                                        </td>

                                        <td class="pt-3-half">
                                            <#if currentUser == project.projectLead || answer.answerTeam.teamUsers?seqContains(currentUser)>
                                                <a href="/projects/project/${project.projectId}/stage/${answer.answerStage.stageId}/team/${answer.answerTeam.teamId}"
                                                   type="button"
                                                   target="_blank"
                                                   class="text-primary btn-sm my-0">
                                                    <i class="fas fa-external-link-alt fa-2x"></i>
                                                </a>
                                            </#if>
                                        </td>

                                    </tr>
                                </#list>
                            </#list>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>
        </div>

    </div>

</@c.page>