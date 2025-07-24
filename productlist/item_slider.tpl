{block name='productlist-item-slider'}
{if $snackyConfig.variation_select_productlist === 'N' || $snackyConfig.hover_productlist !== 'Y'}
{assign var="hasOnlyListableVariations" value=0}
{else}
{hasOnlyListableVariations artikel=$Artikel maxVariationCount=$snackyConfig.variation_select_productlist maxWerteCount=$snackyConfig.variation_max_werte_productlist assign="hasOnlyListableVariations"}
{/if}
<div class="p-c {if isset($class)} {$class}{/if} thumbnail pr">
    <a class="img-w block" href="{$Artikel->cURLFull}">
        {if isset($Artikel->Bilder[0]->cAltAttribut)}
			{assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|truncate:60}
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
                lazy=true
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
        </div>
		{block name='searchspecial-overlay'}
			{if isset($Artikel->oSuchspecialBild)}
                {block name='productlist-item-box-include-ribbon'}
                    {include file='snippets/ribbon.tpl'}
                {/block}
            {/if}
		{/block}
    </a>
    <div class="caption">
        <a href="{$Artikel->cURLFull}" class="title word-break block h4 m0">
            {if isset($showPartsList) && $showPartsList === true && isset($Artikel->fAnzahl_stueckliste)}
                <span class="article-bundle-info">
                    <span class="bundle-amount">{$Artikel->fAnzahl_stueckliste}</span> <span class="bundle-times">x</span>
                </span>
            {/if}
            {$Artikel->cKurzbezeichnung}
        </a>
        {* if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}<small>{include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}</small>{/if *}
        <div class="item-slider-price">
            {include file="productdetails/price.tpl" Artikel=$Artikel price_image=null tplscope=$tplscope}
        </div>
    </div>
	<form action="{$ShopURL}/" method="post" class="buy_form_{$Artikel->kArtikel} form form-basket jtl-validate" data-toggle="basket-add{if $snackyConfig.liveBasketFromBasket == 'N' && $nSeitenTyp == 3}-direct{/if}">
        {$jtl_token}
		{if $snackyConfig.listShowCart != 1}
        <div class="exp{if $snackyConfig.listShowCart == 2} flo-bt pr{/if} hide-qty">
            {block name="form-expandable"}
            <div>
                {block name="productlist-add-basket"}
                {if ($Artikel->inWarenkorbLegbar === 1 || ($Artikel->nErscheinendesProdukt === 1 && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y')) &&
                    (($Artikel->nIstVater === 0 && $Artikel->Variationen|@count === 0) || $hasOnlyListableVariations === 1) && !$Artikel->bHasKonfig && !($Artikel->kVaterArtikel > 0 || $Artikel->kArtikel|hasVariations)
                }
                    <div class="quantity-wrapper">
                        {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
                        {else}
                        <input type="{if $Artikel->cTeilbar === 'Y' && $Artikel->fAbnahmeintervall == 0}text{else}number{/if}"
                            min="{if $Artikel->fMindestbestellmenge}{$Artikel->fMindestbestellmenge}{else}0{/if}"
                            max="{$Artikel->FunktionsAttribute[$smarty.const.FKT_ATTRIBUT_MAXBESTELLMENGE]|default:''}"
                            {if $Artikel->fAbnahmeintervall > 0}step="{$Artikel->fAbnahmeintervall}"{/if}
                            size="2"
                            class="quantity form-control text-right"
                            name="anzahl""
                            autocomplete="off"
                            value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}{$snackyConfig.listAmountCart}{/if}">   
                            <button type="submit" class="btn btn-primary sn-addBasket btn-block" title="{lang key="addToCart" section="global"}">
                                <span{if $snackyConfig.listShowCart == 3} class="visible-xs"{/if}>
                                    <span class="img-ct icon ic-w mauto">
                                        <svg>
                                            <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}-simple"></use>
                                        </svg>
                                    </span>
                                </span>
                                {if $snackyConfig.listShowCart == 3}
                                <span class="hidden-xs">{lang key="addToCart" section="global"}</span>
                                {/if}
                            </button>
                        {/if}
                    </div>
            {elseif $snackyConfig.listShowCart == 3}
            <a href="{$Artikel->cURLFull}" class="btn btn-block">{lang key="details"}</a>
                {/if}
                {/block}
            </div>

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
			
            {if $Suchergebnisse && $Suchergebnisse->getPages()->getCurrentPage() > 1}
                <input type="hidden" name="seite" value="{$Suchergebnisse->getPages()->getCurrentPage()}" />
            {/if}
            {if $NaviFilter}
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
            {/if}
            {/block}
        </div>
		{/if}
    </form>
</div>
{/block}
