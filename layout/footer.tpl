{block name='layout-footer'}
{block name="content-all-closingtags"}
    {block name="content-closingtag"}
		{include file="snippets/zonen.tpl" id="opc_content"}
		{include file="snippets/zonen.tpl" id="after_content"} {* Compability to Snackys Shop 4 *}
    </div>{* /content *}
	{if $smallversion && !($isMobile && !$isTablet)}
		<div class="col-md-4 col-lg-3" id="checkout-cart">
			{include file="basket/cart_dropdown_checkout.tpl"}
		</div>
	{/if}
    {/block}
    
    {block name="aside"}
	{if !$smallversion && !$maintenance}
		{has_boxes position='left' assign='hasLeftBox'}
		{if !$bExclusive && $hasLeftBox && !empty($boxes.left|strip_tags|trim)}
			{assign var="hasFilters" value="true"}	
		{else}
			{assign var="hasFilters" value=false}	
		{/if}
		{if ($hasFilters == true && $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE) || ($snackyConfig.sidepanelEverywhere == 'Y' && $hasFilters == true) || isset($smarty.get.sidebar)}
			{include file="layout/sidebar.tpl"}
		{/if}
    {/if}
    {/block}
    
    {block name="content-row-closingtag"}
    </div>{* /row *}
    {/block}
    
    {block name="content-container-block-closingtag"}
    {/block}
    
    {block name="content-container-closingtag"}
    {/block}
    
    {block name="content-wrapper-closingtag"}
    </div>{* /content-wrapper*}
    {/block}
{/block}

