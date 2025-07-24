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
		{if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern == 'Y' && isset($NavigationBlaettern)}
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
                					{if ($Einstellungen.artikeldetails.artikeldetails_navi_blaettern !== 'Y' && !isset($NavigationBlaettern)) || $isMobile}
										<div class="product-headline">
											{include file="snippets/zonen.tpl" id="opc_before_headline"}
											<h1 class="product-title">{$Artikel->cName}</h1>
										</div>
                					{else}
										<div class="product-headline visible-xs">
											{include file="snippets/zonen.tpl" id="opc_before_headline"}
											<span class="product-title h1 block">{$Artikel->cName}</span>
										</div>
                					{/if}
                				{/block}
                				{block name="productdetails-info-essential-wrapper"}
                					{if ($Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0) || isset($Artikel->cArtNr) || ($Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y')}
                    					<div class="info-essential row mb-xs">
											{block name="productdetails-info-essential-left"}
												<div class="col-12 col-sm-12 col-md-8 col-lg-6">
													{block name="productdetails-info-essential"}
														<ul class="blanklist nav nav-sm">
															{block name="productdetails-info-artnr-wrapper"}
																{if isset($Artikel->cArtNr)}
																	<li class="product-sku nav-it">
																		<strong>{lang key="sortProductno"}:</strong> <span>{$Artikel->cArtNr}</span>
																	</li>
																{/if}
															{/block}                                
															{block name="productdetails-info-mhd-wrapper"}
																{if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
																	<li title="{lang key='productMHDTool'}" class="best-before nav-it">
																		<strong>{lang key="productMHD"}:</strong> <span>{$Artikel->dMHD_de}</span>                                        
																	</li>
																{/if}
															{/block}                                
															{block name="productdetails-info-barcode-wrapper"}
																{if !empty($Artikel->cBarcode) && ($Einstellungen.artikeldetails.gtin_display === 'details' || $Einstellungen.artikeldetails.gtin_display === 'always')}
																	<li class="nav-it">
																		<strong>{lang key='ean'}: </strong><span>{$Artikel->cBarcode}</span>
																	</li>
																{/if}
															{/block}                                
															{block name="productdetails-info-isbn-wrapper"}
																{if !empty($Artikel->cISBN) && ($Einstellungen.artikeldetails.isbn_display === 'D' || $Einstellungen.artikeldetails.isbn_display === 'DL')}
																	<li class="nav-it">
																		<strong>{lang key='isbn'}: </strong><span>{$Artikel->cISBN}</span>
																	</li>
																{/if}
															{/block}
															{block name="productdetails-info-category-wrapper"}
																{assign var=i_kat value=($Brotnavi|count)-2}
																{if $Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y' && isset($Brotnavi[$i_kat])}
																	<li class="product-category word-break nav-it">
																		<strong>{lang key="category" section="global"}: </strong><a href="{$Brotnavi[$i_kat]->getURLFull()}" {if !empty($smarty.get.quickView)}target="_blank"{/if}>{$Brotnavi[$i_kat]->getName()}</a>
																	</li>
																{/if}
															{/block}                                
															{block name="productdetails-info-gefahrgut-wrapper"}
																{if !empty($Artikel->cUNNummer) && !empty($Artikel->cGefahrnr) && ($Einstellungen.artikeldetails.adr_hazard_display === 'D' || $Einstellungen.artikeldetails.adr_hazard_display === 'DL')}
																	<li class="nav-it">
																		<strong>{lang key='adrHazardSign'}: </strong>
																		<div class="adr-table text-center">
																			<strong class="block first">{$Artikel->cGefahrnr}</strong>
																			<strong class="block">{$Artikel->cUNNummer}</strong>
																		</div>
																	</li>
																{/if}
															{/block} 
															{if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}
																{block name="productdetails-info-rating-wrapper"}
																	<li class="rating-wrapper nav-it flx-ac">
																		<strong class="icon-wt">{lang key="rating" section="global"}:</strong>
																		<a id="jump-to-votes-tab" class="hidden-print"{if $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen == 'N' || $isMobile} data-toggle="collapse" href="#tab-votes" role="button"{else} href="{$Artikel->cURLFull}#tab-votes" {/if}>
																			{include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
																		</a>
																	</li>
																{/block}
															{/if}
															{block name="productdetails-info-manufacturer-wrapper"}
																{if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller)}
																	<li class="nav-it flx-ac">
																		{block name="product-info-manufacturer"}
																			<strong class="block first icon-wt">{lang key='manufacturer' section='productDetails'}: </strong>
																			{if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
																				<a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerURL}{/if}" title="{$Artikel->cHersteller|escape:'html'}" class="flx-ac"{if !empty($Artikel->cHerstellerHomepage)} target="_blank"{/if}>
																			{else}
																				<span class="flx-ac">
																			{/if}
																				{if ($Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B' || $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'BT') && !empty($Artikel->cHerstellerBildURLKlein)}	
																					<span class="img-ct icon icon-wt icon-xl contain img-manu">
																						{image lazy=true webp=true src=$Artikel->cHerstellerBildURLKlein alt=$Artikel->cHersteller|escape:'html'}
																					</span>
																				{/if}
																				{if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'B'}
																					<span>{$Artikel->cHersteller}</span>
																				{/if}
																			{if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
																				</a>
																			{else}
																				</span>
																			{/if}
																		{/block}
																	</li>
																{/if}
															{/block}
														</ul>
													{/block}
												</div>
											{/block}
											{block name="productdetails-info-essential-right"}
												<div class="col-md-4 col-lg-6">  
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
												<div class="col-12{if $Artikel->bHasKonfig} no-pop-tg{elseif $snackyConfig.css_maxPageWidth >= 1600} col-xl-6{/if} as-fs">
													{block name="productdetails-info-price"}
														{if !($Artikel->Preise->fVKNetto == 0 && isset($Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_VOUCHER_FLEX]))}
															{include file="productdetails/price.tpl" Artikel=$Artikel tplscope="detail"}
														{/if}
														{block name="productdetails-info-stock"}
															{include file="productdetails/stock.tpl" tplscope="detail"}
														{/block}
													{/block}
												</div>
												<div class="col-12{if $Artikel->bHasKonfig}{elseif $snackyConfig.css_maxPageWidth >= 1600} col-xl-6{/if} buy-col">
													{block name="details-wenig-bestand-wrapper"}
														{if $snackyConfig.hotStock > 0 && $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull === 'N' && $Artikel->fLagerbestand <= $snackyConfig.hotStock && $Artikel->fLagerbestand > 0}
															<div class="mb-xxs">
																<div class="alert alert-hotstock m0 text-center"><strong>{lang key="hotStock" section="custom" printf=$Artikel->fLagerbestand}</strong></div>
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
															{if $verfuegbarkeitsBenachrichtigung == 1}
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
											{block name="details-buy-actions-wrapper"}
												<div class="hidden">
													{include file="productdetails/actions.tpl"}
												</div>
											{/block}
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
		</form>
	{/block}
	{block name="details-question-availability-modals"}
		{block name="details-question-modal"}
			{if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P' && empty($smarty.get.quickView)}
				<div class="modal fade mod-frm" id="pp-question_on_item" tabindex="-1" role="dialog" aria-labelledby="pp-question_on_item-label" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="pp-question_on_item-label">{lang key='productQuestion' section='productDetails'}</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
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
			{if ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3) && $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull !== 'Y'}
				<div class="modal fade" id="pp-availability_notification" tabindex="-1" role="dialog" aria-labelledby="pp-availability_notification-label" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="pp-availability_notification-label">{lang key='requestNotification'}</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
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
			{include file="productdetails/tabs.tpl"}
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