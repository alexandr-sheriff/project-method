<#import "parts/common.ftlh" as c>

<@c.page>
    <div class="container-fluid full-page-container">
        <div class="row h-100 justify-content-center align-items-center">
            <div class="col-lg-6 col-sm-8 animated fadeIn">
                <!-- Material form login -->
                <div class="card z-depth-2">

                    <h5 class="card-header pink lighten-3 white-text text-center py-4">
                        <strong>Вход</strong>
                    </h5>

                    <!--Card content-->
                    <div class="card-body px-lg-5 pt-0">

                        <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
                            <div id="my-alert" class="alert alert-danger alert-dismissible fade show mt-2" role="alert">
                                ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </#if>

                        <#if message??>
                            <div id="my-alert" class="alert alert-${messageType} alert-dismissible fade show"
                                 role="alert">
                                ${message}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </#if>

                        <!-- Form -->
                        <form action="/login" method="post" style="color: #757575;">

                            <!-- CSRF Token -->
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                            <!-- Email -->
                            <div class="md-form">
                                <input type="text" id="username" name="username"
                                       class="form-control" required>
                                <label for="username">Введите логин</label>
                            </div>

                            <!-- Password -->
                            <div class="md-form">
                                <input type="password" id="password" name="password"
                                       class="form-control" required>
                                <label for="password">Введите пароль</label>
                            </div>

                            <!-- Sign in button -->
                            <button class="btn btn-outline-unique btn-block my-4 waves-effect z-depth-0"
                                    type="submit">Войти
                            </button>

                            <!-- Register -->
                            <p>Не зарегистрированы?
                                <a href="/register">Зарегистрироваться</a>
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