<#function excerpt content="">
    <#if content?contains("<!--more-->")>
        <#return content?keep_before("<!--more-->")?trim>
    <#else>
        <#return content>
    </#if>
</#function>

<!-- HTML5 HEADER WITH NAVIGATION -->
<#include "header.ftl">
<#import "menu.ftl" as topmenu>
<@topmenu.renderMenu currentPage="${content.uri}" />
<main class="flex-shrink-0">
    <!-- MAIN CONTENT -->
    <section class="content light">
        <div class="container px-5 py-5">
            <h3>Artikel der Kategorie ${content.title}</h3>
            <div class="row my-5 gx-5">
                <#if published_posts?has_content>
                    <#list published_posts?filter(p -> p.category?? && p.category == content.title) as post>
                        <div class="col-lg-12 mb-5">
                            <div class="card h-100 shadow-sm border-0">
                                <div class="row g-0">
                                    <div class="col-md-3">
                                        <div class="p-3">
                                            <#if (post.category)??>
                                                <div class="mb-3 badge bg-primary bg-gradient rounded-pill">${post.category}</div>
                                            </#if>
                                            <div class="d-flex align-items-end justify-content-between">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <#include "github_avatar.ftl">
                                                    <div class="small ms-3">
                                                        <div class="fw-bold">Björn Berg</div>
                                                        <div class="text-muted">${post.date?string("dd.MM.yyyy")}</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <#if (post.cofinpro)??>
                                                <div class="mt-5 small">
                                                    <div class="text-muted">
                                                        <i class="fab fa-medium"></i> <a class="text-decoration-none" href="${post.cofinpro}">Cofinpro</a>
                                                    </div>
                                                </div>
                                            </#if>
                                        </div>
                                    </div>
                                    <div class="col-md-9">
                                        <div class="card-body">
                                            <a class="text-decoration-none link-dark stretched-link" href="${content.rootpath}${post.uri}">
                                                <h5 class="card-title mb-3">${post.title}</h5>
                                            </a>
                                            <p class="card-text mb-0">${excerpt(post.body)}</p>
                                            <#if (post.tags)??>
                                                <div class="card-text d-flex justify-content-between">
                                                    <small class="text-muted"><i class="fa fa-tags"></i> ${post.tags?join(", ")}</small>
                                                </div>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#list>
                <#else>
                    <div class="col-lg-12 mb-5">
                        <div class="card h-100 shadow-sm border-0">
                                <div class="col-lg-12">
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">Keine Posts gefunden</h5>
                                        <p class="card-text mb-0">Für diese Kategorie existieren derzeit keine Posts.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </#if>
            </div>
        </div>
    </section>
</main>
<!-- HTML5 FOOTER -->
<#include "footer.ftl">