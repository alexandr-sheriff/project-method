<#import "adminSidebar.ftlh" as aS>

<#macro adminPage activeUrl>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <#include "adminHead.ftlh">
    </head>
    <body class="grey lighten-3">

    <!--Main Navigation-->
    <header>
        <#include "adminNavbar.ftlh">
        <@aS.adminSidebar activeUrl></@aS.adminSidebar>
    </header>
    <!--Main Navigation-->

    <div class="wrapper">

        <!--Main layout-->
        <main class="page-content pt-5 mx-lg-5">
            <div class="container-fluid mt-5">

                <#nested>

            </div>
        </main>
        <!--Main layout-->

        <#include "adminFooter.ftlh">

    </div>

    <#include "adminScript.ftlh">
    </body>
    </html>
</#macro>