{block name='productlist-productlist-actions'}
    {form action="#" method="post" class="product-actions actions-small d-flex" data=["toggle" => "product-actions"]}
        {block name='productlist-productlist-actions-buttons'}
            {if !($Artikel->nIstVater && $Artikel->kVaterArtikel === 0)}
                {if $Einstellungen.artikeluebersicht.artikeluebersicht_vergleichsliste_anzeigen === 'Y'}
                    {block name='productlist-productlist-actions-include-comparelist-button'}
                        {include file='snippets/comparelist_button.tpl'}
                    {/block}
                {/if}
                {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y' && $Einstellungen.artikeluebersicht.artikeluebersicht_wunschzettel_anzeigen === 'Y'}
                    {block name='productlist-productlist-actions-include-wishlist-button'}
                        {include file='snippets/wishlist_button.tpl'}
                    {/block}
                {/if}
            {/if}
        {/block}
        {block name='productlist-productlist-actions-input-hidden'}
            {input type="hidden" name="a" value="{if !empty({$Artikel->kVariKindArtikel})}{$Artikel->kVariKindArtikel}{else}{$Artikel->kArtikel}{/if}"}
        {/block}
    {/form}
{/block}
