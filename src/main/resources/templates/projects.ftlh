<#import "parts/common.ftlh" as c>
<#import "parts/pager.ftlh" as p>
<#import "parts/sizer.ftlh" as s>
<#import "parts/searcher.ftlh" as searcher>
<#include "parts/security.ftlh">

<@c.page>

<#--<#function userInProject>
    <#list projects.content as project>
        <#list project.projectTeams as team>
            <#if currentUser != team.teamUsers?first>
                <#return false>
            </#if>
        </#list>
        <#return true>
    </#list>
</#function>-->


    <#if isTeacher>
        <div class="row">

            <div class="col-md-10">
                <div class="card mb-4 wow pink lighten-3 fadeIn">
                    <div class="card-body d-sm-flex justify-content-between">

                        <h4 class="mb-2 mb-sm-0 pt-1">
                            <span>Проекты</span>
                            <span>/</span>
                        </h4>

                        <@s.sizer url projects 6 15 30 60/>

                        <@searcher.searcher projects/>

                    </div>
                </div>
            </div>

            <div class="col-md-2 mb-4 mb-md-0">
                <a href="/projects/project/create" role="button"
                   class="btn btn-info btn-block mt-2 waves-effect waves-light">Добавить проект</a>
            </div>
        </div>
    <#else>
        <div class="card mb-4 wow pink lighten-3 fadeIn">
            <div class="card-body d-sm-flex justify-content-between">

                <h4 class="mb-2 mb-sm-0 pt-1">
                    <span>Проекты</span>
                    <span>/</span>
                </h4>

                <@s.sizer url projects 6 15 30 60/>

                <@searcher.searcher projects/>

            </div>
        </div>
    </#if>

    <!--Section: Cards-->
    <section class="text-center">

        <#list projects.content?chunk(3) as projectsrow>
            <!--Grid row-->
            <div class="row mb-4 wow fadeIn">

                <#list projectsrow as project>

                    <!--Grid column-->
                    <div class="col-lg-4 col-md-12 mb-4">

                        <!--Card-->
                        <div class="card">

                            <#if project.projectImage?hasContent>
                                <!--Card image-->
                                <div class="view overlay">
                                    <img src="/files/${project.projectImage}"
                                         class="card-img-top"
                                         alt="">
                                    <#if teacherInProjects[project_index+projectsrow_index*3] || studentInProjects[project_index+projectsrow_index*3]>
                                        <a href="/projects/project/${project.projectId}" target="_blank">
                                            <div class="mask rgba-white-slight"></div>
                                        </a>
                                    </#if>
                                </div>
                            </#if>

                            <!--Card content-->
                            <div class="card-body">
                                <!--Title-->
                                <h4 class="card-title">
                                    <#if teacherInProjects[project_index+projectsrow_index*3] || studentInProjects[project_index+projectsrow_index*3]>
                                        <a href="/projects/project/${project.projectId}">${project.projectName}</a>
                                    <#else>
                                        ${project.projectName}
                                    </#if>
                                </h4>
                                <!--Text-->
                                <p class="card-text">${project.projectDescription}</p>

                                <#if project.projectStatus.name() == '_1_BACKLOG'>
                                    <h5><span class="badge badge-dark">
                                    В ожидании</span></h5>
                                <#elseIf project.projectStatus.name() == '_2_TO_DO'>
                                    <h5><span class="badge badge-light">
                                    Надо сделать</span></h5>
                                <#elseIf project.projectStatus.name() == '_3_IN_PROGRESS'>
                                    <h5><span class="badge badge-primary">
                                    В работе</span></h5>
                                <#elseIf project.projectStatus.name() == '_4_DONE'>
                                    <h5><span class="badge badge-warning">
                                    Выполнен</span></h5>
                                <#elseIf project.projectStatus.name() == '_5_ON_CHECK'>
                                    <h5><span class="badge badge-danger">
                                    На проверке</span></h5>
                                <#elseIf project.projectStatus.name() == '_6_VERIFIED'>
                                    <h5><span class="badge badge-secondary">
                                    Проверен</span></h5>
                                <#elseIf project.projectStatus.name() == '_7_COMPLETED'>
                                    <h5><span class="badge badge-success">Завершен</span></h5>
                                </#if>

                            </div>

                        </div>
                        <!--/.Card-->

                    </div>
                    <!--Grid column-->
                </#list>

            </div>
            <!--Grid row-->
        </#list>

        <!--Pagination-->
        <@p.pager projects 'center'/>
        <!--Pagination-->

    </section>
    <!--Section: Cards-->
</@c.page>