<#macro page>

    <!DOCTYPE html>

    <html lang="en">

    <head>
        <#include "head.ftlh">
    </head>
    <body>

    <header>
        <#include "navbar.ftlh">
    </header>

    <div class="wrapper">

        <!--Main layout-->
        <main class="page-content mt-5 pt-5">
            <div class="container">

                <#nested>

            </div>
        </main>
        <!--Main layout-->

        <#include "footer.ftlh">

    </div>

    <#include "script.ftlh">
    </body>
    </html>
</#macro>