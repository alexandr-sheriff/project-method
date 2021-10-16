<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container-fluid full-page-container">
        <div class="row h-100 justify-content-center align-items-center">
            <div class="col-lg-6 col-sm-8 animated fadeIn">
                <!-- Material form login -->
                <div class="card z-depth-2">

                    <h5 class="card-header pink lighten-3 white-text text-center py-4">
                        <strong>Регистрация</strong>
                    </h5>

                    <!--Card content-->
                    <div class="card-body px-lg-5 pt-0">

                        <#if captchaError??>
                            <div id="my-alert" class="alert alert-danger alert-dismissible fade show mt-2" role="alert">
                                ${captchaError}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </#if>

                        <!-- Form -->
                        <form action="/register" method="post" style="color: #757575;">

                            <!-- CSRF Token -->
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                            <!-- First Name -->
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

                            <!-- Last Name -->
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

                            <!-- Username -->
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

                            <!-- Email -->
                            <div class="md-form">
                                <input type="email" id="email" name="email" value="${user.email!''}"
                                       class="form-control ${(emailError??)?string('is-invalid', '')}" required>
                                <label for="email">Введите почту</label>
                                <#if emailError??>
                                    <div class="invalid-feedback">
                                        ${emailError}
                                    </div>
                                </#if>
                            </div>

                            <!-- Password -->
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

                            <!-- Password2 -->
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

                            <!-- Google ReCAPTCHA -->
                            <div class="md-form">
                                <div class="g-recaptcha"
                                     data-sitekey="6LftHugUAAAAAHl0PCp9f6QJNgb-FjFnFX6qlkAt"></div>
                            </div>

                            <!-- Sign in button -->
                            <button class="btn btn-outline-unique btn-block my-4 waves-effect z-depth-0"
                                    type="submit">Зарегистрироваться
                            </button>

                            <!-- Login -->
                            <p>Уже есть аккаунт?
                                <a href="/login">Войти</a>
                            </p>

                        </form>
                        <!-- Form -->

                    </div>

                </div>
                <!-- Material form login -->
            </div>
        </div>
    </div>
</@c.page>