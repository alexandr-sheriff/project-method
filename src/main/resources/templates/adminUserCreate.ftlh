<#import "parts/adminCommon.ftlh" as aC>

<@aC.adminPage '/admin/users'>

    <div class="container-fluid full-page-container">
        <div class="row h-100 justify-content-center align-items-center">
            <div class="col-lg-6 col-sm-8 animated fadeIn">

                <div class="card">

                    <h5 class="card-header pink lighten-3 white-text text-center py-4">
                        <strong>Добавление пользователя</strong>
                    </h5>

                    <div class="card-body px-lg-5 pt-0">

                        <form action="/admin/user/create" method="post" style="color: #757575;">

                            <!-- CSRF Token -->
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                            <div class="md-form">
                                <input type="text" id="firstname" name="firstname" value="${user.firstname!''}"
                                       class="form-control ${(firstnameError??)?string('is-invalid', '')}" required>
                                <label for="firstname">Имя</label>
                                <#if firstnameError??>
                                    <div class="invalid-feedback">
                                        ${firstnameError}
                                    </div>
                                </#if>
                            </div>

                            <div class="md-form">
                                <input type="text" id="lastname" name="lastname" value="${user.lastname!''}"
                                       class="form-control ${(lastnameError??)?string('is-invalid', '')}" required>
                                <label for="lastname">Фамилия</label>
                                <#if lastnameError??>
                                    <div class="invalid-feedback">
                                        ${lastnameError}
                                    </div>
                                </#if>
                            </div>

                            <div class="md-form">
                                <input type="text" id="username" name="username" value="${user.username!''}"
                                       class="form-control ${(usernameError??)?string('is-invalid', '')}" required>
                                <label for="username">Придумайте логин</label>
                                <#if usernameError??>
                                    <div class="invalid-feedback">
                                        ${usernameError}
                                    </div>
                                </#if>
                            </div>

                            <div class="md-form">
                                <input type="email" id="email" name="email" value="${user.email!''}"
                                       class="form-control ${(emailError??)?string('is-invalid', '')}" required>
                                <label for="email">E-mail</label>
                                <#if emailError??>
                                    <div class="invalid-feedback">
                                        ${emailError}
                                    </div>
                                </#if>
                            </div>

                            <div class="md-form">
                                <input type="password" id="password" name="password"
                                       class="form-control ${(passwordError??)?string('is-invalid', '')}" required>
                                <label for="password">Придумайте пароль</label>
                                <#if passwordError??>
                                    <div class="invalid-feedback">
                                        ${passwordError}
                                    </div>
                                </#if>
                            </div>

                            <div class="md-form">
                                <input type="password" id="password2" name="password2"
                                       class="form-control ${(password2Error??)?string('is-invalid', '')}" required>
                                <label for="password2">Повторите пароль</label>
                                <#if password2Error??>
                                    <div class="invalid-feedback">
                                        ${password2Error}
                                    </div>
                                </#if>
                            </div>

                            <p>
                                <strong>Установите роль(и)</strong>
                            </p>

                            <#list roles as role>
                                <div class="form-check mb-4">
                                    <input type="checkbox" id="${role}" name="roles" value="${role}"
                                           class="form-check-input"
                                    >
                                    <label for="${role}" class="form-check-label">
                                        <#if role.name() == '_3_STUDENT'>
                                            Студент
                                        <#elseIf role.name() == '_2_TEACHER'>
                                            Преподаватель
                                        <#elseIf role.name() == '_1_ADMIN'>
                                            Администратор
                                        </#if>
                                    </label>
                                </div>
                            </#list>

                            <div class="modal-footer d-flex justify-content-center">

                                <button type="button" onClick='location.href="/admin/users"'
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

</@aC.adminPage>
