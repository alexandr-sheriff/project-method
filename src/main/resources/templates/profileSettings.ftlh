<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <main class="pt-4" style="padding-left: 0px;">
        <div class="container">

            <div id="mdb-panel-tab-content-loader" class="tab-content pt-5" style="display: none;">
                <div class="progress primary-color-dark">
                    <div class="indeterminate"></div>
                </div>
            </div>

            <div style="" id="mdb-panel-tab-content" class="tab-content">

                <!--Grid row-->
                <div class="row mb-4">

                    <!--Grid column-->
                    <div class="col-md-6 mb-4">

                        <!--Card-->
                        <div class="card">
                            <div id="mdb-settings-public-preloader" class="checkout-preloader-container"
                                 style="display: none;">
                                <div class="preloader-wrapper big active">
                                    <div class="spinner-layer spinner-blue-only">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="gap-patch">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Card header -->
                            <div class="card-header">Публичная информация</div>

                            <!--Card content-->
                            <div class="card-body">

                                <!-- Form -->
                                <form id="edit-user-form" action="/user/profile/${user.userId}/settings/publicInfo/save"
                                      method="post">

                                    <!-- CSRF Token -->
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                                    <!-- Form Method -->
                                    <input type="hidden" name="_method" value="put"/>

                                    <!--Input Name-->
                                    <input name="firstname" value="${user.firstname!''}" type="text"
                                           id="edit-first-name"
                                           class="form-control ${(firstnameError??)?string('is-invalid', '')}"
                                           placeholder="Имя">
                                    <#if firstnameError??>
                                        <div class="invalid-feedback">
                                            ${firstnameError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input name="lastname" value="${user.lastname!''}" type="text" id="edit-last-name"
                                           class="form-control mt-3 ${(lastnameError??)?string('is-invalid', '')}"
                                           placeholder="Фамилия">
                                    <#if lastnameError??>
                                        <div class="invalid-feedback">
                                            ${lastnameError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userInstitution!''}" type="text" id="userInstitution" name="userInstitution"
                                           class="form-control mt-3 ${(userInstitutionError??)?string('is-invalid', '')}"
                                           placeholder="Учреждение образования">
                                    <#if userInstitutionError??>
                                        <div class="invalid-feedback">
                                            ${userInstitutionError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userPosition!''}" type="text" id="userPosition" name="userPosition"
                                           class="form-control mt-3 ${(userPositionError??)?string('is-invalid', '')}"
                                           placeholder="Должность">
                                    <#if userPositionError??>
                                        <div class="invalid-feedback">
                                            ${userPositionError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userInstitutionWebsite!''}" type="text" id="userInstitutionWebsite" name="userInstitutionWebsite"
                                           class="form-control mt-3 ${(userInstitutionWebsiteError??)?string('is-invalid', '')}"
                                           placeholder="Сайт учреждения образования">
                                    <#if userInstitutionWebsiteError??>
                                        <div class="invalid-feedback">
                                            ${userInstitutionWebsiteError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userCountry!''}" type="text" id="userCountry" name="userCountry"
                                           class="form-control mt-3 ${(userCountryError??)?string('is-invalid', '')}"
                                           placeholder="Страна">
                                    <#if userCountryError??>
                                        <div class="invalid-feedback">
                                            ${userCountryError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userCity!''}" type="text" id="userCity" name="userCity"
                                           class="form-control mt-3 ${(userCityError??)?string('is-invalid', '')}"
                                           placeholder="Город">
                                    <#if userCityError??>
                                        <div class="invalid-feedback">
                                            ${userCityError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userFacebook!''}" type="text" id="userFacebook" name="userFacebook"
                                           class="form-control mt-3 ${(userFacebookError??)?string('is-invalid', '')}"
                                           placeholder="Введите ссылку на профиль Facebook">
                                    <#if userFacebookError??>
                                        <div class="invalid-feedback">
                                            ${userFacebookError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userVK!''}" type="text" id="userVK" name="userVK"
                                           class="form-control mt-3 ${(userVKError??)?string('is-invalid', '')}"
                                           placeholder="Введите ссылку на профиль ВКонтакте">
                                    <#if userVKError??>
                                        <div class="invalid-feedback">
                                            ${userVKError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userTwitter!''}" type="text" id="userTwitter"
                                           name="userTwitter"
                                           class="form-control mt-3 ${(userTwitterError??)?string('is-invalid', '')}"
                                           placeholder="Введите ссылку на профиль Twitter">
                                    <#if userTwitterError??>
                                        <div class="invalid-feedback">
                                            ${userTwitterError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userLinkedIn!''}" type="text" id="userLinkedIn"
                                           name="userLinkedIn"
                                           class="form-control mt-3 ${(userLinkedInError??)?string('is-invalid', '')}"
                                           placeholder="Введите ссылку на профиль LinkedIn">
                                    <#if userLinkedInError??>
                                        <div class="invalid-feedback">
                                            ${userLinkedInError}
                                        </div>
                                    </#if>

                                    <!--Input Name-->
                                    <input value="${user.userTelegram!''}" type="text" id="userTelegram"
                                           name="userTelegram"
                                           class="form-control mt-3 ${(userTelegramError??)?string('is-invalid', '')}"
                                           placeholder="Введите ссылку на профиль Telegram">
                                    <#if userTelegramError??>
                                        <div class="invalid-feedback">
                                            ${userTelegramError}
                                        </div>
                                    </#if>

                                    <!-- Textarea -->
                                    <textarea type="text" id="userDescription"
                                              name="userDescription"
                                              class="form-control mt-3 md-textarea ${(userDescriptionError??)?string('is-invalid', '')}"
                                              placeholder="Обо мне">${user.userDescription!''}</textarea>
                                    <#if userDescriptionError??>
                                        <div class="invalid-feedback">
                                            ${userDescriptionError}
                                        </div>
                                    </#if>

                                    <!-- Action button -->
                                    <div class="text-center">
                                        <button id="edit-user" type="submit"
                                                class="btn btn-info btn-md waves-effect waves-light mt-3">Сохранить изменения
                                        </button>
                                    </div>

                                </form>
                                <!-- Form -->

                            </div>

                        </div>
                        <!--/.Card-->

                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-md-6 mb-4">

                        <!--Card-->
                        <div class="card mb-4">

                            <div id="mdb-settings-password-preloader" class="checkout-preloader-container"
                                 style="display: none;">
                                <div class="preloader-wrapper big active">
                                    <div class="spinner-layer spinner-blue-only">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="gap-patch">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Card header -->
                            <div class="card-header">Фото профиля</div>

                            <!--Card content-->
                            <div class="card-body">

                                <#if user.userImage?hasContent>
                                    <div class="mb-4"><img
                                                alt=""
                                                class="ava-max rounded-circle mx-auto d-block"
                                                src="/files/${user.userImage}">
                                    </div>
                                <#else>
                                    <div class="mb-4"><img
                                                alt=""
                                                class="ava-max rounded-circle mx-auto d-block"
                                                src="/files/c81ff85f11db9ff8a23d6dc29c8b8b7e.png">
                                    </div>
                                </#if>

                                <!-- Form -->
                                <form id="user-reset-password-form"
                                      action="/user/profile/${user.userId}/settings/profilePhoto/save?${_csrf.parameterName}=${_csrf.token}"
                                      method="post" enctype="multipart/form-data">

                                    <div class="form-group">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="file" name="file">
                                            <#if !user.userImage?hasContent>
                                                <label class="custom-file-label" for="file" data-browse="Выбрать">Загрузите
                                                    фото</label>
                                            <#else>
                                                <label class="custom-file-label" for="file" data-browse="Выбрать">Обновите
                                                    фото</label>
                                            </#if>
                                        </div>
                                    </div>
                                    <div class="d-block btn-group" role="group">

                                        <div class="text-center">

                                            <a class="btn btn-info btn-md waves-effect waves-light"
                                               href="/user/profile/${user.userId}/settings/profilePhoto/delete"
                                               role="button"
                                               id="edit-profile">Удалить</a>


                                            <#if !user.userImage?hasContent>
                                                <button id="fileSubmit" type="submit"
                                                        class="btn btn-info btn-md waves-effect waves-light">Загрузить
                                                </button>
                                            <#else>
                                                <button id="fileSubmit" type="submit"
                                                        class="btn btn-info btn-md waves-effect waves-light">Обновить
                                                </button>
                                            </#if>
                                        </div>
                                    </div>

                                </form>
                                <!-- Form -->

                            </div>

                        </div>
                        <!--/.Card-->

                        <!--Card-->
                        <div class="card mb-4">

                            <div id="mdb-settings-account-preloader" class="checkout-preloader-container"
                                 style="display: none;">
                                <div class="preloader-wrapper big active">
                                    <div class="spinner-layer spinner-blue-only">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="gap-patch">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Card header -->
                            <div class="card-header">Настройки учетной записи</div>

                            <!--Card content-->
                            <div class="card-body">

                                <!-- Form -->
                                <form id="edit-user-account-form"
                                      action="/user/profile/${user.userId}/settings/accountSettings/save" method="post">

                                    <!-- CSRF Token -->
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                                    <!-- Form Method -->
                                    <input type="hidden" name="_method" value="put"/>

                                    <!--Input Name-->
                                    <input name="username" value="${user.username!''}" type="text" id="display_name"
                                           class="form-control" placeholder="Имя пользователя">

                                    <!--Input Name-->
                                    <input name="email" value="${user.email!''}" type="email" id="user_email"
                                           class="form-control mt-3" placeholder="Адрес электронной почты">

                                    <!-- Action button -->
                                    <div class="text-center">
                                        <button id="edit-user-account" type="submit"
                                                class="btn btn-info btn-md waves-effect waves-light mt-3">Сохранить изменения
                                        </button>
                                    </div>

                                </form>
                                <!-- Form -->

                            </div>

                        </div>
                        <!--/.Card-->

                        <!--Card-->
                        <div class="card mb-4">

                            <div id="mdb-settings-password-preloader" class="checkout-preloader-container"
                                 style="display: none;">
                                <div class="preloader-wrapper big active">
                                    <div class="spinner-layer spinner-blue-only">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="gap-patch">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Card header -->
                            <div class="card-header">Изменение пароля</div>

                            <!--Card content-->
                            <div class="card-body">

                                <!-- Form -->
                                <form id="user-reset-password-form"
                                      action="/user/profile/${user.userId}/settings/passwordChange/save" method="post">

                                    <!-- CSRF Token -->
                                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                                    <!-- Form Method -->
                                    <input type="hidden" name="_method" value="put"/>

                                    <!--Input Name-->
                                    <input name="passwordCurrent" type="password" id="current_password"
                                           class="form-control" placeholder="Текущий пароль">

                                    <!--Input Name-->
                                    <input name="password" type="password" id="new_password" class="form-control mt-3"
                                           placeholder="Новый пароль">

                                    <!--Input Name-->
                                    <input name="passwordConfirm" type="password" id="confirm_new_password"
                                           class="form-control mt-3" placeholder="Подтвердите новый пароль">

                                    <!-- Action button -->
                                    <div class="text-center">
                                        <button id="user-reset-password" type="submit"
                                                class="btn btn-info btn-md waves-effect waves-light mt-3">Сброс пароля
                                        </button>
                                    </div>

                                </form>
                                <!-- Form -->

                            </div>

                        </div>
                        <!--/.Card-->

                    </div>
                    <!--Grid column-->

                </div>
                <!--Grid row-->
            </div>
        </div>
    </main>
</@c.page>