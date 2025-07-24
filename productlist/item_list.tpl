{block name='productlist-item-list'}
    {block name='item-list-assigns'}
        {if $snackyConfig.variation_select_productlist === 'N' || $snackyConfig.hover_productlist !== 'Y'}
            {assign var="hasOnlyListableVariations" value=0}
        {else}
            {hasOnlyListableVariations artikel=$Artikel maxVariationCount=$snackyConfig.variation_select_productlist maxWerteCount=$snackyConfig.variation_max_werte_productlist assign="hasOnlyListableVariations"}
        {/if}
    {/block}
    {block name='item-list-wrapper'}
        <div id="{$idPrefix|default:''}result-wrapper_buy_form_{$Artikel->kArtikel}" data-wrapper="true" class="p-c{if isset($listStyle) && $listStyle === 'gallery'} active{/if}{if isset($class)} {$class}{/if}">
            {block name="productlist-image"}
                <a class="img-w block" href="{$Artikel->cURLFull}">
                    {block name="productlist-image-assigns"}
                        {if isset($Artikel->Bilder[0]->cAltAttribut)}
                            {assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"html"}
                        {else}
                            {assign var="alt" value=$Artikel->cName}
                        {/if}
                    {/block}
                    {block name="productlist-image-inside"}
                        <div class="img-ct{if isset($Artikel->Bilder[1])} has-second{/if}{if $Einstellungen.bilder.container_verwenden == 'N'} contain{/if}">
                            {$image = $Artikel->Bilder[0]}
                            {image 
                                alt=$alt 
                                webp=true
                                src="{$image->cURLKlein}"
                                srcset="
                                    {$image->cURLMini} {$image->imageSizes->xs->size->width}w,
                                    {$image->cURLKlein} {$image->imageSizes->sm->size->width}w,
                                    {$image->cURLNormal} {$image->imageSizes->md->size->width}w"
                                sizes="{if $stopLazy}{$Einstellungen.bilder.bilder_artikel_klein_breite}px{else}auto{/if}"
                                class="{if !$isMobile && !empty($Artikel->Bilder[1])} first{/if}"
                                lazy=!$stopLazy
                            }
                            {block name="productlist-image-second"}
                                {if isset($Artikel->Bilder[1]) && !$isMobile}
                                    <div class="second-img">
                                        {$image2 = $Artikel->Bilder[1]}
                                        {image alt=$alt fluid=true webp=true lazy=true
                                            src="{$image2->cURLKlein}"
                                            srcset="{$image2->cURLMini} {$image2->imageSizes->xs->size->width}w,
                                                    {$image2->cURLKlein} {$image2->imageSizes->sm->size->width}w,
                                                    {$image2->cURLNormal} {$image2->imageSizes->md->size->width}w"
                                            sizes="auto"
                                            class="{if !$isMobile && !empty($Artikel->Bilder[1])} first{/if}"
                                            fluid=true
                                            lazy=true
                                        }
                                    </div>
                                {/if}
                            {/block}
                            {block name='searchspecial-overlay'}
                                {if isset($Artikel->oSuchspecialBild)}
                                    {block name='productlist-item-box-include-ribbon'}
                                        {include file='snippets/ribbon.tpl'}
                                    {/block}
                                {/if}
                            {/block}
                        </div>
                    {/block}
                </a>
            {/block}
            {block name="list-info-wrapper"}
                <div class="row w100">
                    {block name="list-left-wrapper"}
                        <div class="col-12 col-sm-8 col-md-7 col-lg-7{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-8{/if} col-left">
                            {block name='product-title'}
                                <div class="title h4">
                                    {block name='product-title-name'}
                                        <a href="{$Artikel->cURLFull}" class="block">{$Artikel->cName}</a>
                                    {/block}
                                    {block name='product-title-rating'}
                                        {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y'}
                                            <a href="{$Artikel->cURLFull}#tab-votes" class="hidden-print block">
                                                {include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}
                                            </a>
                                        {/if}
                                    {/block}
                                </div>
                            {/block}
                            {block name='product-info-wrapper'}
                                <div class="product-info hidden-xs">
                                    {block name='product-info'}
                                        {block name='product-info-shortdesc'}
                                            {if $Einstellungen.artikeluebersicht.artikeluebersicht_kurzbeschreibung_anzeigen === 'Y' && $Artikel->cKurzBeschreibung}
                                                <div class="shortdesc mb-xxs">
                                                    {$Artikel->cKurzBeschreibung|strip_tags|truncate:500:"...":true}
                                                </div>
                                            {/if}
                                        {/block}
                                        {block name='product-info-infos'}
                                            <ul class="blanklist info hidden-xs">
                                                {block name='product-info-infos-sku'}
                                                    <li class="attr-sku">
                                                        <strong>{lang key='productNo'}: </strong> <span>{$Artikel->cArtNr}</span>
                                                    </li>
                                                {/block}
                                                {block name='product-info-infos-barcode'}
                                                    {if !empty($Artikel->cBarcode)
                                                        && ($Einstellungen.artikeldetails.gtin_display === 'lists'
                                                            || $Einstellungen.artikeldetails.gtin_display === 'always')}
                                                        <li>
                                                            <strong>{lang key='ean'}: </strong> <span>{$Artikel->cBarcode}</span>
                                                        </li>
                                                    {/if}
                                                {/block}
                                                {block name='product-info-infos-isbn'}
                                                    {if !empty($Artikel->cISBN) && ($Einstellungen.artikeldetails.isbn_display === 'L' || $Einstellungen.artikeldetails.isbn_display === 'DL')}
                                                        <li>
                                                            <strong>{lang key='isbn'}: </strong> <span>{$Artikel->cISBN}</span>
                                                        </li>
                                                    {/if}
                                                {/block}
                                                {block name='product-info-infos-unnumber'}
                                                    {if !empty($Artikel->cUNNummer) && !empty($Artikel->cGefahrnr) && ($Einstellungen.artikeldetails.adr_hazard_display === 'L' || $Einstellungen.artikeldetails.adr_hazard_display === 'DL')}
                                                        <li>
                                                            <strong>{lang key='adrHazardSign'}: </strong>
                                                            <ul class="value blanklist">
                                                                <li>{$Artikel->cGefahrnr}</li>
                                                                <li>{$Artikel->cUNNummer}</li>
                                                            </ul>
                                                        </li>
                                                    {/if}
                                                {/block}
                                                {block name='product-info-infos-mhd'}
                                                    {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                                                        <li class="attr-best-before" title="{lang key='productMHDTool'}">
                                                            <strong>{lang key='productMHD'}: </strong> <span>{$Artikel->dMHD_de}</span>
                                                        </li>
                                                    {/if}
                                                {/block}
                                                {block name='product-info-infos-weight'}
                                                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_gewicht_anzeigen === 'Y' && isset($Artikel->cGewicht) && $Artikel->fGewicht > 0}
                                                        <li class="attr-weight">
                                                            <strong>{lang key='shippingWeight'}: </strong> <span>{$Artikel->cGewicht} {lang key='weightUnit'}</span>
                                                        </li>
                                                    {/if}
                                                {/block}
                                                {block name='product-info-infos-weight-unit'}
                                                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_artikelgewicht_anzeigen === 'Y' && isset($Artikel->cArtikelgewicht) && $Artikel->fArtikelgewicht > 0}
                                                        <li class="attr-weight weight-unit-article hidden-sm">
                                                            <strong>{lang key='productWeight'}: </strong> <span>{$Artikel->cArtikelgewicht} {lang key='weightUnit'}</span>
                                                        </li>
                                                    {/if}
                                                {/block}
                                                {block name='product-info-infos-quantity-scale'}
                                                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_artikelintervall_anzeigen === 'Y' && $Artikel->fAbnahmeintervall > 0}
                                                        <li class="attr-quantity-scale">
                                                            <strong>{lang key='purchaseIntervall' section='productOverview'}: </strong> <span class="value">{$Artikel->fAbnahmeintervall} {$Artikel->cEinheit}</span>
                                                        </li>
                                                    {/if}
                                                {/block}
                                                {block name='product-info-infos-variations'}
                                                    {if count($Artikel->Variationen) > 0}
                                                        <li class="attr-variations">
                                                            <strong>{lang key='variationsIn' section='productOverview'}: </strong>
                                                            <span class="value-group">{foreach $Artikel->Variationen as $variation}{if !$variation@first}, {/if}
                                                            <span class="value">{$variation->cName}</span>{/foreach}</span>
                                                        </li>
                                                    {/if}
                                                {/block}                        
                                                {block name='product-manufacturer'}
                                                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen !== 'N' && !empty($Artikel->cHersteller)}
                                                        <li class="hidden-xs flx-ac">
                                                            <strong class="mr-xxs">{lang key='manufacturerSingle' section='productOverview'}: </strong>
                                                            <a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerSeo}{/if}" class="flx-w flx-ac">
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
                                    {/block}
                                </div>
                            {/block}
                        </div>
                    {/block}
                    {block name="list-right-wrapper"}
                        <div class="col-12 col-sm-4 col-md-5 col-lg-5{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-4{/if} text-right col-right">
                            <form id="{$idPrefix|default:''}buy_form_{$Artikel->kArtikel}" action="{$ShopURL}/" method="post" class="form form-basket jtl-validate right" data-toggle="basket-add">
                                {block name='product-price'}
                                    {include file="productdetails/price.tpl" Artikel=$Artikel tplscope=$tplscope}
                                {/block}
                                {$jtl_token}
                                {block name="productlist-delivery-status"}
                                    {include file="productlist/item_delivery_status.tpl" showEstimated=true} 
                                {/block}
                                {block name="item-box-buyoptions"}
                                    {include file="productlist/item_buyoptions.tpl" listStyle=true}
                                {/block}
                            </form>
                        </div>
                    {/block}
                </div>
            {/block}
        </div>
    {/block}
{/block}