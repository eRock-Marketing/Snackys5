{block name='snippets-shipping-tax-info'}
{block name='vat-info'}
    {strip}
    {if !empty($taxdata.text)}
        {$taxdata.text}
    {else}
        {if $Einstellungen.global.global_ust_auszeichnung === 'auto'}
            {if $taxdata.net}
                {lang key='excl' section='productDetails'}
            {else}
                {lang key='incl' section='productDetails'}
            {/if}
            &nbsp;{$taxdata.tax}% {lang key='vat' section='productDetails'}
        {elseif $Einstellungen.global.global_ust_auszeichnung === 'autoNoVat'}
            {if $taxdata.net}
                {lang key='excl' section='productDetails'}
            {else}
                {lang key='incl' section='productDetails'}
            {/if}
            &nbsp;{lang key='vat' section='productDetails'}
        {elseif $Einstellungen.global.global_ust_auszeichnung === 'endpreis'}
            {lang key='finalprice' section='productDetails'}
        {/if}
    {/if}
    {/strip}
    {if $Einstellungen.global.global_versandhinweis === 'zzgl'}
    ,
        {if $Einstellungen.global.global_versandfrei_anzeigen === 'Y' && $taxdata.shippingFreeCountries}
            {if $Einstellungen.global.global_versandkostenfrei_darstellung === 'D'}
                {$countries = "{foreach $taxdata.countries as $cISO => $country}<abbr title='{$country}'>{$cISO}</abbr>&nbsp;{/foreach}"}
                {lang key='noShippingcostsTo' section='global'} {lang key='noShippingCostsAtExtended' section='basket' printf=$countries}
                <a href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}?shipping_calculator=0{/if}" rel="nofollow" class="shipment popup">
                    {lang key='shipping' section='basket'}</a>
            {else}
                <a href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}?shipping_calculator=0{/if}"
                   rel="nofollow" class="shipment popup"
                   data-toggle="tooltip" data-placement="left"
                   title="{$taxdata.shippingFreeCountries}, {lang key='else' section='global'} {lang key='plus' section='basket'} {lang key='shipping' section='basket'}">
                    {lang key='noShippingcostsTo' section='global'}
                </a>
            {/if}
        {elseif isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}
            {lang key='plus' section='basket'} <a href="{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}?shipping_calculator=0" rel="nofollow" class="shipment popup">
                {lang key='shipping' section='basket'}
            </a>
        {/if}
    {elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
        , {lang key='incl' section='productDetails'} <a href="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}{/if}" rel="nofollow" class="shipment">{lang key='shipping' section='basket'}</a>
    {/if}
{/block}

{block name='shipping-class'}
    {if !empty($taxdata.shippingClass) && $taxdata.shippingClass !== 'standard' && $Einstellungen.global.global_versandklasse_anzeigen === 'Y'}
        ({$taxdata.shippingClass})
    {/if}
{/block}
{/block}
