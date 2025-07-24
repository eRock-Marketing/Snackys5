{block name='layout-footer'}
	{block name="content-all-closingtags"}
    	{block name="content-closingtag"}
			{include file="snippets/zonen.tpl" id="opc_content"}
			{include file="snippets/zonen.tpl" id="after_content"} {* Compability to Snackys Shop 4 *}
    		</div>
			{block name='footer-checkout-assign'}
				{if $nSeitenTyp == 11}
					{assign var="step3_active" value=($bestellschritt[5] == 1)}
				{/if}
			{/block}
			{block name='footer-checkout-sidebasket'}
				{if isset($smallversion) && $smallversion && !($isMobile && !$isTablet) && (!isset($step3_active) || !$step3_active)}
					<div class="col-md-4 col-lg-3" id="checkout-cart">
						{include file="basket/cart_dropdown_checkout.tpl"}
					</div>
				{/if}
    		{/block}
    	{/block}    
		{block name="aside"}
			{if (!isset($smallversion) || !$smallversion) && (!isset($maintenance) || !$maintenance) && $Link->getLinkType() != $smarty.const.LINKTYP_404}
				{has_boxes position='left' assign='hasLeftBox'}
				{if !$bExclusive && $hasLeftBox && !empty($boxes.left|strip_tags|trim)}
					{assign var="hasFilters" value="true"}	
				{else}
					{assign var="hasFilters" value=false}	
				{/if}
				{if ($hasFilters == true && $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE) || ($snackyConfig.sidepanelEverywhere == 'Y' && $hasFilters == true) || isset($smarty.get.sidebar) || (count($Suchergebnisse->getProducts()) > 0 && $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE && $isMobile)}
					{include file="layout/sidebar.tpl"}
				{/if}
			{/if}
		{/block}    
		{block name="content-row-closingtag"}
			</div>
		{/block}    
		{block name="content-container-block-closingtag"}
		{/block}    
		{block name="content-container-closingtag"}
		{/block}    
		{block name="content-wrapper-closingtag"}
			</div>
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
								<ul class="blanklist flx-ac flx-jc flx-w">
									{foreach from=$zahlungsartenFooter item=zahlungsart}
										{if $zahlungsart->nActive == 1 && $zahlungsart->nNutzbar==1 && !empty($zahlungsart->cBild) && $snackyConfig.paymentWall != 3}
											{block name="footer-payments-image"}
												<li class="img">
													{image src=$zahlungsart->cBild alt=$zahlungsart->cName lazy=true}
												</li>
											{/block}
										{else if $zahlungsart->nActive == 1 && $zahlungsart->nNutzbar==1 && $snackyConfig.paymentWall != 2}
											{block name="footer-payments-text"}
												<li class="text">{$zahlungsart->cName}</li>
											{/block}
										{/if}	
									{/foreach}
								</ul>
							</div>
						</div>	
					{/if}
				{/if}
			{/block}
			{block name="footer-wrapper"}
				{include file="snippets/zonen.tpl" id="before_footer" title="before_footer"}
				<footer id="footer" class="mt-md">
					{block name="footer-boxes"}
						{if (!isset($smallversion) || !$smallversion) && (!isset($maintenance) || !$maintenance)}
							{getBoxesByPosition position='bottom' assign='footerBoxes'}
							{if isset($footerBoxes) && count($footerBoxes) > 0}
								<div id="footer-boxes">
									<div class="mw-container">
										{block name="layout-footer-boxes"}
											<div class="row row-multi{if $snackyConfig.footerBoxesDirection == "C"} flx-jc{elseif $snackyConfig.footerBoxesDirection == "R"} flx-je{/if}">
												{if $snackyConfig.logoFooter == 0 && (isset($ShopLogoURL) || !empty($snackyConfig.svgLogo))}
													{block name="footer-logo"}
														<div class="col-6 col-sm-4 col-md-3 col-lg-2 hidden-xs" id="logo-footer">
															{include file="snippets/zonen.tpl" id="before_footer_logo" title="before_footer_logo"}
															{include file='layout/shoplogo.tpl' tplscope="footer"}
															{include file="snippets/zonen.tpl" id="after_footer_logo" title="after_footer_logo"}
														</div>
													{/block}
												{/if}
												{foreach name=bottomBoxes from=$footerBoxes  item=box}
													{block name="footer-boxes-boxes"}
														{if $smarty.foreach.bottomBoxes.iteration < 10 && $box->isActive() && !empty($box->getRenderedContent())}
															<div class="{block name="footer-boxes-class"}col-6 col-sm-4 col-md-3 col-lg-2{/block}">
																{$box->getRenderedContent()}
															</div>
														{/if}
													{/block}
												{/foreach}
												{block name="footer-newsletter-outer"}
													{if $snackyConfig.newsletter_footer === 'Y' && $Einstellungen.newsletter.newsletter_active === 'Y'}
														<div class="col-6 col-sm-4 col-md-3 col-lg-2">    
															<section class="panel box{block name="footer-newsletter-class"} newsletter-footer{/block}">
																{block name="footer-newsletter"}
																	{block name="footer-newsletter-headline"}
																		<div class="h5 panel-heading flx-ac">
																			{lang key="newsletter" section="newsletter"} {lang key="newsletterSendSubscribe" section="newsletter"}
																			{if $snackyConfig.footerBoxesOpen === '0'}<span class="caret"></span>{/if}
																		</div>
																	{/block}
																	{block name="footer-newsletter-content"}
																		<div class="panel-body">
																			{block name="footer-newsletter-content-notice"}
																				{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}
																					<p class="info small">
																						{lang key="unsubscribeAnytime" section="newsletter"}
																					</p>
																				{/if}
																			{/block}
																			{block name="footer-newsletter-content-form"}
																				<form method="post" action="{get_static_route id='newsletter.php'}" class="form">
																					<fieldset>
																						{$jtl_token}
																						<input type="hidden" name="abonnieren" value="2"/>
																						<input type="email" size="20" name="cEmail" id="newsletter_email" class="form-control" placeholder="{lang key='emailadress'}">
																						<p class="privacy text-muted">
																							<a href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_DATENSCHUTZ]->getURL()}{/if}" class="popup small tdu">
																								{lang key='privacyNotice'}
																							</a>
																						</p>
																						<button type="submit" class="btn btn-primary submit btn-block btn-sm">
																							<span>{lang key='newsletterSendSubscribe' section='newsletter'}</span>
																						</button>
																					</fieldset>
																				</form>
																			{/block}
																		</div>
																	{/block}
																{/block}
															</section>
														</div>
													{/if}
												{/block}
												{block name="footer-language-currency"}
													{if ((isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1) || (isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1)) && $snackyConfig.lgcu_footer != N}
														{assign var="isFooter" value=true}
														<div class="col-6 col-sm-4 col-md-3 col-lg-2">
															<section class="panel box box-lng-cur">
																{block name="footer-language-currency-headline"}
																	<div class="h5 panel-heading flx-ac">
																		{if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
																			{lang key="language" section="custom"}
																		{/if}
																		{if ((isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1) && (isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1))}
																		&
																		{/if}
																		{if JTL\Session\Frontend::getCurrencies()|count > 1}
																			{lang key="currency" section="global"}
																		{/if}
																		{if $snackyConfig.footerBoxesOpen === '0'}<span class="caret"></span>{/if}
																	</div>
																{/block}
																{block name="footer-language-currency-content"}
																	<div class="panel-body">
																		{block name="footer-language"}
																			{if (!isset($smallversion) || !$smallversion)}
																				{if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
																					 {include file="snippets/language_dropdown.tpl" isfooter=$isFooter}
																				{/if}
																			{/if}
																		{/block}
																		{block name="footer-currency"}
																			{if (!isset($smallversion) || !$smallversion)}
																				{if JTL\Session\Frontend::getCurrencies()|count > 1}
																					<div class="dropdown">
																						<a href="#" class="dropdown-toggle btn btn-block btn-sm" data-toggle="dropdown" title="{lang key='selectCurrency'}">
																							{JTL\Session\Frontend::getCurrency()->getName()}
																							<span class="caret"></span>
																						</a>
																						<ul id="currency-dropdown" class="dropdown-menu dropdown-menu-left">
																							{foreach JTL\Session\Frontend::getCurrencies() item=oWaehrung}
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
																{/block}
															</section>
														</div>
													{/if}
												{/block}
											</div>
										{/block}
									</div>
								</div>
								{block name="footer-mobile-imprint-privacy"}
									{getLink nLinkart=12 cAssign="linkdatenschutz"}
									{getLink nLinkart=27 cAssign="linkimpressum"}
									{if ($linkimpressum || $linkdatenschutz) && $snackyConfig.footerBoxesOpen === '0'}
										<div class="visible-xs mt-sm">
											<div class="mw-container text-center small">
												{if $linkdatenschutz}
													<a href="{$linkdatenschutz->getURL()}" rel="nofollow">
														{if !empty($linkdatenschutz->getTitle())}
															{$linkdatenschutz->getTitle()}
														{else}
															{$linkdatenschutz->getName()}
														{/if}
													</a>
												{/if}
												{if $linkimpressum && $linkdatenschutz} • {/if}
												{if $linkimpressum}
													<a href="{$linkimpressum->getURL()}" rel="nofollow">
														{if !empty($linkimpressum->getTitle())}
															{$linkimpressum->getTitle()}
														{else}
															{$linkimpressum->getName()}
														{/if}
													</a>
												{/if}
											</div>
										</div>
									{/if}
								{/block}
							{/if}
						{elseif isset($smallversion) && $smallversion}
							{block name="footer-smallversion"}
								{getLink nLinkart=12 cAssign="linkdatenschutz"}
								{getLink nLinkart=27 cAssign="linkimpressum"}
								{getLink nLinkart=24 cAssign="linkwrb"}
								{if $linkimpressum || $linkdatenschutz || $linkwrb}
									<div class="mw-container text-center small">
										{block name="footer-smallversion-privacy"}
											{if $linkdatenschutz}
												<a href="{$linkdatenschutz->getURL()}" rel="nofollow" class="popup">
													{if !empty($linkdatenschutz->getTitle())}
														{$linkdatenschutz->getTitle()}
													{else}
														{$linkdatenschutz->getName()}
													{/if}
												</a>
											{/if}
										{/block}
										{block name="footer-smallversion-separator"}
											{if $linkimpressum && $linkdatenschutz} • {/if}
										{/block}
										{block name="footer-smallversion-imprint"}
											{if $linkimpressum}
												<a href="{$linkimpressum->getURL()}" rel="nofollow" class="popup">
													{if !empty($linkimpressum->getTitle())}
														{$linkimpressum->getTitle()}
													{else}
														{$linkimpressum->getName()}
													{/if}
												</a>
											{/if}
										{/block}
										{block name="footer-smallversion-separator2"}
											{if $linkdatenschutz && $linkwrb} • {/if}
										{/block}
										{block name="footer-smallversion-wrb"}
											{if $linkwrb}
												<a href="{$linkwrb->getURL()}" rel="nofollow" class="popup">
													{if !empty($linkwrb->getTitle())}
														{$linkwrb->getTitle()}
													{else}
														{$linkwrb->getName()}
													{/if}
												</a>
											{/if}
										{/block}
									</div>
								{/if}
							{/block}
						{/if}
						{include file="snippets/zonen.tpl" id="after_footerboxes" title="after_footerboxes"}
					{/block}
					{block name="footer-additional"}
						{if !isset($smallversion) || !$smallversion}
							{if $snackyConfig.socialmedia_footer === 'Y'}
								<div id="footer-social" class="mw-container mt-sm">
									{include file='snippets/socialprofiles.tpl' tplscope="footer"}
								</div>
							{/if}
						{/if}
					{/block}
					{block name="footer-copyright-wrapper"}			
        				<div id="copyright" class="mw-container text-center small">
            				{block name="footer-copyright"}
								<ul class="blanklist{if $snackyConfig.footerCopyright == 1 && !$isMobile} list-inline{/if}">
									{block name="footer-copyright-assigns"}
										{if $NettoPreise == 1}
											{lang key="footnoteExclusiveVat" section="global" assign="footnoteVat"}
										{else}
											{lang key="footnoteInclusiveVat" section="global" assign="footnoteVat"}
										{/if}
										{if $Einstellungen.global.global_versandhinweis === 'zzgl'}
											{lang key='footnoteExclusiveShipping' section='global' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
										{elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
											{lang key='footnoteInclusiveShipping' section='global' printf=$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL() assign='footnoteShipping'}
										{/if}
									{/block}
									{block name="footer-vat-notice"}
										<li>
											<span class="footnote-reference">*</span> {$footnoteVat}{if isset($footnoteShipping)}{$footnoteShipping}{/if}
										</li>
									{/block}
									{block name="footer-copyright-meta"}
										{if !empty($meta_copyright)}
											<li><span>&copy; {$meta_copyright}</span></li>
										{/if}
									{/block}
									{block name="footer-copyright-counter"}
										{if $Einstellungen.global.global_zaehler_anzeigen === 'Y'}
											<li>{lang key="counter" section="global"}: {$Besucherzaehler}</li>
										{/if}
									{/block}
									{block name="footer-copyright-notice"}
										{if !empty($Einstellungen.global.global_fusszeilehinweis)}
											<li>{$Einstellungen.global.global_fusszeilehinweis}</li>
										{/if}
									{/block}
									{block name="footer-copyright-brandfree"}
										{assign var=isBrandFree value=JTL\Shop::isBrandfree()}
										{if !$isBrandFree}
											<li id="system-credits">
											Powered by <a href="https://jtl-url.de/jtlshop" title="JTL-Shop" target="_blank" rel="noopener nofollow">JTL-Shop</a>
											</li>
										{/if}
									{/block}
									{checkCopyfree cAssign="snackysCopyfree"}
									{if !$snackysCopyfree}
										<li id="template-copyright">
											Made with <span class="color-brand">&hearts;</span> by <a href="https://www.erock-marketing.de/" title="eCommerce Agency - eRock marketing">eRock Marketing</a>
										</li>
									{/if}
								</ul>
							{/block}
						</div>
					{/block}
      				{include file="snippets/zonen.tpl" id="after_footer" title="after_footer"}
				</footer>
			{/block}
		{/if}
	{/block}
	{block name="main-wrapper-closingtag"}
	{/block}
	{block name="snackys-boxedlayout-closer"}
		{if $snackyConfig.designWidth == 1}
			</div>
		{/if}
	{/block}
	{* Restliches CSS > alles nicht kritische *}
	{block name="layout-footer-css"}
		{if $Einstellungen.template.general.use_minify === 'N'}
			{foreach $cCSS_arr as $cCSS}
				<link rel="preload" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" as="style"
					  onload="this.onload=null;this.rel='stylesheet'">
			{/foreach}
			{if isset($cPluginCss_arr)}
				{foreach $cPluginCss_arr as $cCSS}
					<link rel="preload" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" as="style"
						  onload="this.onload=null;this.rel='stylesheet'">
				{/foreach}
			{/if}
			<noscript>
				{foreach $cCSS_arr as $cCSS}
					<link rel="stylesheet" href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}">
				{/foreach}
				{if isset($cPluginCss_arr)}
					{foreach $cPluginCss_arr as $cCSS}
						<link href="{$ShopURL}/{$cCSS}?v={$nTemplateVersion}" rel="stylesheet">
					{/foreach}
				{/if}
			</noscript>
		{else}
			<link rel="preload" href="{$ShopURL}/{$combinedCSS|replace:"evo":"snackys"}" as="style" onload="this.onload=null;this.rel='stylesheet'">
			<noscript>
				<link href="{$ShopURL}/{$combinedCSS|replace:"evo":"snackys"}" rel="stylesheet">
			</noscript>
		{/if}
	{/block}
	{* JavaScripts *}
	{block name="layout-footer-js"}
		{* aus head in footer geschoben *}
		{if $Einstellungen.template.general.use_minify === 'N'}
			{foreach $cPluginJsBody_arr as $cJS}
				<script defer src="{$ShopURL}/{$cJS}?v={$nTemplateVersion}"></script>
			{/foreach}
		{else}
			{foreach $minifiedJS as $key => $item}
				{if $key == "plugin_js_body"}
				<script defer src="{$ShopURL}/{$item}" data-text="true"></script>
				{/if}
			{/foreach}
		{/if}
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
	{block name="layout-footer-overlay-bg"}
		<div class="overlay-bg"></div>
	{/block}
	{block name="layout-footer-bodyloader"}
		<div id="bodyloader" class="text-center">
			<strong class="small">Loading ...</strong>
		</div>
	{/block}
	{block name="layout-footer-pwa"}
		{if $snackyConfig.pwa == 'Y'}
			<script>
				if ('serviceWorker' in navigator) {ldelim}
				  window.addEventListener('load', () => {ldelim}
					navigator.serviceWorker.register('{$ShopURL}/pwa.js?v={$nTemplateVersion}');
				  {rdelim});
				{rdelim}
			</script>
		{/if}
	{/block}	
	{block name='layout-footer-io-path'}
		<div id="jtl-io-path" data-path="{$ShopURL}" class="d-none"></div>
	{/block}	
	{block name='consent-manager'}
		{if $Einstellungen.consentmanager.consent_manager_active === 'Y' && !$isAjax && $consentItems->isNotEmpty()}
			<input id="consent-manager-show-banner" type="hidden" value="{$Einstellungen.consentmanager.consent_manager_show_banner}">
			{include file='snippets/consent_manager.tpl'}
			{include file='snippets/consent_manager_items.tpl'}
		{else}
			{include file='snippets/consent_manager_items_notracking.tpl'}
		{/if}
	{/block}	
	{block name="rich-snippets"}
		{include file='snippets/rich-snippets.tpl'}
	{/block}	
	{snackys_content id="html_body_end" title="html_body_end"}
	</body>
	</html>
{/block}