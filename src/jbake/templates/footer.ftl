<footer class="bg-dark py-4 mt-auto">
    <div class="container px-5">
        <div class="row align-items-center justify-content-between flex-column flex-sm-row">
            <div class="col-auto">
                <div class="small m-0 text-white">Copyright &copy; 2017 - 2025 by Björn Berg</div>
            </div>
            <div class="col-auto">
                <a class="link-light small" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>blog/meecrowave.html">Apache Meecrowave</a>
                <span class="text-white mx-1">&middot;</span>
                <a class="link-light small" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>privacy-policy/index.html">Privacy</a>
                <span class="text-white mx-1">&middot;</span>
                <a class="link-light small" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>about/index.html">Imprint</a>
                <span class="text-white mx-1">&middot;</span>
                <a class="link-light small" href="mailto:rollin.hand@gmx.de">Contact</a>
            </div>
            <div class="col-auto">
                <a class="link-light text-decoration-none mx-1 small" href="https://www.xing.com/profile/Bjoern_Berg2" target="_blank" rel="me">
                    <span class="button xing" aria-details="Xing"><i class="fab fa-xing"></i></span>
                </a>
                <a class="link-light text-decoration-none mx-1 small" href="https://www.linkedin.com/in/bjoernberg82" target="_blank" rel="me">
                    <span class="button linkedin" aria-details="LinkedIn"><i class="fab fa-linkedin"></i></span>
                </a>
                <a class="link-light text-decoration-none mx-1 small" href="<#if (content.rootpath)??>${content.rootpath}<#else></#if>blog/feed/atom.xml">
                    <span class="button atom" aria-details="Atom/RSS"><i class="fas fa-rss subscribe"></i></span>
                </a>
            </div>
        </div>
    </div>
</footer>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
</body>
</html>