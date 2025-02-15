<!-- HTML5 HEADER WITH NAVIGATION -->
<#include "header.ftl">
<#import "menu.ftl" as topmenu>
<@topmenu.renderMenu currentPage="${content.uri}" />
<main class="flex-shrink-0">
	<!-- MAIN CONTENT -->
	<section class="content light">
		${content.body}
	</section>
</main>
<!-- HTML5 FOOTER -->
<#include "footer.ftl">