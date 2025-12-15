{block name="product-info-manufacturer"}
    {if $snackyConfig.positionManufacturer == 1}
        <strong class="block first icon-wt">{lang key='manufacturer' section='productDetails'}: </strong>
    {/if}
    {if $Einstellungen.artikeldetails.artikel_weitere_artikel_hersteller_anzeigen === 'Y'}
        <a href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerURL}{/if}" title="{$Artikel->cHersteller|escape:'html'}" class="flx-ac{if $snackyConfig.positionManufacturer == 0} h4 mb-xxs{/if}{if $snackyConfig.positionHeadline == 0 && !$isMobile} flx-jc{/if}"{if !empty($Artikel->cHerstellerHomepage)} target="_blank"{/if}>
    {else}
        <span class="flx-ac{if $snackyConfig.positionManufacturer == 0} h4 mb-xxs{/if}{if $snackyConfig.positionHeadline == 0 && !$isMobile} flx-jc{/if}">
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