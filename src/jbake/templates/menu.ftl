<#macro renderMenu currentPage>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container px-5">
      <a class="navbar-brand" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>index.html"><img class="logo" src="<#if (content.rootpath)??>${content.rootpath}<#else></#if>images/kivio-white.png" alt="Logo"></a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mb-2 mx-1 mb-lg-0">
          <#list published_categorys?sort_by("title") as category>
            <#assign downcasedTitle = category.title?lower_case>
            <#assign activeFlag = ''>
            <#if (currentPage?contains(downcasedTitle))>
              <#assign activeFlag = 'active'>
            </#if>
            <li class="nav-item mx-1 ${activeFlag}">
              <a class="nav-link ${activeFlag}" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>${category.uri}">${category.title}</a>
            </li>
          </#list>
        </ul>
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <#include "github_avatar.ftl">
        </ul>
      </div>
    </div>
  </nav>
</#macro>