<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>

    <!--Section: Modals-->
    <section>

        <!-- Followers Modal -->
        <div class="modal fade" id="followersModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="followersModalLabel">Подписчики ${user.username!''}</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Закрыть">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <#if user.userSubscribers?hasContent>
                            <ul class="list-group list-group-flush">
                                <#list user.userSubscribers as userSubscriber>
                                    <li class="list-group-item"><a
                                                href="/user/profile/${userSubscriber.userId}">${userSubscriber.fullname!''}</a>
                                    </li>
                                </#list>
                            </ul>
                        <#else>
                            У ${user.username!''} еще нет подписчиков.
                        </#if>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-unique waves-effect waves-effect" data-dismiss="modal">
                            Закрыть
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.Followers Modal-->

        <!-- Following Modal -->
        <div class="modal fade" id="followingModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="followingModalLabel">Подписки ${user.username!''}</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Закрыть">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <#if user.userSubscriptions?hasContent>
                            <ul class="list-group list-group-flush">
                                <#list user.userSubscriptions as userSubscription>
                                    <li class="list-group-item"><a
                                                href="/user/profile/${userSubscription.userId}">${userSubscription.fullname!''}</a>
                                    </li>
                                </#list>
                            </ul>
                        <#else>
                            ${user.username!''} еще ни на кого не подписан.
                        </#if>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-unique waves-effect waves-effect" data-dismiss="modal">
                            Закрыть
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.Following Modal-->

        <!-- Publish post modal -->
        <div style="z-index: 9999999;" class="modal fade" id="modalPost" tabindex="-1" role="dialog"
             aria-labelledby="publishModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <form id="profileCreatePost" class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="publishModalLabel">Write post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <!-- Default input -->
                        <input type="text" class="form-control mb-3" id="post_title" placeholder="Title" required="">
                        <input type="text" class="form-control mb-3" id="post_featured_image" placeholder="Image">
                        <input type="text" class="form-control mb-3" id="post_url" placeholder="URL">
                        <div class="form-group">
                            <textarea class="form-control rounded-0 mb-3" id="post_description" rows="10"
                                      placeholder="Description" required=""></textarea>
                        </div>
                        <tags class="tagify form-control mb-3 ">
                            <div contenteditable=""
                                 data-placeholder="Add at least one tag such as (node.js, button, PHP etc.) Max 5 tags"
                                 class="tagify--input"></div>
                        </tags>
                        <input type="text" id="post_tags" class="form-control mb-3"
                               placeholder="Add at least one tag such as (node.js, button, PHP etc.) Max 5 tags">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary waves-effect waves-light" data-dismiss="modal">
                            Close
                        </button>
                        <span class="waves-input-wrapper waves-effect waves-light"><input type="submit"
                                                                                          class="btn btn-primary"
                                                                                          value="Publish"></span>
                    </div>
                </form>
            </div>
        </div>
        <!-- ./Publish post modal -->

        <!-- Update post modal -->
        <div style="z-index: 9999999;" class="modal fade" id="modalUpdate" tabindex="-1" role="dialog"
             aria-labelledby="updateModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <form id="profileUpdatePost" class="modal-content" novalidate="">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateModalLabel">Update post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <input type="hidden" id="update_post_id">
                        <!-- Default input -->
                        <input type="text" class="form-control mb-3" id="update_post_title" placeholder="Title"
                               required="">
                        <input type="text" class="form-control mb-3" id="update_post_featured_image"
                               placeholder="Image">
                        <input type="text" class="form-control mb-3" id="update_post_url" placeholder="URL">
                        <div class="form-group">
                            <textarea class="form-control rounded-0 mb-3" id="update_post_description" rows="10"
                                      placeholder="Description" required=""></textarea>
                        </div>
                        <tags class="tagify form-control mb-3 ">
                            <div contenteditable=""
                                 data-placeholder="Add at least one tag such as (node.js, button, PHP etc.) Max 5 tags"
                                 class="tagify--input"></div>
                        </tags>
                        <input type="text" id="update_post_tags" class="form-control mb-3"
                               placeholder="Add at least one tag such as (node.js, button, PHP etc.) Max 5 tags"
                               required="">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary waves-effect waves-light" data-dismiss="modal">
                            Close
                        </button>
                        <span class="waves-input-wrapper waves-effect waves-light"><input type="submit"
                                                                                          class="btn btn-primary"
                                                                                          value="Save"></span>
                    </div>
                </form>
            </div>
        </div>
        <!-- ./Update post modal -->

        <!-- Modal create-->
        <div class="modal fade" id="modalCreate" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">What do you want to create?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body text-center">
                        <a class="btn btn-unique waves-effect waves-light" role="button" data-toggle="modal"
                           data-target="#modalPost">Write
                            post</a>
                        <a class="btn btn-primary waves-effect waves-light" href="/snippets/" role="button">Create
                            Snippet</a>
                        <a class="btn btn-indigo waves-effect waves-light" href="/articles/" role="button">Write
                            Article</a>
                        <a class="btn btn-deep-purple waves-effect waves-light" href="/news/design/" role="button">Add
                            News
                        </a>
                        <a class="btn btn-dark-green waves-effect waves-light" href="/support/" role="button">Help
                            someone</a>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-info btn-md waves-effect waves-light" data-dismiss="modal">
                            Cancel
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.Modal create-->

    </section>
    <!--Section: Modals-->

    <div class="row">

        <div class="col-md-4 mb-4"></div>

        <div class="col-md-4 mb-4">
            <mdb-card class="profile-card card">
                <div class="card">
                    <#if user.userImage?hasContent>
                        <div class="z-depth-1-half mb-4"><img
                                    alt=""
                                    class="ava-max rounded-circle mx-auto d-block"
                                    src="/files/${user.userImage}">
                        </div>
                    <#else>
                        <div class="z-depth-1-half mb-4"><img
                                    alt=""
                                    class="ava-max rounded-circle mx-auto d-block"
                                    src="/files/c81ff85f11db9ff8a23d6dc29c8b8b7e.png">
                        </div>
                    </#if>

                    <mdb-card-body class="pt-0 mt-0 card-body">
                        <div class="text-center"><h3 class="mb-3 font-bold">
                                <strong>${user.username}</strong></h3><h6
                                    class="font-bold blue-text mb-4">
                                <#list user.roles as role>
                                    <#if role.name() == '_3_STUDENT'>
                                        Студент
                                    <#elseIf role.name() == '_2_TEACHER'>
                                        Преподаватель
                                    <#elseIf role.name() == '_1_ADMIN'>
                                        Администратор
                                    </#if>
                                    <#sep><br>
                                </#list></h6></div>
                        <ul class="striped list-unstyled">
                            <li><strong>Имя:</strong> ${user.firstname}</li>
                            <li><strong>Фамилия:</strong> ${user.lastname}</li>
                            <li><strong>Адрес эл. почты:</strong> <a href="mailto:${user.email}">${user.email}</a></li>
                            <#if user.userInstitution??>
                                <li><strong>Учреждение образования:</strong> ${user.userInstitution}</li>
                            </#if>
                            <#if user.userPosition??>
                                <li><strong>Должность:</strong> ${user.userPosition}</li>
                            </#if>
                            <#if user.userInstitutionWebsite??>
                                <li><strong>Сайт учреждения образования:</strong> <a href="${user.userInstitutionWebsite}">${user.userInstitutionWebsite}</a></li>
                            </#if>
                            <#if user.userCountry??>
                                <li><strong>Страна:</strong> ${user.userCountry}</li>
                            </#if>
                            <#if user.userCity??>
                                <li><strong>Город:</strong> ${user.userCity}</li>
                            </#if>
                            <#if user.userDescription??>
                                <li><strong>Обо мне:</strong> ${user.userDescription}</li>
                            </#if>
                        </ul>
                        <hr>
                        <div class="text-center">
                            <a href="#" class="badge unique-color" data-toggle="modal" data-target="#followersModal">Подписчики ${user.userSubscribers?size}</a>
                            <a href="#" class="badge unique-color-dark" data-toggle="modal"
                               data-target="#followingModal">Подписки ${user.userSubscriptions?size}</a>
                            <a class="badge mdb-color tour step-4">Рейтинг ${user.userRating!''} <i
                                        class="far fa-gem"></i></a>
                        </div>
                        <#if user.userFacebook?? || user.userVK?? || user.userTwitter?? || user.userLinkedIn?? || user.userTelegram??>
                        <hr>
                        </#if>
                        <div class="text-center">
                            <#if user.userFacebook??>
                                <a href="${user.userFacebook!''}" class="teal-text"><i
                                            class="fab fa-facebook-f fa-2x mr-2"></i></a>
                            </#if>
                            <#if user.userVK??>
                                <a href="${user.userVK!''}" class="teal-text"><i class="fab fa-vk fa-2x mr-2"></i></a>
                            </#if>
                            <#if user.userTwitter??>
                                <a href="${user.userTwitter!''}" class="teal-text"><i
                                            class="fab fa-twitter fa-2x mr-2"></i></a>
                            </#if>
                            <#if user.userLinkedIn??>
                                <a href="${user.userLinkedIn!''}" class="teal-text"><i
                                            class="fab fa-linkedin-in fa-2x mr-2"></i></a>
                            </#if>
                            <#if user.userTelegram??>
                                <a href="${user.userTelegram!''}" class="teal-text"><i
                                            class="fab fa-telegram-plane fa-2x mr-2"></i></a>
                            </#if>
                        </div>
                    </mdb-card-body>
                </div>
            </mdb-card>
            <#if currentUser == user>
                <a class="btn btn-info btn-block m-inherit waves-effect waves-light mt-2"
                   href="/user/profile/${user.userId}/settings" role="button"
                   id="edit-profile"><i class="fas fa-edit"></i> Редактировать профиль</a>
            <#else>
                <#if !isSubscriber>
                    <a class="btn btn-info btn-block m-inherit waves-effect waves-light mt-2"
                       href="/user/profile/${user.userId}/subscribe" role="button"
                       id="sub-profile"><i class="far fa-star"></i> Подписаться</a>
                <#else>
                    <a class="btn btn-info btn-block m-inherit waves-effect waves-light mt-2"
                       href="/user/profile/${user.userId}/unsubscribe" role="button"
                       id="sub-profile"><i class="fas fa-star"></i></i> Отписаться</a>
                </#if>
            </#if>
        </div>

        <div class="col-md-4 mb-4"></div>

    </div>

</@c.page>