<#import "parts/common.ftlh" as c>

<@c.page>

    <div class="container-fluid full-page-container">
        <div class="row h-100 justify-content-center align-items-center">
            <div class="col-lg-6 col-sm-8 animated fadeIn">

                <div class="card">

                    <h5 class="card-header pink lighten-3 white-text text-center py-4">
                        <strong>Добавление этапа</strong>
                    </h5>

                    <div class="card-body px-lg-5 pt-0">

                        <form action="/projects/project/${project.projectId}/stage/create?${_csrf.parameterName}=${_csrf.token}"
                              method="post" enctype="multipart/form-data"
                              style="color: #757575;">

                            <!-- CSRF Token -->
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                            <div class="md-form">
                                <input type="text" id="stageName" name="stageName" value="${stage.stageName!''}"
                                       class="form-control ${(stageNameError??)?string('is-invalid', '')}" required>
                                <label for="stageName">Название этапа</label>
                                <#if stageNameError??>
                                    <div class="invalid-feedback">
                                        ${stageNameError}
                                    </div>
                                </#if>
                            </div>

                            <div class="md-form">
                                <textarea id="stageDescription" name="stageDescription"
                                          class="md-textarea form-control ${(stageDescriptionError??)?string('is-invalid', '')}"
                                          rows="3"
                                          required>${stage.stageDescription!''}</textarea>
                                <label for="stageDescription">Описание этапа</label>
                                <#if stageDescriptionError??>
                                    <div class="invalid-feedback">
                                        ${stageDescriptionError}
                                    </div>
                                </#if>
                            </div>

                            <div class="form-group">
                                <label for="stageTheoreticalLeadTime">Срок сдачи этапа</label>
                                <input type="datetime-local" id="stageTheoreticalLeadTime"
                                       name="stageTheoreticalLeadTime"
                                       value="${stage.stageTheoreticalLeadTime!''}"
                                       class="form-control ${(stageTheoreticalLeadTimeError??)?string('is-invalid', '')}"
                                       required>
                                <#if stageTheoreticalLeadTimeError??>
                                    <div class="invalid-feedback">
                                        ${stageTheoreticalLeadTimeError}
                                    </div>
                                </#if>
                            </div>

                            <div class="form-group">
                                <label for="file">Логотип этапа</label>
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="file" name="file"
                                           aria-describedby="file">
                                    <label class="custom-file-label" for="file" data-browse="Выбрать">Выберите
                                        файл</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="files">Файлы этапа</label>
                                <div class="custom-file">
                                    <input type="file" multiple="multiple" id="file" name="files"
                                           class="custom-file-input"
                                           aria-describedby="file">
                                    <label class="custom-file-label" for="files" data-browse="Выбрать">Выберите
                                        файл</label>
                                </div>
                            </div>

                            <div class="modal-footer d-flex justify-content-center">

                                <button type="button" onClick='location.href="/projects/project/${project.projectId}"'
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
