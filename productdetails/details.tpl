{block name='productdetails-details'}
	{block name='details-assigns'}
    	{has_boxes position='left' assign='hasLeftBox'}
	{/block}
    {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
		{block name='details-pushed-success'}
        	{include file='productdetails/pushed_success.tpl'}
		{/block}
    {else}
		{block name='details-alerts'}
        	{$alertList->displayAlertByKey('productNote')}
		{/block}
    {/if}
    {block name="product-pagination"}
		{if ($Einstellungen.artikeldetails.artikeldetails_navi_blaettern == 'Y' && isset($NavigationBlaettern)) || $snackyConfig.positionHeadline == 0}
			{block name="product-pagination-active"}
				{include file='productdetails/product_pagination.tpl'}
			{/block}
		{else}
			{block name="product-pagination-disabled"}
				<hr class="invisible hr-sm hidden-xs">
			{/block}
		{/if}
    {/block}
	{block name='details-cate-assign'}
		{foreach name=navi from=$Brotnavi item=oItem}
			{if $smarty.foreach.navi.total-1 == $smarty.foreach.navi.iteration}
				{assign var=cate value=$oItem->getName()}
			{/if}
		{/foreach}
	{/block}
    {block name="buyform-block"}
    	{include file="snippets/zonen.tpl" id="opc_before_buy_form"}
		<form id="buy_form{if !empty($smarty.get.quickView)}-quickview{/if}" method="post" action="{$Artikel->cURLFull}" class="jtl-validate mb-lg">
        	{$jtl_token}
        	<div class="row product-primary" id="product-offer">
				{block name='details-gallery'}
            		<div class="product-gallery col-12 col-sm-6">
						{include file="snippets/zonen.tpl" id="opc_before_gallery"}
						{include file="productdetails/image.tpl"}
						{include file="snippets/zonen.tpl" id="after_gallery"}
					</div>
				{/block}
				{block name='details-productinfos'}
            		<div class="product-info col-12 col-sm-6">
                        <div class="product-info-inner">
            			{block name="productdetails-info"}
            				{block name="productdetails-details-info"}                
								{block name="product-headline-block"}
                					{if $snackyConfig.positionHeadline == 1 || $isMobile}
										<div class="product-headline{if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}{else} mb-sm{/if}">
											{if $snackyConfig.positionManufacturer == 0 && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller)}
												{include file="productdetails/manufacturer.tpl"}
											{/if}
											{include file="snippets/zonen.tpl" id="opc_before_headline"}
											<h1 class="product-title{if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0) || (!($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX])) && $snackyConfig.pricePosition == 1)} mb-xxs{/if}">{$Artikel->cName}</h1>
										</div>
										{if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}
										{block name="productdetails-info-rating-wrapper"}
											<div class="rating-wrapper mb-xs">
												<a id="jump-to-votes-tab" class="hidden-print"{if $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen == 'N' || $isMobile} data-toggle="collapse" href="#tab-votes" role="button"{else} href="{$Artikel->cURLFull}#tab-votes" {/if}>
													{include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
												</a>
											</div>
										{/block}
										{/if}
                					{elseif ($Einstellungen.artikeldetails.artikeldetails_navi_blaettern == 'Y' && isset($NavigationBlaettern)) || $snackyConfig.positionHeadline == 0}
										<div class="product-headline visible-xs">
											{include file="snippets/zonen.tpl" id="opc_before_headline"}
											<span class="product-title h1 block">{$Artikel->cName}</span>
										</div>
                					{/if}
                				{/block}
								{if !($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX])) && $snackyConfig.pricePosition == 1}
									<div class="buy-wrapper mb-xs">
										{include file="productdetails/price.tpl" Artikel=$Artikel tplscope="detail"}
									</div>
								{/if}	
								{include file="snippets/zonen.tpl" id="before_product_info" title="before_product_info"}
                				{block name="productdetails-info-essential-wrapper"}
                					{if ($Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0) || isset($Artikel->cArtNr) || ($Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y')}
                    					<div class="info-essential row mb-xs">
											{if $snackyConfig.positionArticleInfos == 0}
												{include file="productdetails/info_essential.tpl"}
											{/if}
											{block name="productdetails-info-essential-right"}
												<div class="{if $snackyConfig.positionArticleInfos == 1}col-12{else}col-md-4 col-lg-6{/if}">  
													{block name="details-buy-actions-label-wrapper"}                                
														{include file="productdetails/actions-labels.tpl"}
													{/block}
												</div>
											{/block}
										</div>
									{/if}
								{/block}
								{block name="productdetails-info-description-wrapper"}
									{if $Einstellungen.artikeldetails.artikeldetails_kurzbeschreibung_anzeigen === 'Y' && $Artikel->cKurzBeschreibung}
										{block name="productdetails-info-description"}
											{include file="snippets/zonen.tpl" id="opc_before_short_desc"}
											<div class="shortdesc mb-xs">
												{if $snackyConfig.optimize_artikel == "Y"}{$Artikel->cKurzBeschreibung|optimize}{else}{$Artikel->cKurzBeschreibung}{/if}
											</div>
									   		{include file="snippets/zonen.tpl" id="opc_after_short_desc"}
										{/block}
									{/if}
								{/block}
								{block name="productdetails-info-gpsr-wrapper"}
									{if isset($Artikel->FunktionsAttribute.gpsr_manufacturer_homepage) 
										|| isset($Artikel->FunktionsAttribute.gpsr_manufacturer_email)
										|| isset($Artikel->FunktionsAttribute.gpsr_manufacturer_country)
										|| isset($Artikel->FunktionsAttribute.gpsr_manufacturer_state)
										|| isset($Artikel->FunktionsAttribute.gpsr_manufacturer_city)
										|| isset($Artikel->FunktionsAttribute.gpsr_manufacturer_postalcode)
										|| isset($Artikel->FunktionsAttribute.gpsr_manufacturer_housenumber)
										|| isset($Artikel->FunktionsAttribute.gpsr_manufacturer_street)
										|| isset($Artikel->FunktionsAttribute.gpsr_manufacturer_name)
									}
										{assign var="hasGPSR" value=true}
									{/if}
									{if ($snackyConfig.gpsr_shown != 0 || (isset($hasGPSR) && $hasGPSR)) && $snackyConfig.gpsr_position == 3}
										{block name="productdetails-gpsr-description"}
											<strong class="block">{lang key='gpsrHeadline' section='custom'}</strong>
											<a href="#" data-toggle="modal" data-target="#gpsr-popup" title="{lang key='gpsrHeadline' section='custom'}"><u>{lang key='gpsrLink' section='custom'}</u></a>
											<div class="modal modal-dialog blanklist" tabindex="-1" id="gpsr-popup">
												<div class="modal-content">
													<div class="modal-header">
														<span class="modal-title block h5">
															{lang key='gpsrHeadline' section='custom'}
														</span>
														<button type="button" class="close-btn" data-dismiss="modal" aria-label="{lang key='close' section='account data'}">
														</button>
													</div>
													<div class="modal-body">
														{include file="snippets/gpsr.tpl" hideTitle=true}
													</div>
												</div>
											</div>
										{/block}
									{/if}
								{/block}
                				{block name="productdetails-info-product-offer"}
                					<div class="product-offer">
                    					<hr>
                    					{block name="productdetails-info-hidden"}
                    						<input type="submit" name="inWarenkorb" value="1" class="hidden" />
											{if $Artikel->kArtikelVariKombi > 0}
												<input type="hidden" name="aK" value="{$Artikel->kArtikelVariKombi}" />
											{/if}
											{if isset($Artikel->kVariKindArtikel)}
												<input type="hidden" name="VariKindArtikel" value="{$Artikel->kVariKindArtikel}" />
											{/if}
											{if isset($smarty.get.ek)}
												{input type="hidden" name="ek" value=intval($smarty.get.ek)}
											{/if}
											<input type="hidden" id="AktuellerkArtikel" class="current_article" name="a" value="{$Artikel->kArtikel}" />
											<input type="hidden" name="wke" value="1" />
											<input type="hidden" name="show" value="1" />
											<input type="hidden" name="kKundengruppe" value="{JTL\Session\Frontend::getCustomerGroup()->getID()}" />
											<input type="hidden" name="kSprache" value="{JTL\Shop::getLanguageID()}" />
										{/block}
										{block name="productdetails-info-variation"}
											{include file="productdetails/variation.tpl" simple=$Artikel->isSimpleVariation showMatrix=$showMatrix}
										{/block}                   
                    					{if !empty($Artikel->staffelPreis_arr)}
                    						{block name="details-staffelpreise-wrapper"}
												{include file='productdetails/bulkprice.tpl'}
											{/block}
                    					{/if}
										{block name='productdetails-details-include-uploads'}
											{if empty($smarty.get.quickView)}
												{include file="snippets/uploads.tpl" tplscope='product'}
											{/if}
										{/block}
										{block name="km-sonderpreis-bis"}
											{if !empty($Artikel->dSonderpreisEnde_de) && $Artikel->dSonderpreisEnde_de|date_format:"%y%m%d" >= $smarty.now|date_format:"%y%m%d"  && $Artikel->dSonderpreisStart_de|date_format:"%y%m%d" <= $smarty.now|date_format:"%y%m%d" && $Artikel->Preise->Sonderpreis_aktiv == 1}
												{include file="productdetails/specialprice.tpl"}
											{/if}
										{/block}
										{block name="km-verfuegbar-ab"}
											{if $Artikel->nErscheinendesProdukt}
												{include file="productdetails/coming_soon.tpl"}
											{/if}
										{/block}
                    					{block name="details-buy-wrapper"}
                    						<div class="buy-wrapper row flx-ae">
												<div class="col-12{if $Artikel->bHasKonfig} no-pop-tg{if $snackyConfig.pricePosition == 1} mt-xxs{/if}{elseif $snackyConfig.css_maxPageWidth >= 1600 && $snackyConfig.css_maxProductWidth >= 900} col-xl-6{/if} as-fs">
													{block name="productdetails-info-price"}
														{if !($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX])) && $snackyConfig.pricePosition == 0}
															{include file="productdetails/price.tpl" Artikel=$Artikel tplscope="detail"}
														{/if}
														{block name="productdetails-info-stock"}
															{include file="productdetails/stock.tpl" tplscope="detail"}
														{/block}
													{/block}
												</div>
												<div class="col-12{if $Artikel->bHasKonfig}{elseif $snackyConfig.css_maxPageWidth >= 1600 && $snackyConfig.css_maxProductWidth >= 900} col-xl-6{/if} buy-col">
													{block name="details-wenig-bestand-wrapper"}
														{if $snackyConfig.hotStock > 0 && $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull === 'N' && $Artikel->fLagerbestand <= $snackyConfig.hotStock && $Artikel->fLagerbestand > 0}
															<div class="alert-hotstock text-center mb-xs">
																<strong class="block mb-xxs">{lang key="hotStock" section="custom" printf=$Artikel->fLagerbestand}</strong>
																<div class="progress">
																	{assign var="stock_percent" value=$Artikel->fLagerbestand / $snackyConfig.hotStock * 100}
																	<div class="progress-bar" style="width: {$stock_percent|round}%;">
																		{$Artikel->fLagerbestand}
																	</div>
																</div>
															</div>
														{/if}
													{/block}
													{block name="details-buy-buttons-wrapper"}
														{block name="details-buy-config-wrapper"}
															{assign var="configRequired" value=false}
															{if $Artikel->bHasKonfig}
																{block name="productdetails-config"}
																<div id="product-configurator">
																	<div class="product-config top10">
																		{*KONFIGURATOR*}
																		{include file="productdetails/config.tpl"}
																	</div>
																</div>
																{/block}
															{/if}
														{/block}
														{block name="details-buy-submit-wrapper"}
															{if empty($smarty.get.quickView)}
																{include file="productdetails/basket.tpl"}
															{/if}
														{/block}
													{/block}
													{block name="detail-notification-wrapper"}
														{if ($verfuegbarkeitsBenachrichtigung == 1 || $verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3)}
															{if $verfuegbarkeitsBenachrichtigung == 1 && $snackyConfig.positionArticleTabs != 1}
																<a id="goToNotification" href="#tab-availabilityNotification" class="btn btn btn-primary btn-block btn-lg" title="{lang key='requestNotification'}">
																	{lang key='requestNotification'}
																</a>
															{else}
																<button type="button" id="n{$kArtikel}" class="btn popup-dep notification btn btn-primary btn-block btn-lg" title="{lang key='requestNotification'}" data-toggle="modal" data-target="#pp-availability_notification">
																	{lang key='requestNotification'}
																</button>
															{/if}
														{elseif $Artikel->Lageranzeige->nStatus == '0'}
															<div class="alert alert-danger text-center m0">{lang key='soldout'}</div>
														{/if}
													{/block}
													{block name="detail-additional-payments"}
														<div class="add-pays text-center flx">
															<div class="paypal"></div>
															<div class="amazon"></div>
														</div>
														<div class="payplan"></div>
													{/block}
												</div>
											</div>
											{block name="detail-article-tabs-wrapper-top"}
												{if $snackyConfig.positionArticleTabs == 1 && !$isMobile}
													{include file="productdetails/tabs.tpl"}
												{/if}
											{/block}
											{if $snackyConfig.positionArticleInfos == 1}
												{include file="productdetails/info_essential.tpl"}
											{/if}
                    					{/block}
										{if isset($varKombiJSON) && $varKombiJSON!= ''}
											<script id="varKombiArr" type="application/json">{$varKombiJSON}</script>
										{/if}
									</div>
								{/block}
							{/block}
						{/block}
						{include file="snippets/zonen.tpl" id="after_product_info" title="after_product_info"}
						{block name="details-matrix"}
							{include file="productdetails/matrix.tpl"}
						{/block}
					{/block}
                </div>
				</div>
			</div>
			{if $snackyConfig.stickyBasket == 'Y'}
				{block name="sticky-basket-bar"}
					{if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0 && !$showMatrix}
					{else}
						{include file="productdetails/sticky-basket-bar.tpl"}
					{/if}
				{/block}
			{/if}
		</form>
	{/block}
	{block name="details-question-availability-modals"}
		{block name="details-question-modal"}
			{if ($Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P' && empty($smarty.get.quickView)) || $snackyConfig.positionArticleTabs == 1}
				<div class="modal fade mod-frm" id="pp-question_on_item" tabindex="-1" role="dialog" aria-labelledby="pp-question_on_item-label" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<div class="modal-title h5" id="pp-question_on_item-label">{lang key='productQuestion' section='productDetails'}</div>
								<button type="button" class="close" data-dismiss="modal" aria-label="{lang key='close' section='account data'}">
								</button>
							</div>
							<div class="modal-body">
								{include file="productdetails/question_on_item.tpl"}
							</div>
						</div>
					</div>
				</div>
			{/if}
		{/block}
		{block name="details-availability-modal"}
			{if ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3) || ($verfuegbarkeitsBenachrichtigung == 1 && $snackyConfig.positionArticleTabs == 1) && $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull !== 'Y'}
				<div class="modal fade" id="pp-availability_notification" tabindex="-1" role="dialog" aria-labelledby="pp-availability_notification-label" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<div class="modal-title h5" id="pp-availability_notification-label">{lang key='requestNotification'}</div>
								<button type="button" class="close" data-dismiss="modal" aria-label="{lang key='close' section='account data'}">
								</button>
							</div>
							<div class="modal-body">
								{include file='productdetails/availability_notification_form.tpl' tplscope="artikeldetails"}
							</div>
						</div>
					</div>
				</div>
			{/if}
		{/block}
	{/block}
	{if empty($smarty.get.quickView)}
		{block name="details-tabs"}
			{if $snackyConfig.positionArticleTabs == 0 || $isMobile}
				{include file="productdetails/tabs.tpl"}
			{/if}
			{if $snackyConfig.positionArticleTabs == 1 && $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && !$isMobile}
				{assign var="ratingCount" value=$Artikel->Bewertungen->oBewertung_arr|count}
				<div id="tab-votes" class="mb-lg{if $ratingCount == 0} text-center{/if}">
					<h2 class="h3">{lang key="Votes" section="global"} {if $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0}({$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}){/if}</h2>
					{include file="productdetails/reviews.tpl" stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}
				</div>
			{/if}
		{/block}
		{block name="details-productsliders"}
			{if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|count > 0 || isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|count > 0 || isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0 || isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0 || isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
				{block name="details-productsliders-partslist"}
					{if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|count > 0}
						<div class="partslist">
							<hr class="invisible">
							{lang key='listOfItems' section='global' assign='slidertitle'}
							{include file='productdetails/stueckliste.tpl' id='slider-partslist' productlist=$Artikel->oStueckliste_arr title=$slidertitle showPartsList=true}
						</div>
					{/if}
				{/block}
				{block name="details-productsliders-bundle"}
					{if isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|count > 0}
						<div class="bundle">
							{include file="productdetails/bundle.tpl" ProductKey=$Artikel->kArtikel Products=$Artikel->oProduktBundle_arr ProduktBundle=$Artikel->oProduktBundlePrice ProductMain=$Artikel->oProduktBundleMain}
						</div>
					{/if}
				{/block}
				{block name="details-productsliders-xselling"}
					{if isset($Xselling->Standard) || isset($Xselling->Kauf) || isset($oAehnlicheArtikel_arr)}
						<div class="recommendations hidden-print">
							{block name="productdetails-recommendations"}
								{block name="productdetails-recommendations-xsell"}
								{if isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0}
									{foreach $Xselling->Standard->XSellGruppen as $Gruppe}
										{include file='snippets/product_slider.tpl' class='x-supplies mb-lg' id='slider-xsell-group-'|cat:$Gruppe@iteration productlist=$Gruppe->Artikel title=$Gruppe->Name desc=$Gruppe->Beschreibung}
									{/foreach}
								{/if}
								{/block}
								{block name="productdetails-recommendations-whobought"}
									{if isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0}
										{lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails' assign='slidertitle'}
										{include file='snippets/product_slider.tpl' class='x-sell mb-lg' id='slider-xsell' productlist=$Xselling->Kauf->Artikel title=$slidertitle}
									{/if}
								{/block}
								{block name="productdetails-recommendations-related"}
									{if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
										{lang key='RelatedProducts' section='productDetails' assign='slidertitle'}
										{include file='snippets/product_slider.tpl' class='x-related mb-lg' id='slider-related' productlist=$oAehnlicheArtikel_arr title=$slidertitle}
									{/if} 
								{/block}
							{/block}
						</div>
					{/if}
				{/block}
			{/if}
		{/block}
		{block name="details-popups"}
			<div id="article_popups">
				{include file='productdetails/popups.tpl'}
			</div>
		{/block}
	{/if}
{/block}