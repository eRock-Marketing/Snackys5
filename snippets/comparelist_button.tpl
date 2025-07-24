{assign var='isOnCompareList' value=false}
{foreach JTL\Session\Frontend::getCompareList()->oArtikel_arr as $product}
    {if $product->kArtikel === $Artikel->kArtikel}
        {$isOnCompareList=true}
        {break}
    {/if}
{/foreach}
{block name='snippets-comparelist-button-main'}
    {button name="Vergleichsliste"
        type="submit"
        class="{$classes|default:''} compare badge badge-circle-1 action-tip-animation-b {if $isOnCompareList}on-list{/if}"
        aria=["label" => {lang key='addToCompare' section='productOverview'}]
        data=["product-id-cl" => $Artikel->kArtikel, "toggle"=>"tooltip", "trigger"=>"hover"]
        title={lang key='addToCompare' section='productOverview'}
    }
        <span class="far fa-list-alt"></span>
    {/button}
{/block}
