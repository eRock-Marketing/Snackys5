{block name='productlist-item-details'}
    {formrow tag='dl' class="productlist-item-detail text-nowrap-util {if $small|default:false === true}formrow-small{/if}"}
    {block name='productlist-item-details-product-number'}
        {col tag='dt' cols=6}{lang key='productNo'}:{/col}
        {col tag='dd' cols=6}{$Artikel->cArtNr}{/col}
    {/block}
    {if count($Artikel->Variationen) > 0}
        {block name='productlist-item-details-variations'}
            {col tag='dt' cols=6}{lang key='variationsIn' section='productOverview'}:{/col}
            {col tag='dd' cols=6}
                <ul class="variations-list list-unstyled">
                    {foreach $Artikel->Variationen as $variation}
                        <li>{$variation->cName}<li>
                        {if $variation@index === 3 && !$variation@last}
                            <li>&hellip;</li>
                            {break}
                        {/if}
                    {/foreach}
                </ul>
            {/col}
        {/block}
    {/if}
    {if !empty($Artikel->cBarcode)
    && ($Einstellungen.artikeldetails.gtin_display === 'lists'
    || $Einstellungen.artikeldetails.gtin_display === 'always')}
        {block name='productlist-item-details-gtin'}
            {col tag='dt' cols=6}{lang key='ean'}:{/col}
            {col tag='dd' cols=6}{$Artikel->cBarcode}{/col}
        {/block}
    {/if}
    {if !empty($Artikel->cISBN)
    && ($Einstellungen.artikeldetails.isbn_display === 'L'
    || $Einstellungen.artikeldetails.isbn_display === 'DL')}
        {block name='productlist-item-details-isbn'}
            {col tag='dt' cols=6}{lang key='isbn'}:{/col}
            {col tag='dd' cols=6}{$Artikel->cISBN}{/col}
        {/block}
    {/if}


    {if $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen !== 'N' && !empty($Artikel->cHersteller)}
        {block name='productlist-item-details-manufacturer'}
            {col tag='dt' cols=6}{lang key='manufacturer' section='productDetails'}:{/col}
            {col tag='dd' cols=6 itemprop='manufacturer' itemscope=true itemtype='http://schema.org/Organization'}
                {link href="{if !empty($Artikel->cHerstellerHomepage)}{$Artikel->cHerstellerHomepage}{else}{$Artikel->cHerstellerSeo}{/if}"
                    class="text-decoration-none-util"
                    itemprop="url"
                    target="{if !empty($Artikel->cHerstellerHomepage)}_blank{else}_self{/if}"}
                    {if ($Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'BT'
                        || $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'B')
                        && !empty($Artikel->cHerstellerBildKlein)
                    }
                        {image webp=true lazy=true fluid=true
                            src=$Artikel->cHerstellerBildURLKlein
                            srcset="{$Artikel->cHerstellerBildURLKlein} {$Einstellungen.bilder.bilder_hersteller_mini_breite}w,
                                    {$Artikel->cHerstellerBildURLNormal} {$Einstellungen.bilder.bilder_hersteller_normal_breite}w"
                            alt=$Artikel->cHersteller
                            sizes="25px"
                            class="img-xs"}
                        <meta itemprop="image" content="{$ShopURL}/{$Artikel->cHerstellerBildKlein}">
                    {/if}
                    {if ($Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'BT'
                    || $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'Y')
                    && !empty($Artikel->cHersteller)}
                        <span itemprop="name">{$Artikel->cHersteller}</span>
                    {/if}
                {/link}
            {/col}
        {/block}
    {/if}

    {if !empty($Artikel->cUNNummer) && !empty($Artikel->cGefahrnr)
    && ($Einstellungen.artikeldetails.adr_hazard_display === 'L'
    || $Einstellungen.artikeldetails.adr_hazard_display === 'DL')}
        {block name='productlist-item-details-hazard'}
            {col tag='dt' cols=6}{lang key='adrHazardSign'}:{/col}
            {col tag='dd' cols=6}
                <table class="adr-table">
                    <tr>
                        <td>{$Artikel->cGefahrnr}</td>
                    </tr>
                    <tr>
                        <td>{$Artikel->cUNNummer}</td>
                    </tr>
                </table>
            {/col}
        {/block}
    {/if}
    {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
        {block name='productlist-item-details-mhd'}
            {col tag='dt' cols=6 title="{lang key='productMHDTool'}"}{lang key='productMHD'}:{/col}
            {col tag='dd' cols=6}{$Artikel->dMHD_de}{/col}
        {/block}
    {/if}
    {if $Einstellungen.artikeluebersicht.artikeluebersicht_gewicht_anzeigen === 'Y' && isset($Artikel->cGewicht) && $Artikel->fGewicht > 0}
        {block name='productlist-item-details-shipping-weight'}
            {col tag='dt' cols=6}{lang key='shippingWeight'}:{/col}
            {col tag='dd' cols=6}{$Artikel->cGewicht} {lang key='weightUnit'}{/col}
        {/block}
    {/if}
    {if $Einstellungen.artikeluebersicht.artikeluebersicht_artikelgewicht_anzeigen === 'Y' && isset($Artikel->cArtikelgewicht) && $Artikel->fArtikelgewicht > 0}
        {block name='productlist-item-details-product-weight'}
            {col tag='dt' cols=6}{lang key='productWeight'}:{/col}
            {col tag='dd' cols=6}{$Artikel->cArtikelgewicht} {lang key='weightUnit'}{/col}
        {/block}
    {/if}
    {if $Einstellungen.artikeluebersicht.artikeluebersicht_artikelintervall_anzeigen === 'Y' && $Artikel->fAbnahmeintervall > 0}
        {block name='productlist-item-details-intervall'}
            {col tag='dt' cols=6}{lang key='purchaseIntervall' section='productOverview'}:{/col}
            {col tag='dd' cols=6}{$Artikel->fAbnahmeintervall} {$Artikel->cEinheit}{/col}
        {/block}
    {/if}
    {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}
        {block name='productlist-item-details-rating'}
            {col tag='dt' cols=6}{lang key='ratingAverage'}:{/col}
            {col tag='dd' cols=6}
            {block name='productlist-item-details-include-rating'}
                {include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung link=$Artikel->cURLFull}
            {/block}
            {/col}
        {/block}
    {/if}
    {/formrow}
{/block}
