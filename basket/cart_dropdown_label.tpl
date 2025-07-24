{block name='basket-cart-dropdown-label'}
   {block name='basket-cart-dropdown-label-link'}
        <a href="{get_static_route id='warenkorb.php'}" class="basket-opener" title="{lang key='basket'}">
            <span class="img-ct icon icon-xl">
                <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
                  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{if empty($currentTemplateDir)}templates/Snackys/{else}{$currentTemplateDir}{/if}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
                </svg>
            </span>
            {if $WarenkorbArtikelPositionenanzahl >= 1}
            <sup class="badge"><em>{$WarenkorbArtikelPositionenanzahl}</em></sup>
            {/if}
        </a>
    {/block}
    {block name='basket-cart-dropdown-label-wrapper'}
        <ul class="c-dp small dropdown-menu dropdown-menu-right{if $smarty.session.Warenkorb->PositionenArr|@count == 0} no-items{/if}">
            <li class="inside m0 w100">
                <div class="items-list cart-icon-dropdown nav-item">
                    {include file='basket/cart_dropdown.tpl' isSidebar="1"}
                </div>
            </li>
            <li class="overlay-bg"></li>
            <li class="close-sidebar close-btn"></li>
        </ul>
    {/block}
{/block}