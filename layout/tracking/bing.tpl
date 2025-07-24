{block name='layout-bing-tracking'}
	{if $nSeitenTyp == 33 && $Bestellung->Positionen !== null && $Bestellung->Positionen|count > 0}
		<script>
		window.uetq = window.uetq || [];
		window.uetq.push('event', 'purchase', {ldelim}"revenue_value":{$Bestellung->fWarensummeNetto|number_format:2:".":""},"currency":"{$smarty.session.Waehrung->getCode()}"{rdelim});
        </script>
    {/if}
	<script>
		(function(w,d,t,r,u)
		{
			var f,n,i;
			w[u]=w[u]||[],f=function()
			{
				var o={
					ti:"{$snackyConfig.bing_ads|trim}",
					enableAutoSpaTracking: true
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
		
		{if $Einstellungen.consentmanager.consent_manager_active === 'Y'}
			window.uetq.push(
				'consent',
				'default',
				{
					'ad_storage': 'denied'
				}
			);
		{/if}
	</script>
{/block}