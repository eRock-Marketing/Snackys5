{block name='productdetails-actions'}
{if !isset($smarty.get.quickView) || $smarty.get.quickView != 1}
    <div id="product-actions" class="product-actions hidden-print dpflex-j-end" role="group">
        {assign var=kArtikel value=$Artikel->kArtikel}

        {if $Artikel->kArtikelVariKombi > 0}
            {assign var=kArtikel value=$Artikel->kArtikelVariKombi}
        {/if}
        {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
            <label for="wl-action"  class="btn wishlist dpflex-a-c dpflex-j-center" title="{lang key='addToWishlist' section='productDetails'}">
                <span class="img-ct icon ic-md">
					<svg>
					  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-heart"></use>
					</svg>
                </span>
            </label>
        {/if}
        {if $Einstellungen.artikeldetails.artikeldetails_vergleichsliste_anzeigen === 'Y' && $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
            <label for="vg-action" class="btn compare dpflex-a-c dpflex-j-center" title="{lang key='addToCompare' section='productDetails'}">
                <span class="img-ct icon ic-md">
					<svg>
					  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-compare"></use>
					</svg>
                </span>
            </label>
        {/if}
        {if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
            <label for="z{$kArtikel}" class="btn popup-dep question dpflex-a-c dpflex-j-center" title="{lang key='productQuestion' section='productDetails'}">
                <span class="img-ct icon ic-md">
					<svg>
					  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-question"></use>
					</svg>
                </span>
            </label>
        {/if}
    </div>
{/if}
{/block}