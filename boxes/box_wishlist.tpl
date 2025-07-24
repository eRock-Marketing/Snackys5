{block name='boxes-box-wishlist'}
{if $isMobile && $oBox->getPosition() == 'left'}
{else}
    {if $oBox->getItems()|count > 0}
        <section class="box box-wishlist box-normal panel small" id="sidebox{$oBox->getID()}">
            {block name='boxes-box-wishlist-content'}
                {block name='boxes-box-wishlist-title'}
                    <div class="h5 panel-heading dpflex-a-center">
                        {lang key='wishlist'}
                        {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                    </div>
                {/block}
                {block name='boxes-box-wishlist-collapse'}
                    <div class="panel-body">
                        {assign var=maxItems value=$oBox->getItemCount()}
                            {block name='boxes-box-wishlist-wishlist-items'}
                        <ul class="nav">
                            {foreach $oBox->getItems() as $wishlistItem}
                                {if $wishlistItem@iteration > $maxItems}{break}{/if}
                            <li class="dpflex-a-center nav-it" data-id={$wishlistItem->kArtikel}>
                                {block name='boxes-box-wishlist-dropdown-products-image-title'}
                                        {if $oBox->getShowImages()}
                                            {block name='boxes-box-wishlist-dropdown-products-image'}
                                            <a href="{$wishlistItem->Artikel->cURLFull}" title="{$wishlistItem->cArtikelName|escape:'quotes'}" class="img-ct icon ic-lg icon-wt">
                                                    {include file='snippets/image.tpl'
                                                        item=$wishlistItem->Artikel
                                                        square=false
                                                        srcSize='xs'
                                                        sizes='24px'}
                                            </a>
                                            {/block}
                                        {/if}
                                        {block name='boxes-box-wishlist-dropdown-products-title'}
                                            {link href=$wishlistItem->Artikel->cURLFull title=$wishlistItem->cArtikelName|escape:'quotes' class=defaultlink}
                                                {$wishlistItem->fAnzahl|replace_delim}&times; {$wishlistItem->cArtikelName|truncate:40:'...'}
                                            {/link}
                                        {/block}
                                {/block}
                                {block name='snippets-wishlist-dropdown-products-remove'}
                                    {link class="remove"
                                        href=$wishlistItem->cURL
                                        data=["name"=>"Wunschliste.remove",
                                        "toggle"=>"product-actions",
                                        "value"=>['a'=>$wishlistItem->kWunschlistePos]|json_encode|escape:'html'
                                        ]
                                        aria=["label"=>"{lang section='login' key='wishlistremoveItem'}"]}
                                        <span class="img-ct icon">
                                            <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                                              <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-bin"></use>
                                            </svg>
                                        </span>
                                    {/link}
                                {/block}
                            </li>
                            {/foreach}
                            </ul>
                            {/block}
                        {block name='boxes-box-wishlist-actions'}
                            <hr class="hr-sm invisible">
                            <a href="{get_static_route id='wunschliste.php'}?wl={$oBox->getWishListID()}" class="btn btn-outline-primary btn-block btn-sm">
                                {lang key='goToWishlist'}
                           </a>
                        {/block}
                    </div>
                {/block}
            {/block}
        </section>
    {else}
        {block name='boxes-box-wishlist-no-items'}
        {/block}
    {/if}
{/if}
{/block}