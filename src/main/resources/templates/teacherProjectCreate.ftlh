<#import "parts/common.ftlh" as c>

<@c.page>

    <div class="container-fluid full-page-container">
        <div class="row h-100 justify-content-center align-items-center">
            <div class="col-lg-6 col-sm-8 animated fadeIn">

                <div class="card">

                    <h5 class="card-header pink lighten-3 white-text text-center py-4">
                        <strong>Добавление проекта</strong>
                    </h5>

                    <div class="card-body px-lg-5 pt-0">

                        <form action="/projects/project/create?${_csrf.parameterName}=${_csrf.token}"
                              method="post" enctype="multipart/form-data"
                              style="color: #757575;">

                            <!-- CSRF Token -->
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                            <div class="md-form">
                                <input type="text" id="projectName" name="projectName" value="${project.projectName!''}"
                                       class="form-control ${(projectNameError??)?string('is-invalid', '')}" required>
                                <label for="projectName">Название проекта</label>
                                <#if projectNameError??>
                                    <div class="invalid-feedback">
                                        ${projectNameError}
                                    </div>
                                </#if>
                            </div>

                            <div class="md-form">
                                <textarea id="projectGoals" name="projectGoals"
                                          class="md-textarea form-control ${(projectGoalsError??)?string('is-invalid', '')}"
                                          rows="3"
                                          required>${project.projectGoals!''}</textarea>
                                <label for="projectGoals">Цели проекта</label>
                                <#if projectGoalsError??>
                                    <div class="invalid-feedback">
                                        ${projectGoalsError}
                                    </div>
                                </#if>
                            </div>

                            <div class="md-form">
                                <textarea id="projectTasks" name="projectTasks"
                                          class="md-textarea form-control ${(projectTasksError??)?string('is-invalid', '')}"
                                          rows="3"
                                          required>${project.projectTasks!''}</textarea>
                                <label for="projectTasks">Задачи проекта</label>
                                <#if projectTasksError??>
                                    <div class="invalid-feedback">
                                        ${projectTasksError}
                                    </div>
                                </#if>
                            </div>

                            <div class="md-form">
                                <textarea id="projectDescription" name="projectDescription"
                                          class="md-textarea form-control ${(projectDescriptionError??)?string('is-invalid', '')}"
                                          rows="3"
                                          required>${project.projectDescription!''}</textarea>
                                <label for="projectDescription">Описание проекта</label>
                                <#if projectDescriptionError??>
                                    <div class="invalid-feedback">
                                        ${projectDescriptionError}
                                    </div>
                                </#if>
                            </div>

                            <div class="form-group">
                                <label for="projectTheoreticalLeadTime">Срок сдачи проекта</label>
                                <input type="datetime-local" id="projectTheoreticalLeadTime"
                                       name="projectTheoreticalLeadTime"
                                       value="${project.projectTheoreticalLeadTime!''}"
                                       class="form-control ${(projectTheoreticalLeadTimeError??)?string('is-invalid', '')}"
                                       required>
                                <#if projectTheoreticalLeadTimeError??>
                                    <div class="invalid-feedback">
                                        ${projectTheoreticalLeadTimeError}
                                    </div>
                                </#if>
                            </div>

                            <div class="form-group">
                                <label for="file">Логотип проекта</label>
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="file" name="file"
                                           aria-describedby="file">
                                    <label class="custom-file-label" for="file" data-browse="Выбрать">Выберите
                                        файл</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="files">Файлы проекта</label>
                                <div class="custom-file">
                                    <input type="file" multiple="multiple" id="files" name="files"
                                           class="custom-file-input"
                                           aria-describedby="file">
                                    <label class="custom-file-label" for="files" data-browse="Выбрать">Выберите
                                        файл</label>
                                </div>
                            </div>

                            <div class="modal-footer d-flex justify-content-center">

                                <button type="button" onClick='location.href="/projects"'
                                        class="btn btn-outline-pink waves-effect">Отмена
                                </button>

                                <button type="submit" class="btn btn-unique waves-effect">Сохранить</button>

                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</@c.page>
