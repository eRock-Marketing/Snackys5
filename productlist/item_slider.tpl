{block name='productlist-item-slider'}
    {block name='item-slider-assigns'}
        {if $snackyConfig.variation_select_productlist === 'N' || $snackyConfig.hover_productlist !== 'Y'}
            {assign var="hasOnlyListableVariations" value=0}
        {else}
            {hasOnlyListableVariations artikel=$Artikel maxVariationCount=$snackyConfig.variation_select_productlist maxWerteCount=$snackyConfig.variation_max_werte_productlist assign="hasOnlyListableVariations"}
        {/if}
    {/block}
    {block name='item-slider-wrapper'}
        <div class="p-c {if isset($class)} {$class}{/if} thumbnail pr">
            {block name='item-slider-image'}
                <a href="{$Artikel->cURLFull}" class="img-w" aria-hidden="true" tabindex="-1">
                    {block name='item-slider-image-assigns'}
                        {if isset($Artikel->Bilder[0]->cAltAttribut)}
                            {assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|truncate:60}
                        {else}
                            {assign var="alt" value=$Artikel->cName}
                        {/if}
                    {/block}
                    {block name='item-slider-image-inside'}
                        <div class="img-ct{if isset($Artikel->Bilder[1])} has-second{/if}{if $Einstellungen.bilder.container_verwenden == 'N'} contain{/if}">
                            {$image = $Artikel->Bilder[0]}            
                            {image 
                                alt=$alt 
                                webp=true
                                src="{$image->cURLKlein}"
                                srcset="{$image->cURLMini} {$image->imageSizes->xs->size->width}w,
                                        {$image->cURLKlein} {$image->imageSizes->sm->size->width}w,
                                        {$image->cURLNormal} {$image->imageSizes->md->size->width}w"
                                sizes="auto"
                                class="{if !$isMobile && !empty($Artikel->Bilder[1])} first{/if}"
                                lazy=true
                            }
                            {block name='item-slider-image-second'}
                                {if isset($Artikel->Bilder[1]) && !$isMobile}
                                    <div class="second-img">
                                        {$image2 = $Artikel->Bilder[1]}
                                        {if isset($Artikel->Bilder[1]->cAltAttribut)}
                                            {assign var="alt2" value=$Artikel->Bilder[1]->cAltAttribut|truncate:60}
                                        {else}
                                            {assign var="alt2" value=$Artikel->cName}
                                        {/if}
                                        {image alt=$alt2 fluid=true webp=true lazy=true
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
                        </div>
                    {/block}
                    {block name='searchspecial-overlay'}
                        {if isset($Artikel->oSuchspecialBild)}
                            {block name='productlist-item-box-include-ribbon'}
                                {include file='snippets/ribbon.tpl'}
                            {/block}
                        {/if}
                    {/block}
                </a>
            {/block}
            {block name='item-slider-caption'}
                {if empty($noCaptionSlider)}
                    <div class="caption">                                                       
                        {block name='product-manufacturer'}
                            {if $snackyConfig.show_manufacturer == 'Y' && !empty($Artikel->cHersteller)}
                                <a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerSeo}{/if}" class="mb-xxxs block title h6">
                                    {$Artikel->cHersteller}
                                </a>
                            {/if}
                        {/block}
                        <a href="{$Artikel->cURLFull}" class="title word-break h4 mb-xxxs block">
                            {block name='item-slider-caption-partlist'}
                                {if isset($showPartsList) && $showPartsList === true && isset($Artikel->fAnzahl_stueckliste)}
                                    <span class="article-bundle-info">
                                        <span class="bundle-amount">{$Artikel->fAnzahl_stueckliste}</span> <span class="bundle-times">x</span>
                                    </span>
                                {/if}
                            {/block}
                            {block name='item-slider-name'}
                                {$Artikel->cKurzbezeichnung}
                            {/block}
                        </a>
                        {block name="productlist-caption-shortdesc"}
                            {if $snackyConfig.show_shortdesc == 'Y' && !empty($Artikel->cKurzBeschreibung)}
                                <div class="small mt-xxs mb-xxs">
                                    {$Artikel->cKurzBeschreibung}
                                </div>
                            {/if}
                        {/block}
                        {block name='item-slider-price'}
                            <div class="item-slider-price">
                                {include file="productdetails/price.tpl" Artikel=$Artikel price_image=null tplscope=$tplscope}
                            </div>
                        {/block}
                        {block name="productlist-caption-gpsr-link"}
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
                            {if $snackyConfig.show_gpsr_link == 'Y' && isset($hasGPSR) && $hasGPSR}
                                <a href="#" data-toggle="modal" data-target="#gpsr-popup_{$Artikel->kArtikel}" title="{lang key='gpsrHeadline' section='custom'}" class="small block mb-xxs mt-xxs"><i class="info"></i>{lang key='gpsrLink' section='custom'}</a>
                                <div class="modal modal-dialog blanklist" tabindex="-1" id="gpsr-popup_{$Artikel->kArtikel}">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <span class="modal-title block h5">
                                                {lang key='gpsrHeadline' section='custom'}
                                            </span>
                                            <button type="button" class="close-btn" data-dismiss="modal" aria-label="{lang key='close' section='account data'}">
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            {include file="snippets/gpsr.tpl" hideTitle=true Artikel=$Artikel}
                                        </div>
                                    </div>
                                </div>
                            {/if}
                        {/block}
                    </div>
                {/if}
            {/block}
            {block name='item-slider-form'}
                {if empty($noCaptionSlider)}
                    <form action="{$ShopURL}/" method="post" class="buy_form_{$Artikel->kArtikel} form form-basket jtl-validate" data-toggle="basket-add{if $snackyConfig.liveBasketFromBasket == 'N' && $nSeitenTyp == 3}-direct{/if}">
                        {$jtl_token}
                        {block name="item-box-buyoptions"}                    
                            {if $snackyConfig.listShowCart != 1}                
                                {include file="productlist/item_buyoptions.tpl"}
                            {/if}
                        {/block}
                    </form>
                {/if}
            {/block}
        </div>
    {/block}
{/block}