{* Google Tag Manager *}
{if !empty($snackyConfig.gtag|trim) || $snackyConfig.use_tagmanager_gateway == 1}
	{inline_script}
		<script>			
			document.addEventListener('consent.ready', function(e) {
				km_tagManager_consent(e.detail);
			});
			document.addEventListener('consent.updated', function(e) {
				km_tagManager_consent(e.detail);
			});

			var tagmanagerloaded = {if $snackyConfig.tagmanager_consentmode == 'V2'}true{else}false{/if};
			function km_tagManager_consent(detail)
			{
				if (detail !== null && typeof detail.km_tagmanager !== 'undefined') {
					if (detail.km_tagmanager === true) {
						
						{if $snackyConfig.tagmanager_consentmode != 'V2'}
							if(tagmanagerloaded == false)
							{
								loadTagmanager();
								tagmanagerloaded = true;
							}
						{/if}
						
						gtag('consent', 'update', {
							'ad_user_data': 'granted',
							'ad_personalization': 'granted',
							'ad_storage': 'granted',
							'analytics_storage': 'granted'
						});

					}
				}

			}
			
			{if $snackyConfig.tagmanager_consentmode == 'V2'}
				loadTagmanager();
			{/if}
		</script>
	{/inline_script}
{/if}

{* Google Analytics 4 / Ads Tracking *}
{if !empty($snackyConfig.google_ads|trim) || !empty($snackyConfig.google_analytics_four|trim)}
	{inline_script}
		<script>
			document.addEventListener('consent.ready', function(e) {
				km_gtag_consent(e.detail);
			});
			document.addEventListener('consent.updated', function(e) {
				km_gtag_consent(e.detail);
			});

			function km_gtag_consent(detail)
			{
				if (detail !== null && (typeof detail.km_gtagAds !== 'undefined' && detail.km_gtagAds === true))
				{
					gtag('consent', 'update', {
						'ad_user_data': 'granted',
						'ad_personalization': 'granted',
						'ad_storage': 'granted'
					});
				}
				if (detail !== null && (typeof detail.km_gtagAnalytics !== 'undefined' && detail.km_gtagAnalytics === true))
				{
					gtag('consent', 'update', {
						'ad_user_data': 'granted',
						'ad_personalization': 'granted',
						'analytics_storage': 'granted'
					});
				}

			}
		</script>
	{/inline_script}
{/if}

{* Bing Ads *}
{if !empty($snackyConfig.bing_ads|trim)}
	{inline_script}
	<script>
			var bingLoaded = false;
			document.addEventListener('consent.ready', function(e) {
				km_bing_consent(e.detail);
			});
			document.addEventListener('consent.updated', function(e) {
				km_bing_consent(e.detail);
			});

			function km_bing_consent(detail)
			{
				if (bingLoaded == false && detail !== null && typeof detail.km_bing !== 'undefined' && detail.km_bing === true) {
					bingLoaded = true;
					window.uetq = window.uetq || [];
					window.uetq.push(
						'consent',
						'update', 
						{
							'ad_storage':'granted'
						}
					);
				}

			}
	</script>
	{/inline_script}
{/if}

{* Matomo *}
{if !empty($snackyConfig.matomo|trim)}
	{inline_script}
	<script>
		var _paq = window._paq = window._paq || [];
		_paq.push(["setExcludedQueryParams", ["v"]]);
		_paq.push(['trackPageView']);
		_paq.push(['enableLinkTracking']);

		{if $snackyConfig.matomoConsent != 'Y'}
			(function(){
				var u="{$snackyConfig.matomo|trim}";
				_paq.push(['setTrackerUrl', u+'matomo.php']);
				_paq.push(['setSiteId', '{$snackyConfig.matomoSiteId}']);
				var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
				g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
			})();
		{else}
			var matomoLoaded = false;
			document.addEventListener('consent.ready', function(e) {
				km_matomo_consent(e.detail);
			});
			document.addEventListener('consent.updated', function(e) {
				km_matomo_consent(e.detail);
			});
			function km_matomo_consent(detail)
			{
				if (matomoLoaded == false && detail !== null && typeof detail.km_matomo !== 'undefined' && detail.km_matomo === true) {
					var u="{$snackyConfig.matomo|trim}";
					_paq.push(['setTrackerUrl', u+'matomo.php']);
					_paq.push(['setSiteId', '{$snackyConfig.matomoSiteId}']);
					var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
					g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
					matomoLoaded = true;
				}
			}
		{/if}
	</script>
	{/inline_script}
{/if}

{inline_script}
<script>
	setTimeout(function() {
		$('#consent-manager, #consent-settings-btn').removeClass('d-none');
	}, 100);

	document.addEventListener('consent.updated', function(e) {
		$.post('{$ShopURLSSL}/_updateconsent', {
			'action': 'updateconsent',
			'jtl_token': '{$smarty.session.jtl_token}',
			'data': e.detail
		});
	});

	{if !isset($smarty.session.consents)}
	document.addEventListener('consent.ready', function(e) {
		document.dispatchEvent(new CustomEvent('consent.updated', { detail: e.detail }));
	});
	{/if}

	window.CM = new ConsentManager({
		version: {$smarty.session.consentVersion|default:1}
	});

	// Zentrale Handler-Funktion
	var triggerCall = function(e) {
		e.preventDefault();
		const type = (e.currentTarget && e.currentTarget.dataset) ? e.currentTarget.dataset.consent : undefined;
		if (!type) return;

		if (window.CM && window.CM.getSettings(type) === false) {
			window.CM.openConfirmationModal(type, function () {
				let data = window.CM._getLocalData();
				if (data === null) {
					data = { settings: {} };
				}
				data.settings[type] = true;
				document.dispatchEvent(new CustomEvent('consent.updated', { detail: data.settings }));
			});
		}
	};

	// Delegierter Click-Handler (funktioniert auch nach AJAX)
	$(document)
		.off('click.consentTrigger')
		.on('click.consentTrigger', '.trigger', triggerCall);

</script>
{/inline_script}

{* Preload Stati for saving rendering time! *}
<script>
	if(JSON.parse(localStorage.getItem('consent')))
		document.getElementById('consent-manager').classList.add('mini');
	document.getElementById('consent-manager').classList.add('active');
</script>