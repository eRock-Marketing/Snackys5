{block name='productdetails-details'}
    {has_boxes position='left' assign='hasLeftBox'}

    {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
        {include file='productdetails/pushed_success.tpl'}
    {else}
        {$alertList->displayAlertByKey('productNote')}
    {/if}

    {block name="product-pagination"}
    {if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern == 'Y' && isset($NavigationBlaettern) && !$isMobile}
        <div id="prevNextRow" class="dpflex-a-center dpflex-j-between dpflex-wrap mb-sm hidden-xs">
            <div class="visible-lg visible-md product-pagination previous">
                {if isset($NavigationBlaettern->vorherigerArtikel) && $NavigationBlaettern->vorherigerArtikel->kArtikel}
                    <a href="{$NavigationBlaettern->vorherigerArtikel->cURLFull}" title="{$NavigationBlaettern->vorherigerArtikel->cName}" class="dpflex">
                        <span class="button dpflex-a-center dpflex-j-center">
                            <span class="ar ar-l"></span>
                        </span>
                        <span class="img-ct">
                            {include file='snippets/image.tpl' item=$NavigationBlaettern->vorherigerArtikel square=false srcSize='sm'}
                        </span>	
                    </a>
                {/if}
            </div>
            <h1 class="fn product-title text-center">{$Artikel->cName}</h1>
            <div class="visible-lg visible-md product-pagination next">
                {if isset($NavigationBlaettern->naechsterArtikel) && $NavigationBlaettern->naechsterArtikel->kArtikel}
                    <a href="{$NavigationBlaettern->naechsterArtikel->cURLFull}" title="{$NavigationBlaettern->naechsterArtikel->cName}" class="dpflex">
                        <span class="img-ct">
                            {include file='snippets/image.tpl' item=$NavigationBlaettern->naechsterArtikel square=false srcSize='sm'}
                        </span>
                        <span class="button dpflex-a-center dpflex-j-center">
                            <span class="ar ar-r"></span>
                        </span>
                    </a>
                {/if}
            </div>
        </div>
    {elseif $Einstellungen.artikeldetails.artikeldetails_navi_blaettern == 'Y' && isset($NavigationBlaettern) && $isMobile}
        <div id="prevNextRow" class="dpflex-a-center dpflex-j-between small">
            <div class="product-pagination previous">
                {if isset($NavigationBlaettern->vorherigerArtikel) && $NavigationBlaettern->vorherigerArtikel->kArtikel}
                    <a href="{$NavigationBlaettern->vorherigerArtikel->cURLFull}" title="{$NavigationBlaettern->vorherigerArtikel->cName}" class="dpflex-a-c">
                        <span class="ar ar-l"></span> {lang key="previous"}
                    </a>
                {/if}
            </div>
            <div class="product-pagination next">
                {if isset($NavigationBlaettern->naechsterArtikel) && $NavigationBlaettern->naechsterArtikel->kArtikel}
                    <a href="{$NavigationBlaettern->naechsterArtikel->cURLFull}" title="{$NavigationBlaettern->naechsterArtikel->cName}" class="dpflex-a-c">
                        {lang key="next"} <span class="ar ar-r"></span>
                    </a>
                {/if}
            </div>
        </div>
        <div class="hidden-xs"><hr class="invisible"></div>
    {else}
    <hr class="invisible hr-sm hidden-xs">
    {/if}
    {/block}

    {foreach name=navi from=$Brotnavi item=oItem}
        {if $smarty.foreach.navi.total-1 == $smarty.foreach.navi.iteration}
            {assign var=cate value=$oItem->getName()}
        {/if}
    {/foreach}
    {include file="snippets/zonen.tpl" id="opc_before_buy_form"}
    {block name="buyform-block"}
    <form id="buy_form" method="post" action="{$Artikel->cURLFull}" class="jtl-validate mb-lg">
        {$jtl_token}
        <div class="row product-primary" id="product-offer">
            <div class="product-gallery col-12 col-sm-6">
                {include file="snippets/zonen.tpl" id="opc_before_gallery"}
                {include file="productdetails/image.tpl"}
                {include file="snippets/zonen.tpl" id="after_gallery"}
            </div>
            <div class="product-info col-12 col-sm-6">
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
                                {assign var=i_kat value=($Brotnavi|@count)-2}
                                {if $Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y' && isset($Brotnavi[$i_kat])}
                                    <li class="product-category word-break nav-it">
                                        <strong>{lang key="category" section="global"}: </strong><a href="{$Brotnavi[$i_kat]->getURLFull()}">{$Brotnavi[$i_kat]->getName()}</a>
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
                                    <li class="rating-wrapper nav-it dpflex-a-center">
                                        <strong class="icon-wt">{lang key="rating" section="global"}:</strong>
                                        <a id="jump-to-votes-tab" class="hidden-print"{if $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen == 'N' || $isMobile} data-toggle="collapse" href="#tab-votes" role="button"{else} href="{$Artikel->cURLFull}#tab-votes" {/if}>
                                            {include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
                                        </a>
                                    </li>
                                    {/block}
                                {/if}
                                {block name="productdetails-info-manufacturer-wrapper"}
                                    {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller)}
                                    <li class="nav-it dpflex-a-center">
                                        {block name="product-info-manufacturer"}
                                            <strong class="block first icon-wt">{lang key='manufacturer' section='productDetails'}: </strong>
                                            {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
                                                <a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerSeo}{/if}" title="{$Artikel->cHersteller|escape:'html'}" class="dpflex-a-c">
                                            {else}
                                                <span class="dpflex-a-c">
                                            {/if}
                                                {if ($Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B' || $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'BT') && !empty($Artikel->cHerstellerBildURLKlein)}	
                                                <span class="img-ct icon icon-wt icon-xl contain">
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
                        <div class="col-md-4 col-lg-6">  
                            {block name="details-buy-actions-label-wrapper"}
                                {if !($Artikel->nIstVater && $Artikel->kVaterArtikel == 0)}
                                    {include file="productdetails/actions-labels.tpl"}
                                {/if}
                            {/block}
                        </div>
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
                        <input type="hidden" name="ek" value="{$smarty.get.ek|intval}" />
                    {/if}
                    <input type="hidden" id="AktuellerkArtikel" class="current_article" name="a" value="{$Artikel->kArtikel}" />
                    <input type="hidden" name="wke" value="1" />
                    <input type="hidden" name="show" value="1" />
                    <input type="hidden" name="kKundengruppe" value="{$smarty.session.Kundengruppe->getID()}" />
                    <input type="hidden" name="kSprache" value="{$smarty.session.kSprache}" />
                    {/block}
                    {block name="productdetails-info-variation"}
                    <!-- VARIATIONEN -->
                    {include file="productdetails/variation.tpl" simple=$Artikel->isSimpleVariation showMatrix=$showMatrix}
                    {/block}                   
                    {*UPLOADS product-specific files, e.g. for customization*}
                    {* block name='productdetails-details-include-uploads'}
                        {include file="snippets/uploads.tpl" tplscope='product'}
                    {/block *}
                
                    {* --- Staffelpreise? --- *}
                    {if !empty($Artikel->staffelPreis_arr)}
                    {block name="details-staffelpreise-wrapper"}
                        <div class="bulk-price">
                            {block name="detail-bulk-price"}
                            <table class="table table-condensed table-hover">
                                <thead>
                                    <tr>
                                        <th class="text-right">
                                            {lang key='fromDifferential' section='productOverview'}
                                        </th>
                                        <th class="text-right">{lang key='pricePerUnit' section='productDetails'}{if $Artikel->cEinheit} / {$Artikel->cEinheit}{/if}
                                            {if isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0 && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1) && isset($Artikel->cMassMenge)}
                                                ({$Artikel->cMassMenge} {$Artikel->cMasseinheitName})
                                            {/if}
                                        </th>
                                        {if !empty($Artikel->staffelPreis_arr[0].cBasePriceLocalized)}
                                            <th class="text-right">
                                                {lang key='basePrice'}
                                            </th>
                                        {/if}
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $Artikel->staffelPreis_arr as $bulkPrice}
                                        {if $bulkPrice.nAnzahl > 0}
                                            <tr class="bulk-price-{$bulkPrice.nAnzahl}">
                                                <td class="text-right">{$bulkPrice.nAnzahl}</td>
                                                <td class="text-right bulk-price">
                                                    {$bulkPrice.cPreisLocalized[$NettoPreise]} <span class="footnote-reference">*</span>
                                                </td>
                                                {if !empty($bulkPrice.cBasePriceLocalized)}
                                                    <td class="text-right bulk-base-price">
                                                        {$bulkPrice.cBasePriceLocalized[$NettoPreise]}
                                                    </td>
                                                {/if}
                                            </tr>
                                        {/if}
                                    {/foreach}
                                </tbody>
                            </table>
                            {/block}
                        </div>{* /bulk-price *}
                    {/block}
                    {/if}
                    {block name='productdetails-details-include-uploads'}
                        {include file="snippets/uploads.tpl" tplscope='product'}
                    {/block}
                    {block name="km-sonderpreis-bis"}
                        {if !empty($Artikel->dSonderpreisEnde_de) && $Artikel->dSonderpreisEnde_de|date_format:"%y%m%d" >= $smarty.now|date_format:"%y%m%d"  && $Artikel->dSonderpreisStart_de|date_format:"%y%m%d" <= $smarty.now|date_format:"%y%m%d"}
                            {if $snackyConfig.specialpriceDate == "C"}
                                {assign var="uid" value="art_c_{$Artikel->kArtikel}_{1|mt_rand:20}"}
                                <div id="{$uid}" class="sale-wp mb-sm mt-sm text-center panel">
                                    <div class="mb-xs h4">{lang key="sonderpreisBisDetail" section="custom"}</div>
                                    <div class="dpflex-j-c">
                                        <div class="ct-wp days">
                                            <div class="ct-it">0</div>
                                            <div class="ct-un">{lang key='days'}</div>
                                        </div>
                                        <div class="ct-wp hours">
                                            <div class="ct-it">0</div>
                                            <div class="ct-un">{lang key='hours'}</div>
                                        </div>
                                        <div class="ct-wp minutes">
                                            <div class="ct-it">0</div>
                                            <div class="ct-un">{lang key='minutes'}</div>
                                        </div>
                                        <div class="ct-wp seconds">
                                            <div class="ct-it">0</div>
                                            <div class="ct-un">{lang key='seconds'}</div>
                                        </div>
                                    </div>
                                </div>                
                                {inline_script}<script>
                                    $(() => {
                                        let until = new Date("{$Artikel->dSonderpreisEnde_de|date_format:"Y-m-d"}T23:59:59");
                                        let countDownDate = until.getTime();
                                        let timeout = setInterval(update, 1000);

                                        update();
                                        $(window).trigger('resize');

                                        function update()
                                        {
                                            let now      = new Date().getTime();
                                            let distance = countDownDate - now; 
                                            let days     = Math.floor(distance / (1000 * 60 * 60 * 24));
                                            let hours    = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                                            let minutes  = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                                            let seconds  = Math.floor((distance % (1000 * 60)) / 1000);

                                            if (distance <= 0) {
                                                clearInterval(timeout);
                                                days    = 0;
                                                hours   = 0;
                                                minutes = 0;
                                                seconds = 0;
                                                $("#{$uid}").hide();
                                                $(window).trigger('resize');
                                            }

                                            $("#{$uid} .days .ct-it").html(days);
                                            $("#{$uid} .hours .ct-it").html(hours);
                                            $("#{$uid} .minutes .ct-it").html(minutes);
                                            $("#{$uid} .seconds .ct-it").html(seconds);
                                        }
                                    });
                                </script>{/inline_script}
                            {elseif $snackyConfig.specialpriceDate == "D"}
                                <div class="mb-sm mt-sm panel text-center">
                                    <div class="h4 m0">
                                        {lang key="sonderpreisBisDetail" section="custom"} {$Artikel->dSonderpreisEnde_de|date_format:"{$snackyConfig.deliveryDateFormat}"}
                                    </div>
                                </div>
                            {/if}
                        {/if}
                    {/block}
                    {block name="km-verfuegbar-ab"}
                        {if $Artikel->nErscheinendesProdukt}
                            {if $snackyConfig.availableDate == "C"}
                                {assign var="uid" value="aval-ct"}
                                <div id="{$uid}" class="sale-wp mb-sm mt-sm text-center panel">
                                    <div class="mb-xs h4">{lang key="productAvailableIn" section="custom"}</div>
                                    <div class="dpflex-j-c">
                                        <div class="ct-wp days">
                                            <div class="ct-it">0</div>
                                            <div class="ct-un">{lang key='days'}</div>
                                        </div>
                                        <div class="ct-wp hours">
                                            <div class="ct-it">0</div>
                                            <div class="ct-un">{lang key='hours'}</div>
                                        </div>
                                        <div class="ct-wp minutes">
                                            <div class="ct-it">0</div>
                                            <div class="ct-un">{lang key='minutes'}</div>
                                        </div>
                                        <div class="ct-wp seconds">
                                            <div class="ct-it">0</div>
                                            <div class="ct-un">{lang key='seconds'}</div>
                                        </div>
                                    </div>
                                    {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar == 1}
                                        <div class="mt-xs text-muted">{lang key="preorderPossible" section="global"}</div>
                                    {/if}
                                </div>                
                                {inline_script}<script>
                                    $(() => {
                                        let until = new Date("{$Artikel->Erscheinungsdatum_de|date_format:"Y-m-d"}T00:00:00");
                                        let countDownDate = until.getTime();
                                        let timeout = setInterval(update, 1000);

                                        update();
                                        $(window).trigger('resize');

                                        function update()
                                        {
                                            let now      = new Date().getTime();
                                            let distance = countDownDate - now; 
                                            let days     = Math.floor(distance / (1000 * 60 * 60 * 24));
                                            let hours    = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                                            let minutes  = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                                            let seconds  = Math.floor((distance % (1000 * 60)) / 1000);

                                            if (distance <= 0) {
                                                clearInterval(timeout);
                                                days    = 0;
                                                hours   = 0;
                                                minutes = 0;
                                                seconds = 0;
                                                $("#{$uid}").hide();
                                                $(window).trigger('resize');
                                            }

                                            $("#{$uid} .days .ct-it").html(days);
                                            $("#{$uid} .hours .ct-it").html(hours);
                                            $("#{$uid} .minutes .ct-it").html(minutes);
                                            $("#{$uid} .seconds .ct-it").html(seconds);
                                        }
                                    });
                                </script>{/inline_script}
                            {elseif $snackyConfig.availableDate == "D"}
                                <div class="mb-sm mt-sm panel text-center">
                                    <div class="h4 m0">
                                        {lang key="productAvailableFrom" section="global"}: {$Artikel->Erscheinungsdatum_de}
                                    </div>
                                    {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar == 1}
                                        <div class="mt-xxs text-muted">{lang key="preorderPossible" section="global"}</div>
                                    {/if}
                                </div>
                            {/if}
                        {/if}
                    {/block}
                    {block name="details-buy-wrapper"}
                    <div class="buy-wrapper row dpflex-a-end">
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
                            {* Wenig Bestand *}
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
                                {*WARENKORB anzeigen wenn keine variationen mehr auf lager sind?!*}
                                {include file="productdetails/basket.tpl"}
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
                            <div class="add-pays text-center dpflex">
                                <div class="paypal"></div>
                                <div class="amazon"></div>
                            </div>
                            <div class="payplan"></div>
                        </div>
                    </div>           
                    {block name="details-buy-actions-wrapper"}
                        {if !($Artikel->nIstVater && $Artikel->kVaterArtikel == 0)}
                            <div class="hidden">
                                {include file="productdetails/actions.tpl"}
                            </div>
                        {/if}
                    {/block}
                    {/block}
                    {if isset($varKombiJSON) && $varKombiJSON!= ''}
                    <script id="varKombiArr" type="application/json">{$varKombiJSON}</script>
                    {/if}
                </div>
            {/block}{* productdetails-detail-info *}
            {/block}{* productdetails-info *}
			{include file="snippets/zonen.tpl" id="after_product_info" title="after_product_info"}
			
			
			{block name="details-matrix"}
			{include file="productdetails/matrix.tpl"}
			{/block}
        </div>{* /col *}
    </div>{* /row *}
</form>
{/block}
	{if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
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
{if !isset($smarty.get.quickView) || $smarty.get.quickView != 1}

    {block name="details-tabs"}
    	{include file="productdetails/tabs.tpl"}
    {/block}


    {*SLIDERS*}
    {if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|@count > 0
        || isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|@count > 0
        || isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0
        || isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0
        || isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
        
        {if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|@count > 0}
            <div class="partslist">
				<hr class="invisible">
                {lang key='listOfItems' section='global' assign='slidertitle'}
                {include file='productdetails/stueckliste.tpl' id='slider-partslist' productlist=$Artikel->oStueckliste_arr title=$slidertitle showPartsList=true}
            </div>
        {/if}

        {if isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen === 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|@count > 0}
            <div class="bundle">
                {include file="productdetails/bundle.tpl" ProductKey=$Artikel->kArtikel Products=$Artikel->oProduktBundle_arr ProduktBundle=$Artikel->oProduktBundlePrice ProductMain=$Artikel->oProduktBundleMain}
            </div>
        {/if}

        {if isset($Xselling->Standard) || isset($Xselling->Kauf) || isset($oAehnlicheArtikel_arr)}
            <div class="recommendations hidden-print">
                
            {block name="productdetails-recommendations"}
				{if isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0}
                    {foreach $Xselling->Standard->XSellGruppen as $Gruppe}
                        {include file='snippets/product_slider.tpl' class='x-supplies mb-lg' id='slider-xsell-group-'|cat:$Gruppe@iteration productlist=$Gruppe->Artikel title=$Gruppe->Name desc=$Gruppe->Beschreibung}
					{/foreach}
				{/if}

				{if isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0}
					{lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails' assign='slidertitle'}
					{include file='snippets/product_slider.tpl' class='x-sell mb-lg' id='slider-xsell' productlist=$Xselling->Kauf->Artikel title=$slidertitle}
				{/if}
                
                {if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
                    {lang key='RelatedProducts' section='productDetails' assign='slidertitle'}
                    {include file='snippets/product_slider.tpl' class='x-related mb-lg' id='slider-related' productlist=$oAehnlicheArtikel_arr title=$slidertitle}
                {/if}                
            {/block}
            </div>
        {/if}
    {/if}
    <div id="article_popups">
        {include file='productdetails/popups.tpl'}
    </div>
{/if}
{/block}