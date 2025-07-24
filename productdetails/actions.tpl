{block name='productdetails-actions'}
{if !isset($smarty.get.quickView) || $smarty.get.quickView != 1}
    <div id="product-actions" class="product-actions hidden-print dpflex-j-end" role="group">
        {assign var=kArtikel value=$Artikel->kArtikel}

        {if $Artikel->kArtikelVariKombi > 0}
            {assign var=kArtikel value=$Artikel->kArtikelVariKombi}
        {/if}
        {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
            <button id="wl-action" name="Wunschliste" type="submit"title="{lang key='addToWishlist' section='productDetails'}">
            </button>
        {/if}
        {if $Einstellungen.artikeldetails.artikeldetails_vergleichsliste_anzeigen === 'Y' && $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
            <button id="vg-action" name="Vergleichsliste" type="submit" title="{lang key='addToCompare' section='productDetails'}">
            </button>
        {/if}
        {if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
            <button type="button" id="z{$kArtikel}" title="{lang key='productQuestion' section='productDetails'}" data-toggle="modal" data-target="#pp-question_on_item">
            </button>
        {/if}
    </div>
{/if}
{/block}