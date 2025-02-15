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
<@topmenu.renderMenu currentPage="/" />
<header class="bg-dark py-5">
	<div class="container px-5">
		<div class="row gx-5 align-items-center justify-content-center">
			<div class="col-lg-8 col-xl-7 col-xxl-6">
				<div class="my-5 text-center text-xl-start">
					<h1 class="display-5 fw-bolder text-white mb-2">Hybride Softwareentwicklung</h1>
					<p class="lead fw-normal text-white-50 mb-4">
						Mit meinen Co-Autoren
						beschreibe ich einen Ansatz, der die Vorteile agiler und klassischer Vorgehensweisen
						in einem Modell vereint und stellt die Praxistauglichkeit anhand von Case Studies
						unter Beweis.
					</p>
					<div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
						<a class="btn btn-green btn-lg px-4 me-sm-3" href="https://amzn.to/39oKRQE">
							<i class="fab fa-amazon"></i> Kaufen
						</a>
					</div>
				</div>
			</div>
			<div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center">
				<img class="img-fluid rounded-3 my-5 cover" src="images/hybride-softwareentwicklung-cover.jpg" alt="Buchcover" />
			</div>
		</div>
	</div>
</header>
<section class="py-5 bg-light" id="projects">
	<div class="container px-5 my-5">
		<div class="row gx-5">
			<div class="col-lg-4 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0">Open Source Software Projekte</h2></div>
			<div class="col-lg-8">
				<div class="row gx-5 row-cols-1 row-cols-md-2">
					<div class="col mb-5 h-100">
						<div class="feature bg-purple-50 bg-gradient text-white rounded-3 mb-3"><i class="fab fa-github"></i></div>
						<h2 class="h5"><a class="text-decoration-none text-purple-100" href="https://github.com/jenkinsci/wix-plugin" target="blank">WIX Toolset Plugin for Jenkins</a></h2>
						<p class="mb-0">Mit dem WIX Toolset ist es möglich, MSI-Pakete für den Microsoft Windows Installer zu bauen. Das Plugin für Jenkins ermöglicht die Integration des Bauens in einen Buildserver, um den Prozess der kontinuierlichen Integration bis hin zum Setup zu ermöglichen. Für das Ausführen des Plugins in Jenkins oder Hudson ist eine Windows-Instanz notwendig.</p>
					</div>
					<div class="col mb-5 h-100">
						<div class="feature bg-purple-50 bg-gradient text-white rounded-3 mb-3"><i class="fab fa-github"></i></div>
						<h2 class="h5"><a class="text-decoration-none text-purple-100" href="https://github.com/rollinhand/dbf-core" target="blank">dBASE Converter</a></h2>
						<p class="mb-0">Das Tool 'dbf' ist ein einfach zu benutzendes Kommandozeilenprogramm zum Anzeigen und Konvertieren von dBASE III, IV und 5.0 Datenbanken. Der Inhalt der dBASE-Datenbanken lässt sich am Bildschirm anzeigen oder in komma-separierte Dateien (CSV-Dateien) konvertieren, die in Microsoft Excel oder OpenOffice Calc geöffnet werden können.</p>
					</div>
					<div class="col mb-5 h-100">
						<div class="feature bg-purple-50 bg-gradient text-white rounded-3 mb-3"><i class="fab fa-github"></i></div>
						<h2 class="h5"><a class="text-decoration-none text-purple-100" href="https://github.com/rollinhand/c3faces" target="blank">C3Faces</a></h2>
						<p class="mb-0">C3Faces is a JSF library using C3.js for the underlying rendering technology for every interactive chart. In opposite to Highfaces works C3Faces together with Apache MyFaces and Oracles Mojarra.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
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
			<#list published_posts?reverse as post>
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
				<a class="text-decoration-none" href="/blog/index.html">
					Mehr Beiträge
					<i class="bi bi-arrow-right"></i>
				</a>
			</div>
		</div>
	</div>
</section>
<!-- HTML5 FOOTER -->
<#include "footer.ftl">