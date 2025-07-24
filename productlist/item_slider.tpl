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
                <a class="img-w block" href="{$Artikel->cURLFull}">
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
                <div class="caption">
                    <a href="{$Artikel->cURLFull}" class="title word-break block h4 m0">
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
                    {block name='item-slider-price'}
                        <div class="item-slider-price">
                            {include file="productdetails/price.tpl" Artikel=$Artikel price_image=null tplscope=$tplscope}
                        </div>
                    {/block}
                </div>
            {/block}
            {block name='item-slider-form'}
                <form action="{$ShopURL}/" method="post" class="buy_form_{$Artikel->kArtikel} form form-basket jtl-validate" data-toggle="basket-add{if $snackyConfig.liveBasketFromBasket == 'N' && $nSeitenTyp == 3}-direct{/if}">
                    {$jtl_token}
                    {block name="item-box-buyoptions"}                    
                        {if $snackyConfig.listShowCart != 1}                
                            {include file="productlist/item_buyoptions.tpl"}
                        {/if}
                    {/block}
                </form>
            {/block}
        </div>
    {/block}
{/block}