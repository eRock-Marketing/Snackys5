{block name='productlist-item-box'}
    {block name='item-box-assigns'}
        {if $snackyConfig.variation_select_productlist === 'N' || $snackyConfig.hover_productlist !== 'Y'}
            {assign var="hasOnlyListableVariations" value=0}
        {else}
            {hasOnlyListableVariations artikel=$Artikel maxVariationCount=$snackyConfig.variation_select_productlist maxWerteCount=$snackyConfig.variation_max_werte_productlist assign="hasOnlyListableVariations"}
        {/if}
    {/block}
    {block name='item-box-wrapper'}
        <div id="{$idPrefix|default:''}result-wrapper_buy_form_{$Artikel->kArtikel}" data-wrapper="true"
	        class="p-c {if $snackyConfig.hover_productlist === 'Y' && !$isMobile} hv-e{/if}{if isset($listStyle) && $listStyle === 'gallery'} active{/if}{if isset($class)} {$class}{/if}">
            {block name="productlist-image"}
                <a class="img-w block" href="{$Artikel->cURLFull}">
                    {block name="productlist-image-assigns"}
                        {if isset($Artikel->Bilder[0]->cAltAttribut)}
                            {assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"quotes"}
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
                                srcset="{$image->cURLMini} {$image->imageSizes->xs->size->width}w,
                                        {$image->cURLKlein} {$image->imageSizes->sm->size->width}w,
                                        {$image->cURLNormal} {$image->imageSizes->md->size->width}w"
                                sizes="{if $stopLazy}{if $isMobile}{$image->imageSizes->sm->size->width}{else}{$image->imageSizes->md->size->width}{/if}px{else}auto{/if}"
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
                                                    {$image2->cURLNormal} {$image->imageSizes->md->size->width}w"
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
            {block name="productlist-image-caption"}
                <div class="caption">
                    <a href="{$Artikel->cURLFull}" class="title block h4 m0">{$Artikel->cKurzbezeichnung}</a>
                    {block name="productlist-caption-rating"}
                        {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}
                            <a href="{$Artikel->cURLFull}#tab-votes" class="hidden-print block">
			                    {include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}
                            </a>
                        {/if}
                    {/block}
                    {block name="productlist-caption-price"}
                        <div>
                            {include file="productdetails/price.tpl" Artikel=$Artikel tplscope=$tplscope}
                        </div>
                    {/block}
                </div>
            {/block}
            {block name="item-box-form"}
                <form id="{$idPrefix|default:''}buy_form_{$Artikel->kArtikel}" action="{$ShopURL}/" method="post" class="form form-basket jtl-validate" data-toggle="basket-add">
                    {$jtl_token}
                    {block name="productlist-delivery-status"}
                        {include file="productlist/item_delivery_status.tpl"} 
                    {/block}
                    {if $snackyConfig.hover_productlist === 'Y' && !$isMobile}
                        {block name="item-box-hoverinfos"}
                            {include file="productlist/item_hoverinfos.tpl"}
                        {/block}                        
                    {elseif $snackyConfig.listShowCart != 1}
                        {block name="item-box-buyoptions"}
                            {include file="productlist/item_buyoptions.tpl"}
                        {/block}
                    {/if}
                </form>
            {/block}
        </div>
    {/block}
{/block}