<#import "parts/common.ftlh" as c>

<@c.page>

    <div class="container-fluid full-page-container">
        <div class="row h-100 justify-content-center align-items-center mb-5">
            <div class="col-lg-6 col-sm-8 animated fadeIn mb-5">
                <div class="card mb-5">

                    <h5 class="card-header pink lighten-3 white-text text-center py-4">
                        <strong>Добавление участников</strong>
                    </h5>

                    <div class="card-body px-lg-5 pt-0">

                        <form action="/projects/project/${project.projectId}/team/create" method="post"
                              style="color: #757575;">

                            <!-- CSRF Token -->
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                            <div class="md-form">
                                <label for="teamName">Название команды</label>
                                <input type="text" id="teamName" name="teamName" value="${team.teamName!''}"
                                       class="form-control ${(teamNameError??)?string('is-invalid', '')}" required>
                                <#if teamNameError??>
                                    <div class="invalid-feedback">
                                        ${teamNameError}
                                    </div>
                                </#if>
                            </div>

                            <div class="form-group">
                                <label for="teamUsers">Выберите участников</label>
                                <select multiple="multiple" name="teamUsers" id="teamUsers"
                                        class="form-control ${(teamUsersError??)?string('is-invalid', '')} required">
                                    <#list users as user>
                                        <option value="${user.userId}">${user.fullname}</option>
                                    </#list>
                                </select>
                                <#if teamUsersError??>
                                    <div class="invalid-feedback">
                                        ${teamUsersError}
                                    </div>
                                </#if>
                            </div>

                            <#--<div class="form-group">
                                <div id="select-form-control">
                                    <label for="teamUsers">Выберите участников</label>
                                    <select id="teamUsers" name="teamUsers"
                                            class="selectpicker form-control ${(teamUsersError??)?string('is-invalid', '')}"
                                            data-actions-box="true"
                                            data-dropup-auto="false"
                                            data-live-search="true"
                                            data-selected-text-format="count"
                                            data-size="10"
                                            data-style="btn-secondary text-white"
                                            data-width="97%"
                                            multiple
                                            required
                                    >
                                        <#list users as user>
                                            <option value="${user.userId}">${user.fullname}</option>
                                        </#list>
                                    </select>
                                </div>
                                <#if teamUsersError??>
                                    <div class="invalid-feedback">
                                        ${teamUsersError}
                                    </div>
                                </#if>
                            </div>-->


                                <div class="modal-footer d-flex justify-content-center">

                                    <button type="button"
                                            onClick='location.href="/projects/project/${project.projectId}"'
                                            class="btn btn-outline-pink waves-effect">
                                        Отмена
                                    </button>

                                    <button type="submit" class="btn btn-unique waves-effect">
                                        Сохранить
                                    </button>

                                </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</@c.page>
