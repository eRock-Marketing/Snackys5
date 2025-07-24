{* Bing Ads *}
{if !empty($snackyConfig.bing_ads|trim)}
	{inline_script}
	<script>
		var bingLoaded = true;
		(function(w,d,t,r,u)
		{
			var f,n,i;
			w[u]=w[u]||[],f=function()
			{
				var o={
					ti:"{$snackyConfig.bing_ads|trim}"
				};
				o.q=w[u],w[u]=new UET(o),w[u].push("pageLoad")
			},
			n=d.createElement(t),n.src=r,n.async=1,n.onload=n.onreadystatechange=function()
			{
				var s=this.readyState;
				s&&s!=="loaded"&&s!=="complete"||(f(),n.onload=n.onreadystatechange=null)
			},
			i=d.getElementsByTagName(t)[0],i.parentNode.insertBefore(n,i)
		})
		(window,document,"script","//bat.bing.com/bat.js","uetq");
	</script>
	{/inline_script}
{/if}

{* Matomo *}
{if !empty($snackyConfig.matomo|trim)}
	{inline_script}
	<script>
		var _paq = window._paq = window._paq || [];
		/* tracker methods like "setCustomDimension" should be called before "trackPageView" */
		_paq.push(["setExcludedQueryParams", ["v"]]);
		_paq.push(['trackPageView']);
		_paq.push(['enableLinkTracking']);
		(function() {
			var u="{$snackyConfig.matomo|trim}";
			_paq.push(['setTrackerUrl', u+'matomo.php']);
			_paq.push(['setSiteId', '{$snackyConfig.matomoSiteId}']);
			var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
			g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
		})();
	</script>
	{/inline_script}
{/if}