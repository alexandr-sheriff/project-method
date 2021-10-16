<#assign know = Session.SPRING_SECURITY_CONTEXT??>
<#if know>
    <#assign
    currentUser = Session.SPRING_SECURITY_CONTEXT.authentication.principal
    userName = currentUser.getUsername()
    isAuthorized = currentUser.isAuthorized()
    isAdmin = currentUser.isAdmin()
    isTeacher = currentUser.isTeacher()
    isStudent = currentUser.isStudent()
    currentUserId = currentUser.getUserId()
    >
<#else>
    <#assign
    name = "unknown"
    isAuthorized = false
    isAdmin = false
    currentUserId = -1
    >
</#if>