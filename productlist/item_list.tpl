{block name='productlist-item-list'}
{if $snackyConfig.variation_select_productlist === 'N' || $snackyConfig.hover_productlist !== 'Y'}
{assign var="hasOnlyListableVariations" value=0}
{else}
{hasOnlyListableVariations artikel=$Artikel maxVariationCount=$snackyConfig.variation_select_productlist maxWerteCount=$snackyConfig.variation_max_werte_productlist assign="hasOnlyListableVariations"}
{/if}
<div id="{$idPrefix|default:''}result-wrapper_buy_form_{$Artikel->kArtikel}" data-wrapper="true"
	class="p-c{if isset($listStyle) && $listStyle === 'gallery'} active{/if}{if isset($class)} {$class}{/if}">
    {block name="productlist-image"}
    <a class="img-w block" href="{$Artikel->cURLFull}">
        {if isset($Artikel->Bilder[0]->cAltAttribut)}
			{assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"html"}
        {else}
			{assign var="alt" value=$Artikel->cName}
        {/if}
        <div class="img-ct{if isset($Artikel->Bilder[1])} has-second{/if}{if $Einstellungen.bilder.container_verwenden == 'N'} contain{/if}">
            {$image = $Artikel->Bilder[0]}
			{image 
				alt=$alt 
				webp=true
				src="{$image->cURLKlein}"
				srcset="{$image->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
						 {$image->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
						 {$image->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w"
				sizes="auto"
				class="{if !$isMobile && !empty($Artikel->Bilder[1])} first{/if}"
				lazy=!$stopLazy
			}

            {if isset($Artikel->Bilder[1]) && !$isMobile}
            <div class="second-img">
                {$image2 = $Artikel->Bilder[1]}

                {image alt=$alt fluid=true webp=true lazy=true
                    src="{$image2->cURLKlein}"
                    srcset="{$image2->cURLMini} {$Einstellungen.bilder.bilder_artikel_mini_breite}w,
                             {$image2->cURLKlein} {$Einstellungen.bilder.bilder_artikel_klein_breite}w,
                             {$image2->cURLNormal} {$Einstellungen.bilder.bilder_artikel_normal_breite}w"
                    sizes="auto"
                    class="{if !$isMobile && !empty($Artikel->Bilder[1])} first{/if}"
                    fluid=true
                    lazy=true
                }
            </div>
            {/if}
            {block name='searchspecial-overlay'}
                {if isset($Artikel->oSuchspecialBild)}
                    {block name='productlist-item-box-include-ribbon'}
                        {include file='snippets/ribbon.tpl'}
                    {/block}
                {/if}
            {/block}
        </div>
    </a>
    {/block}
    {block name="list-info-wrapper"}
    <div class="row w100">
        {block name="list-left-wrapper"}
        <div class="col-12 col-sm-8 col-md-7 col-lg-7{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-8{/if} col-left">
            {block name='product-title'}
            <div class="title h4">
                <a href="{$Artikel->cURLFull}" class="block">{$Artikel->cName}</a>
            {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y'}
                <a href="{$Artikel->cURLFull}#tab-votes" class="hidden-print block">
                {include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}
                </a>
            {/if}
            {/block}
            </div>

            <div class="product-info hidden-xs">
                {block name='product-info'}
                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_kurzbeschreibung_anzeigen === 'Y' && $Artikel->cKurzBeschreibung}
                        <div class="shortdesc mb-xxs">
                            {$Artikel->cKurzBeschreibung|strip_tags|truncate:500:"...":true}
                        </div>
                    {/if}
                    <ul class="blanklist info hidden-xs">
                        <li class="attr-sku">
                            <strong>{lang key='productNo'}: </strong> <span>{$Artikel->cArtNr}</span>
                        </li>
                        {if !empty($Artikel->cBarcode)
                            && ($Einstellungen.artikeldetails.gtin_display === 'lists'
                                || $Einstellungen.artikeldetails.gtin_display === 'always')}
                            <li>
                                <strong>{lang key='ean'}: </strong> <span>{$Artikel->cBarcode}</span>
                            </li>
                        {/if}
                        {if !empty($Artikel->cISBN)
                            && ($Einstellungen.artikeldetails.isbn_display === 'L'
                                || $Einstellungen.artikeldetails.isbn_display === 'DL')}
                            <li>
                                <strong>{lang key='isbn'}: </strong> <span>{$Artikel->cISBN}</span>
                            </li>
                        {/if}
                        {if !empty($Artikel->cUNNummer) && !empty($Artikel->cGefahrnr)
                            && ($Einstellungen.artikeldetails.adr_hazard_display === 'L'
                                || $Einstellungen.artikeldetails.adr_hazard_display === 'DL')}
                            <li>
                                <strong>{lang key='adrHazardSign'}: </strong>
                                <ul class="value blanklist">
                                    <li>{$Artikel->cGefahrnr}</li>
                                    <li>{$Artikel->cUNNummer}</li>
                                </ul>
                            </li>
                        {/if}
                        {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                            <li class="attr-best-before" title="{lang key='productMHDTool'}">
                                <strong>{lang key='productMHD'}: </strong> <span>{$Artikel->dMHD_de}</span>
                            </li>
                        {/if}
                        {if $Einstellungen.artikeluebersicht.artikeluebersicht_gewicht_anzeigen === 'Y' && isset($Artikel->cGewicht) && $Artikel->fGewicht > 0}
                            <li class="attr-weight">
                                <strong>{lang key='shippingWeight'}: </strong> <span>{$Artikel->cGewicht} {lang key='weightUnit'}</span>
                            </li>
                        {/if}
                        {if $Einstellungen.artikeluebersicht.artikeluebersicht_artikelgewicht_anzeigen === 'Y' && isset($Artikel->cArtikelgewicht) && $Artikel->fArtikelgewicht > 0}
                            <li class="attr-weight weight-unit-article hidden-sm">
                                <strong>{lang key='productWeight'}: </strong> <span>{$Artikel->cArtikelgewicht} {lang key='weightUnit'}</span>
                            </li>
                        {/if}
                        {if $Einstellungen.artikeluebersicht.artikeluebersicht_artikelintervall_anzeigen === 'Y' && $Artikel->fAbnahmeintervall > 0}
                            <li class="attr-quantity-scale">
                                <strong>{lang key='purchaseIntervall' section='productOverview'}: </strong> <span class="value">{$Artikel->fAbnahmeintervall} {$Artikel->cEinheit}</span>
                            </li>
                        {/if}
                        {if count($Artikel->Variationen) > 0}
                            <li class="attr-variations">
                                <strong>{lang key='variationsIn' section='productOverview'}: </strong>
                                <span class="value-group">{foreach $Artikel->Variationen as $variation}{if !$variation@first}, {/if}
                                <span class="value">{$variation->cName}</span>{/foreach}</span>
                            </li>
                        {/if}
                        
                        {block name='product-manufacturer'}
                            {if $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen !== 'N' && !empty($Artikel->cHersteller)}
                                <li class="hidden-xs dpflex-a-c">
                                    <strong class="mr-xxs">{lang key='manufacturerSingle' section='productOverview'}: </strong>
                                    <a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerSeo}{/if}" class="dpflex-wrap dpflex-a-c">
                                    {if ($Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'BT'
                                        || $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'B')
                                        && !empty($Artikel->cHerstellerBildKlein)}
                                            <span class="img-ct icon icon-xl icon-wt contain">
                                                {image webp=true lazy=true fluid=true
                                                    src=$Artikel->cHerstellerBildURLKlein
                                                    srcset="{$Artikel->cHerstellerBildURLKlein} {$Einstellungen.bilder.bilder_hersteller_mini_breite}w,
                                                            {$Artikel->cHerstellerBildURLNormal} {$Einstellungen.bilder.bilder_hersteller_normal_breite}w"
                                                    alt=$Artikel->cHersteller
                                                    sizes="25px"
                                                    class="img-xs"}
                                            </span>
                                    {/if}
                                    {if ($Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'BT'
                                        || $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'Y')
                                        && !empty($Artikel->cHersteller)}
                                        <span>{$Artikel->cHersteller}</span>
                                    {/if}
                                    </a>
                                </li>
                            {/if}
                        {/block}
                    </ul>
                {/block}
            </div>
        </div>
        {/block}
    {block name="list-right-wrapper"}
    <div class="col-12 col-sm-4 col-md-5 col-lg-5{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-4{/if} text-right col-right">
    <form id="{$idPrefix|default:''}buy_form_{$Artikel->kArtikel}" action="{$ShopURL}/" method="post" class="form form-basket jtl-validate right" data-toggle="basket-add">
    {include file="productdetails/price.tpl" Artikel=$Artikel tplscope=$tplscope}
        {$jtl_token}
        {block name="productlist-delivery-status"}
        <div class="delivery-status">
            {assign var=anzeige value=$Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandsanzeige}
			{if $Artikel->inWarenkorbLegbar === $smarty.const.INWKNICHTLEGBAR_UNVERKAEUFLICH}
				<div class="status">
					<small>{lang key='productUnsaleable' section='productDetails'}</small>
				</div>
			{elseif $Artikel->nErscheinendesProdukt}
				<div class="availablefrom">
					<small>{lang key="productAvailableFrom"}: {$Artikel->Erscheinungsdatum_de}</small>
				</div>
				{if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar === 1}
					<div class="attr attr-preorder"><small class="value">{lang key="preorderPossible" section="global"}</small></div>
				{/if}
			{elseif $anzeige !== 'nichts'
				&& $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen !== 'N'
				&& $Artikel->getBackorderString() !== ''
				&& ($Artikel->cLagerKleinerNull === 'N' || $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen === 'U')}
				<div class="signal_image status-1"><small>{$Artikel->getBackorderString()}</small></div>
			{elseif $anzeige !== 'nichts'
				&& $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen !== 'N'
				&& $Artikel->cLagerBeachten === 'Y'
				&& $Artikel->fLagerbestand <= 0
				&& $Artikel->fLieferantenlagerbestand > 0
				&& $Artikel->fLieferzeit > 0
				&& ($Artikel->cLagerKleinerNull === 'N' || $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen === 'U')}
				<div class="signal_image status-1"><small>{lang key='supplierStockNotice' printf=$Artikel->fLieferzeit}</small></div>
			{elseif $anzeige === 'verfuegbarkeit' || $anzeige === 'genau'}
				<div class="signal_image status-{$Artikel->Lageranzeige->nStatus} small">{$Artikel->Lageranzeige->cLagerhinweis[$anzeige]}</div>
			{elseif $anzeige === 'ampel'}
				<div class="signal_image status-{$Artikel->Lageranzeige->nStatus} small">{$Artikel->Lageranzeige->AmpelText}</div>
			{/if}
			{if $Artikel->cEstimatedDelivery}
				<div class="estimated_delivery hidden-xs small">{lang key="shippingTime"}: {$Artikel->cEstimatedDelivery}</div>
			{/if}
        </div>
        {/block}
        <div class="exp">
            {block name="form-expandable"}
            {block name="productlist-add-basket"}
            {if ($Artikel->inWarenkorbLegbar === 1 || ($Artikel->nErscheinendesProdukt === 1 && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y')) &&
            (($Artikel->nIstVater === 0 && $Artikel->Variationen|@count === 0)) && !$Artikel->bHasKonfig}
            {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
            {else}                
                <div class="{if $snackyConfig.listShowAmountCart == 2 && $snackyConfig.quantityButtons != 1}input-group input-group-sm {/if}small mt-xxs">
                    {if $snackyConfig.quantityButtons == 1 && $snackyConfig.listShowAmountCart == 2}
                    <div class="btn-group qty-btns w100 m0">
                        <div class="btn btn-blank qty-sub">
                            <span class="img-ct icon">
                                <svg>
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-minus"></use>
                                </svg>
                            </span>
                        </div>
                    {/if}
				    <input type="{if $Artikel->cTeilbar === 'Y' && $Artikel->fAbnahmeintervall == 0}text{else}number{/if}"
					min="{if $Artikel->fMindestbestellmenge}{$Artikel->fMindestbestellmenge}{else}0{/if}"
					max="{$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''}"
					{if $Artikel->fAbnahmeintervall > 0}step="{$Artikel->fAbnahmeintervall}"{/if}
					size="2"
					id="quantity{$Artikel->kArtikel}"
					class="quantity form-control{if $snackyConfig.quantityButtons == 1 && $snackyConfig.listShowAmountCart == 2} text-center{else} text-right{/if}{if $snackyConfig.listShowAmountCart == 1} hidden{/if}"
					name="anzahl"
					autocomplete="off"
					value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}{$snackyConfig.listAmountCart}{/if}">
                    {if $snackyConfig.quantityButtons == 1 && $snackyConfig.listShowAmountCart == 2}
                        <div class="btn btn-blank qty-add">
                            <span class="img-ct icon">
                                <svg>
                                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-plus"></use>
                                </svg>
                            </span>
                        </div>
                    </div>
                    <hr class="hr-xxs invisible">
                    {/if}
                    {if $snackyConfig.listShowAmountCart == 2 && $snackyConfig.quantityButtons != 1}
                    <span class="input-group-btn">
                    {/if}
                        <button type="submit" class="btn btn-primary sn-addBasket btn-block" id="submit{$Artikel->kArtikel}" title="{lang key="addToCart" section="global"}">
                            {if $snackyConfig.listShowAmountCart == 2 && $snackyConfig.quantityButtons != 1}
                                <span class="img-ct icon ic-w">
                                    <svg>
                                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
                                    </svg>
                                </span>
                            {else}
                            <span class="visible-xs">
                                <span class="img-ct icon ic-w mauto">
                                    <svg>
                                        <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
                                    </svg>
                                </span>
                            </span>
                            <span class="hidden-xs">{lang key="addToCart" section="global"}</span>
                            {/if}
                        </button>
                    {if $snackyConfig.listShowAmountCart == 2 && $snackyConfig.quantityButtons != 1}
                    </span>
                    {/if}
                </div>
            {/if}
            {else}
                <div class="top7 form-group">
                    <a class="btn btn-default btn-md btn-block" role="button" href="{$Artikel->cURLFull}">{lang key="details"}</a>
                </div>
            {/if}
            {/block}

            {if $Artikel->kArtikelVariKombi > 0}
            <input type="hidden" name="aK" value="{$Artikel->kArtikelVariKombi}" />
            {/if} 	
            {if isset($Artikel->kVariKindArtikel)}
            <input type="hidden" name="VariKindArtikel" value="{$Artikel->kVariKindArtikel}" />
            {/if}
            <input type="hidden" name="a" value="{$Artikel->kArtikel}" />
            <input type="hidden" name="wke" value="1" />
            <input type="hidden" name="overview" value="1" />
            <input type="hidden" name="Sortierung" value="{if !empty($Suchergebnisse->Sortierung)}{$Suchergebnisse->Sortierung}{/if}" />
			
            {if $Suchergebnisse->getPages()->getCurrentPage() > 1}
                <input type="hidden" name="seite" value="{$Suchergebnisse->getPages()->getCurrentPage()}" />
            {/if}
            {if $NaviFilter->hasCategory()}
                <input type="hidden" name="k" value="{$NaviFilter->getCategory()->getValue()}" />
            {/if}
            {if $NaviFilter->hasManufacturer()}
                <input type="hidden" name="h" value="{$NaviFilter->getManufacturer()->getValue()}" />
            {/if}
            {if $NaviFilter->hasSearchQuery()}
                <input type="hidden" name="l" value="{$NaviFilter->getSearchQuery()->getValue()}" />
            {/if}
            {if $NaviFilter->hasCharacteristicValue()}
                <input type="hidden" name="m" value="{$NaviFilter->getCharacteristicValue()->getValue()}" />
            {/if}
            {if $NaviFilter->hasCategoryFilter()}
                {assign var=cfv value=$NaviFilter->getCategoryFilter()->getValue()}
                {if is_array($cfv)}
                    {foreach $cfv as $val}
                        <input type="hidden" name="hf" value="{$val}" />
                    {/foreach}
                {else}
                    <input type="hidden" name="kf" value="{$cfv}" />
                {/if}
            {/if}
            {if $NaviFilter->hasManufacturerFilter()}
                {assign var=mfv value=$NaviFilter->getManufacturerFilter()->getValue()}
                {if is_array($mfv)}
                    {foreach $mfv as $val}
                        <input type="hidden" name="hf" value="{$val}" />
                    {/foreach}
                {else}
                    <input type="hidden" name="hf" value="{$mfv}" />
                {/if}
            {/if}
            {foreach $NaviFilter->getCharacteristicFilter() as $filter}
                <input type="hidden" name="mf{$filter@iteration}" value="{$filter->getValue()}" />
            {/foreach}
            {/block}
        </div>
    </form>
    </div>
        {/block}
    </div>
        {/block}
</div>
{/block}
