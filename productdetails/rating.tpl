{block name='productdetails-rating'}
    {if $stars > 0}
        {block name='productdetails-rating-assigns'}
            {assign var=filename1 value='rate'}
            {assign var=filename3 value='.png'}
            {if isset($total) && $total > 1}
                {lang key='averageProductRating' section='product rating' assign='ratingLabelText'}
            {else}
                {lang key='productRating' section='product rating' assign='ratingLabelText'}
            {/if}
        {/block}
        {block name="productdetails-rating-main"}
            <div class="rating flx-ac flx-w" title="{$ratingLabelText}: {$stars}/5">
                {strip}
                {block name='productdetails-rating-star1'}
                    <div class="img-ct icon op1">
                        <svg><use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-star-full"></use></svg>
                    </div>
                {/block}
                {block name='productdetails-rating-star2'}
                    <div class="img-ct icon op1">
                        <svg><use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-star{if $stars >= 2}-full{elseif $stars > 1}-half{/if}"></use></svg>
                    </div>
                {/block}
                {block name='productdetails-rating-star3'}
                    <div class="img-ct icon op1">
                        <svg><use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-star{if $stars >= 3}-full{elseif $stars > 2}-half{/if}"></use></svg>
                    </div>
                {/block}
                {block name='productdetails-rating-star4'}
                    <div class="img-ct icon op1">
                        <svg><use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-star{if $stars >= 4}-full{elseif $stars > 3}-half{/if}"></use></svg>
                    </div>
                {/block}
                {block name='productdetails-rating-star5'}
                    <div class="img-ct icon op1">
                        <svg><use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-star{if $stars >= 5}-full{elseif $stars > 4}-half{/if}"></use></svg>
                    </div>
                {/block}
                {/strip}
                {block name='productdetails-rating-total'}
                    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKEL && !empty($total)}<small>({$total})</small>{/if}
                {/block}
            </div>
        {/block}
    {/if}
{/block}