{block name="footer"}
{if !$bExclusive}
    {block name="footer-payments-wrapper"}
	{if $snackyConfig.paymentWall != 0 && $nSeitenTyp!=11 && !$isMobile}
		{getZahlungsarten cAssign="zahlungsartenFooter"}
		{if $zahlungsartenFooter}
        {assign var="zahlungsartPre" value="0"}
			<div id="pay-f" class="hidden-xs mt-md">
				<div class="mw-container">
                    <ul class="blanklist dpflex-a-c dpflex-j-c dpflex-wrap">
                    {foreach from=$zahlungsartenFooter item=zahlungsart}
                        {if $zahlungsart->nActive == 1 && $zahlungsart->nNutzbar==1 && !empty($zahlungsart->cBild) && $snackyConfig.paymentWall != 3}
                            <li class="img">
                                {image src=$zahlungsart->cBild alt=$zahlungsart->cName}
                            </li>
                        {else if $zahlungsart->nActive == 1 && $zahlungsart->nNutzbar==1 && $snackyConfig.paymentWall != 2}
                            <li class="text">{$zahlungsart->cName}</li>
                        {/if}	
                    {/foreach}
                    </ul>
				</div>
			</div>	
		{/if}
	{/if}
    {/block}

    <footer id="footer" class="mt-md">

		{block name="footer-boxes"}
			{if !$smallversion && !$maintenance}
				{getBoxesByPosition position='bottom' assign='footerBoxes'}
				{if isset($footerBoxes) && count($footerBoxes) > 0}
					<div id="footer-boxes">
					<div class="mw-container">
                    {block name="layout-footer-boxes"}
						<div class="row row-multi{if $snackyConfig.footerBoxesDirection == "C"} dpflex-j-c{elseif $snackyConfig.footerBoxesDirection == "R"} dpflex-j-e{/if}">
							 {if $snackyConfig.logoFooter == 0 && isset($ShopLogoURL)}
								<div class="col-6 col-sm-4 col-md-3 col-lg-2 hidden-xs" id="logo-footer">  
                                    {image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive"}
								</div>
							{/if}
							{foreach name=bottomBoxes from=$footerBoxes  item=box}
									{if $smarty.foreach.bottomBoxes.iteration < 10}
									   <div class="{block name="footer-boxes-class"}col-6 col-sm-4 col-md-3 col-lg-2{/block}">
										{$box->getRenderedContent()}
									   </div>
									{/if}
							{/foreach}
                            {block name="footer-newsletter-outer"}
							{if $snackyConfig.newsletter_footer === 'Y'
							&& $Einstellungen.newsletter.newsletter_active === 'Y'}
								<div class="col-6 col-sm-4 col-md-3 col-lg-2">    
									<section class="panel box{block name="footer-newsletter-class"} newsletter-footer{/block}">
										{block name="footer-newsletter"}
											<div class="h5 panel-heading dpflex-a-center">
                                                {lang key="newsletter" section="newsletter"} {lang key="newsletterSendSubscribe" section="newsletter"}
                                                {if $snackyConfig.footerBoxesOpen === '0'}<span class="caret"></span>{/if}
											</div>
											<div class="panel-body">
												{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
												<p class="info small">
													{lang key="unsubscribeAnytime" section="newsletter"}
												</p>
												{/if}
                                                <form method="post" action="{get_static_route id='newsletter.php'}" class="form">
                                                    <fieldset>
                                                        {$jtl_token}
                                                        <input type="hidden" name="abonnieren" value="2"/>
                                                        <input type="email" size="20" name="cEmail" id="newsletter_email" class="form-control" placeholder="{lang key='emailadress'}">
                                                        <hr class="hr-xs invisible">
                                                        <button type="submit" class="btn btn-primary submit btn-block btn-sm">
                                                            <span>{lang key='newsletterSendSubscribe' section='newsletter'}</span>
                                                        </button>
                                                    </fieldset>
                                                </form>
											</div>
										{/block}
									</section>
								</div>
							{/if}
                            {/block}
							{if ((isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1) || (isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1)) && $snackyConfig.lgcu_footer != N}
								<div class="col-6 col-sm-4 col-md-3 col-lg-2">
									<section class="panel box box-lng-cur">
										<div class="h5 panel-heading dpflex-a-center">
                                            {if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
                                            {lang key="language" section="custom"}
                                            {/if}
                                            {if ((isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1) && (isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1))}
                                            &
                                            {/if}
                                            {if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
                                            {lang key="currency" section="global"}
                                            {/if}
                                            {if $snackyConfig.footerBoxesOpen === '0'}<span class="caret"></span>{/if}
										</div>
										<div class="panel-body">
										{block name="footer-language"}
										{if !$smallversion}
											{if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
											<div class="language-dropdown dropdown mb-xxs">
												<a href="#" class="dropdown-toggle btn btn-primary btn-block btn-sm" data-toggle="dropdown" itemprop="inLanguage" itemscope itemtype="http://schema.org/Language" title="{lang key='selectLang'}">
													{foreach from=$smarty.session.Sprachen item=Sprache}
														{if $Sprache->kSprache == $smarty.session.kSprache}
															<span class="lang-{$lang}" itemprop="name">{$Sprache->displayLanguage}</span>
														{/if}
													{/foreach}
													<span class="caret"></span>
												</a>
												<ul id="language-dropdown" class="dropdown-menu dropdown-menu-left">
												{foreach from=$smarty.session.Sprachen item=oSprache}
													{if $oSprache->kSprache != $smarty.session.kSprache}
														<li>
															<a href="{$oSprache->url}" class="link_lang {$oSprache->iso}" rel="nofollow">
																<span>{$oSprache->displayLanguage}</span>
															</a>
														</li>
													{/if}
													{/foreach}
												</ul>
											</div>
											{/if}
										{/if}
										{/block}
										{block name="footer-currency"}
										{if !$smallversion}
											{if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
											<div class="dropdown">
												<a href="#" class="dropdown-toggle btn btn-primary btn-block btn-sm" data-toggle="dropdown" title="{lang key='selectCurrency'}">
													{$smarty.session.Waehrung->getName()}
													<span class="caret"></span></a>
												<ul id="currency-dropdown" class="dropdown-menu dropdown-menu-left">
												{foreach from=$smarty.session.Waehrungen item=oWaehrung}
													<li>
														<a href="{$oWaehrung->getURL()}" rel="nofollow">{$oWaehrung->getName()}</a>
													</li>
												{/foreach}
												</ul>
											</div>
											{/if}
										{/if}
										{/block}
										</div>
									</section>
								</div>
							{/if}
						</div>
                    {/block}
					</div>
					</div>
                    {getLink nLinkart=12 cAssign="linkdatenschutz"}
                    {getLink nLinkart=27 cAssign="linkimpressum"}
                    {if ($linkimpressum || $linkdatenschutz) && $snackyConfig.footerBoxesOpen === '0'}
                        <div class="visible-xs mt-sm">
                                <div class="mw-container text-center small">
                                    {if $linkdatenschutz}<a href="{$linkdatenschutz->getURL()}" rel="nofollow">{$linkdatenschutz->getTitle()}</a>{/if}
                                    {if $linkimpressum && $linkdatenschutz} • {/if}
                                    {if $linkimpressum}<a href="{$linkimpressum->getURL()}" rel="nofollow">{$linkimpressum->getTitle()}</a>{/if}
                                </div>
                        </div>
                    {/if}
				{/if}
			{elseif $smallversion}
				{getLink nLinkart=12 cAssign="linkdatenschutz"}
				{getLink nLinkart=27 cAssign="linkimpressum"}
				{if $linkimpressum || $linkdatenschutz}
					<div class="mw-container text-center small">
						{if $linkdatenschutz}<a href="{$linkdatenschutz->getURL()}" rel="nofollow">{$linkdatenschutz->getTitle()}</a>{/if}
						{if $linkimpressum && $linkdatenschutz} • {/if}
						{if $linkimpressum}<a href="{$linkimpressum->getURL()}" rel="nofollow">{$linkimpressum->getTitle()}</a>{/if}
					</div>
				{/if}
			{/if}
		{/block}
		
		  {include file="snippets/zonen.tpl" id="after_footerboxes" title="after_footerboxes"}

            {block name="footer-additional"}
				{if !$smallversion}
                    {if $snackyConfig.socialmedia_footer === 'Y'}
                        <div id="footer-social" class="mw-container mt-sm">
                            <div class="footer-additional-wrapper dpflex-a-center dpflex-j-center dpflex-wrap">
                                {block name="footer-socialmedia"}
                                    {if !empty($snackyConfig.facebook)}
                                        <a href="{if $snackyConfig.facebook|strpos:'http' !== 0}https://{/if}{$snackyConfig.facebook}" class="btn-social btn-facebook dpflex-a-center dpflex-j-center" title="Facebook" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-facebook"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.twitter)}
                                        <a href="{if $snackyConfig.twitter|strpos:'http' !== 0}https://{/if}{$snackyConfig.twitter}" class="btn-social btn-twitter dpflex-a-center dpflex-j-center" title="Twitter" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-twitter"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.youtube)}
                                        <a href="{if $snackyConfig.youtube|strpos:'http' !== 0}https://{/if}{$snackyConfig.youtube}" class="btn-social btn-youtube dpflex-a-center dpflex-j-center" title="YouTube" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-youtube"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.vimeo)}
                                        <a href="{if $snackyConfig.vimeo|strpos:'http' !== 0}https://{/if}{$snackyConfig.vimeo}" class="btn-social btn-vimeo dpflex-a-center dpflex-j-center" title="Vimeo" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-vimeo"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.pinterest)}
                                        <a href="{if $snackyConfig.pinterest|strpos:'http' !== 0}https://{/if}{$snackyConfig.pinterest}" class="btn-social btn-pinterest dpflex-a-center dpflex-j-center" title="PInterest" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-pinterest"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.instagram)}
                                        <a href="{if $snackyConfig.instagram|strpos:'http' !== 0}https://{/if}{$snackyConfig.instagram}" class="btn-social btn-instagram dpflex-a-center dpflex-j-center" title="Instagram" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-instagram"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.skype)}
                                        <a href="{if $snackyConfig.skype|strpos:'skype:' !== 0}skype:{$snackyConfig.skype}?add{else}{$snackyConfig.skype}{/if}" class="btn-social btn-skype dpflex-a-center dpflex-j-center" title="Skype" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-skype"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.xing)}
                                        <a href="{if $snackyConfig.xing|strpos:'http' !== 0}https://{/if}{$snackyConfig.xing}" class="btn-social btn-xing dpflex-a-center dpflex-j-center" title="Xing" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-xing"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.linkedin)}
                                        <a href="{if $snackyConfig.linkedin|strpos:'http' !== 0}https://{/if}{$snackyConfig.linkedin}" class="btn-social btn-linkedin dpflex-a-center dpflex-j-center" title="Linkedin" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-linkedin"></use>
											</svg>
										</a>
                                    {/if}
                                {/block}
                            </div>
                        </div>
                    {/if}
                {/if}
            {/block}{* /footer-additional *}
			
        <div id="copyright" class="mw-container text-center small">
            {block name="footer-copyright"}
				<ul class="blanklist{if $snackyConfig.footerCopyright == 1 && !$isMobile} list-inline{/if}">
					{if $NettoPreise == 1}
						<li>{lang key="footnoteExclusiveVat" section="global" assign="footnoteVat"}</li>
					{else}
						<li>{lang key="footnoteInclusiveVat" section="global" assign="footnoteVat"}</li>
					{/if}
					{if $Einstellungen.global.global_versandhinweis === 'zzgl'}
						<li>
							{lang key='footnoteExclusiveShipping' section='global' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
						</li>
					{elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
						<li>
							{lang key='footnoteInclusiveShipping' section='global' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
						</li>
					{/if}
					{block name="footer-vat-notice"}
						<li>
							<span class="footnote-reference">*</span> {$footnoteVat}{if isset($footnoteShipping)}{$footnoteShipping}{/if}
						</li>
					{/block}
					{if !empty($meta_copyright)}
						<li><span itemprop="copyrightHolder">&copy; {$meta_copyright}</span></li>
					{/if}
					{if $Einstellungen.global.global_zaehler_anzeigen === 'Y'}
						<li>{lang key="counter" section="global"}: {$Besucherzaehler}</li>
					{/if}
					{if !empty($Einstellungen.global.global_fusszeilehinweis)}
						<li>{$Einstellungen.global.global_fusszeilehinweis}</li>
					{/if}
					{assign var=isBrandFree value=JTL\Shop::isBrandfree()}
					{if !$isBrandFree}
						<li id="system-credits">
						Powered by <a href="https://jtl-url.de/jtlshop" title="JTL-Shop" target="_blank" rel="noopener nofollow">JTL-Shop</a>
						</li>
					{/if}
					{if $snackyConfig.noCopyright|checkCopyfree}
						<li id="template-copyright">
							Made with <span class="color-brand">&hearts;</span> by <a href="https://www.knoell-marketing.de/" title="Werbeagentur - Knoell marketing">Knoell Marketing</a>
						</li>
					{/if}
				</ul>
            {/block}
        </div>
      {include file="snippets/zonen.tpl" id="after_footer" title="after_footer"}
    </footer>
{/if}
{/block}

{block name="main-wrapper-closingtag"}
{/block}
{if $snackyConfig.designWidth == 1}
</div>
{/if}
{* JavaScripts *}
{block name="footer-js"}
	<script>
	if (navigator.userAgent.indexOf('MSIE')!==-1
		|| navigator.appVersion.indexOf('Trident/') > -1) // If Internet Explorer
    {
		!function(e,s,t){
			(t=e.createElement(s)).async=!0,t.src="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/snackys/svg.min.js",(e=e.getElementsByTagName(s)[0]).parentNode.insertBefore(t,e)
		}(document,"script");
	}
	</script>

	{if (!isset($Einstellungen.template.general.use_cron) || $Einstellungen.template.general.use_cron === 'Y') && $smarty.now % 10 === 0}
		{inline_script}
		<script>$.get('includes/cron_inc.php');</script>
		{/inline_script}
	{/if}
	
	{$dbgBarBody}
	{captchaMarkup getBody=false}
{/block}
{block name='layout-footer-js'}{/block}

<div class="overlay-bg"></div>
<div id="bodyloader" class="text-center">
	<strong class="small">Loading ...</strong>
</div>
	{if $snackyConfig.pwa == 'Y'}
		<script>
			if ('serviceWorker' in navigator) {ldelim}
			  window.addEventListener('load', () => {ldelim}
				navigator.serviceWorker.register('{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/snackys/pwa.js?v={$nTemplateVersion}');
			  {rdelim});
			{rdelim}
		</script>
	{/if}
	
	{block name='layout-footer-io-path'}
		<div id="jtl-io-path" data-path="{$ShopURL}" class="d-none"></div>
	{/block}
	
	{block name='consent-manager'}
		{if $Einstellungen.consentmanager.consent_manager_active === 'Y' && !$isAjax && $consentItems->isNotEmpty()}
			<input id="consent-manager-show-banner" type="hidden" value="{$Einstellungen.consentmanager.consent_manager_show_banner}">
			{include file='snippets/consent_manager.tpl'}

			{* Google Tag Manager *}
			{if !empty($snackyConfig.gtag|trim)}
			<script>
				var tagmanagerloaded = false;
				document.addEventListener('consent.ready', function(e) {
					km_tagManager(e.detail);
				});
				document.addEventListener('consent.updated', function(e) {
					km_tagManager(e.detail);
				});
				function km_tagManager(detail) {
					if (detail !== null && typeof detail.km_tagmanager !== 'undefined' && tagmanagerloaded === false) {
						if (detail.km_tagmanager === true) {
							tagmanagerloaded = true;
							(function(w,d,s,l,i){ldelim}w[l]=w[l]||[];w[l].push({ldelim}'gtm.start':
							new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
							j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
							'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
							})(window,document,'script','dataLayer','{$snackyConfig.gtag|trim}');
						} 
					}
				}

			</script>
			{/if}
			
			<script>
				$(window).on('load', function () {
					window.CM = new ConsentManager({
						version: 1
					});
					var trigger = document.querySelectorAll('.trigger');
					var triggerCall = function (e) {
						e.preventDefault();
						let type = e.target.dataset.consent;
						if (CM.getSettings(type) === false) {
							CM.openConfirmationModal(type, function () {
								let data = CM._getLocalData();
								if (data === null) {
									data = { settings: {} };
								}
								data.settings[type] = true;
								document.dispatchEvent(new CustomEvent('consent.updated', { detail: data.settings }));
							});
						}
					}
					for (let i = 0; i < trigger.length; ++i) {
						trigger[i].addEventListener('click', triggerCall)
					}
					document.addEventListener('consent.updated', function (e) {
						$.post('{$ShopURLSSL}/', {
								'action': 'updateconsent',
								'jtl_token': '{$smarty.session.jtl_token}',
								'data': e.detail
							}
						);
					});
				});
			</script>
		{/if}
	{/block}
	{snackys_content id="html_body_end" title="html_body_end"}

</body>
</html>
{/block}