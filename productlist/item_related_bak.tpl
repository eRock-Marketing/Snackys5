{* template to display products in slider *}

<div class="p-c {if isset($class)} {$class}{/if} thumbnail pr row">
    <a class="img-w col-2 col-md-3 col-lg-2" href="{$Artikel->cURLFull}">
        <span class="img-ct">
        {if isset($Artikel->Bilder[0]->cAltAttribut)}
            {assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"html"}
        {else}
            {assign var="alt" value=$Artikel->cName}
        {/if}
		{include file='snippets/image.tpl' item=$Artikel square=false srcSize='sm' class='product-image'}
        </span>
    </a>
    <div class="caption col-10 col-md-9 col-lg-10">
        <h4 class="title word-break h5{if !isset($isBox)}h6{/if}">
            {if isset($showPartsList) && $showPartsList === true && isset($Artikel->fAnzahl_stueckliste)}
                <span class="article-bundle-info">
                    <span class="bundle-amount">{$Artikel->fAnzahl_stueckliste}</span> <span class="bundle-times">x</span>
                </span>
            {/if}
            <a href="{$Artikel->cURLFull}">{$Artikel->cKurzbezeichnung}</a>
        </h4>
        {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}<small>{include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}</small>{/if}
        {include file="productdetails/price.tpl" Artikel=$Artikel price_image=null tplscope=$tplscope}
    </div>
</div>{* /p-c *}
