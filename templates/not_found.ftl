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
	    <header class="py-5 bg-purple-50 d-flex align-items-center">
            <div class="container px-5 my-5">
                <div class="row gx-5 justify-content-center">
                    <h1 class="text-center">
                        ${content.body}
                    </h1>
                </div>
            </div>
		</header>
	</section>
	<section class="py-5">
		<div class="container px-5 my-5">
			<div class="row gx-5 justify-content-center">
				<div class="col-lg-8 col-xl-6">
					<div class="text-center">
						<h2 class="fw-bolder">Aus dem Blog</h2>
						<p class="lead fw-normal text-muted mb-5">Die letzten drei Blog-Beiträge</p>
					</div>
				</div>
			</div>
			<!-- Die letzten 3 Blog-Einträge anzeigen -->
			<div class="row gx-5">
				<#list published_posts[0..2] as post>
					<div class="col-lg-4 mb-5">
						<div class="card h-100 shadow border-0">
							<div class="card-body p-4">
								<div class="badge bg-primary bg-gradient rounded-pill mb-2">${post.category}</div>
								<a class="text-decoration-none link-dark stretched-link" href="${post.uri}">
									<h5 class="card-title mb-3">${post.title}</h5>
								</a>
								<p class="card-text mb-0">${excerpt(post.body)}</p>
							</div>
							<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
								<div class="d-flex align-items-end justify-content-between">
									<div class="d-flex justify-content-between align-items-center">
										<#include "github_avatar.ftl">
										<div class="small ms-3">
											<div class="fw-bold">Björn Berg</div>
											<div class="text-muted">${post.date?string("dd.MM.yyyy")}</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</#list>
				<div class="text-end mb-5 mb-xl-0">
					<a class="text-decoration-none" href="archive.html">
						Mehr Beiträge
						<i class="bi bi-arrow-right"></i>
					</a>
				</div>
			</div>
		</div>
	</section>
</main>
<!-- HTML5 FOOTER -->
<#include "footer.ftl">
