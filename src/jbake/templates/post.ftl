<!-- HTML5 HEADER WITH NAVIGATION -->
<#include "header.ftl">
<#import "menu.ftl" as topmenu>
<@topmenu.renderMenu currentPage="${content.uri}" />
<main class="flex-shrink-0">
	<!-- Page Content-->
	<section class="py-5">
		<div class="container px-5 my-5">
			<div class="row gx-5">
				<div class="col-lg-3">
					<div class="d-flex align-items-center mt-lg-5 mb-4">
						<#include "github_avatar.ftl">
						<div class="small ms-3">
							<div class="fw-bold">Björn Berg</div>
						</div>
					</div>
					<!-- Hinweis auf fremden Blog-Artikel -->
					<#if content.cofinpr??>
						<div class="mt-lg-5 mb-4">
							<div><i class="fab fa-medium text-warning"></i> Cofinpro Blog-Beitrag</div>
							<p class="small text-muted">Dieser Artikel ist auch im <span class="cofinpro"><a href="${content.cofinpro}">Cofinpro-Blog auf Medium</a> erschienen.</span> <span class="cofinpro"><a href="http://www.cofinpro.de">Cofinpro</a></span> ist ein Beratungsunternehmen mit Fokus auf die Finanzindustrie.</p>
						</div>
					</#if>
				</div>
				<div class="col-lg-9">
					<!-- Post content-->
					<article>
						<!-- Post header-->
						<header class="mb-4">
							<!-- Post title-->
							<h1 class="fw-bolder mb-1">${content.title}</h1>
							<!-- Post meta content-->
							<div class="text-muted fst-italic mb-2">${content.date?string("dd.MM.yyyy")}</div>
							<!-- Post categories-->
							<#if (content.category)??>
								<a class="badge bg-primary text-decoration-none link-light" href="/category/${content.category?lower_case}">${content.category}</a>
							</#if>
							<!-- Post tags -->
							<#if (content.tags)?? && content.tags?has_content>
								<#list content.tags as tag>
									<span class="badge bg-secondary text-decoration-none link-light">${tag}</span>
								</#list>
							</#if>
						</header>
						<!-- Post content-->
						<section class="mb-5">
							${content.body}
						</section>
					</article>
					<section>
						<div class="card bg-light">
							<div class="card-body">
								<h5><i class="fa fa-comment"></i> Kommentar</h5>

								<div class="mt-3">
									<p>Du möchtest diskutieren oder einen Kommentar zu dem Beitrag hinterlassen?</p>
									<small class="text-muted">Dieser Blog hat keine öffentliche Kommentarfunktion, aber ich freue mich jederzeit über eine
										<a href="mailto:rollin.hand@gmx.de">Mail</a> mit kritischen Anmerkungen, Feedback oder auch einfach nur
										Lob an meine Mail-Adresse <a href="mailto:rollin.hand@gmx.de">rollin.hand[@]gmx.de</a>.</small>
								</div>
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
	</section>
</main>
<!-- HTML5 FOOTER -->
<#include "footer.ftl">