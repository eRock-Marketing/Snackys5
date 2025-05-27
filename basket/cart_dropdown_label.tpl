{block name='basket-cart-dropdown-label'}
   {block name='basket-cart-dropdown-label-link'}
        <a href="{get_static_route id='warenkorb.php'}" class="basket-opener hdr-l" title="{lang key='basket'}" aria-label="{lang key='gotoBasket'}">
			{block name='basket-cart-dropdown-label-link-icon'}
				<span class="img-ct icon icon-xl">
					<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
					  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{if empty($currentTemplateDir)}templates/Snackys/{else}{$currentTemplateDir}{/if}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-{if $snackyConfig.basketType == 0}cart{else}shopping{/if}"></use>
					</svg>
				</span>
			{/block}
			{block name='basket-cart-dropdown-label-link-badge'}
				{if $WarenkorbArtikelAnzahl >= 1}
					<sup class="badge"><em>{$WarenkorbArtikelAnzahl}</em></sup>
				{/if}
			{/block}
        </a>
    {/block}
    {block name='basket-cart-dropdown-label-wrapper'}
        <div class="c-dp small dropdown-menu dropdown-menu-right{if $smarty.session.Warenkorb->PositionenArr|@count == 0} no-items{/if}">
			{block name='basket-cart-dropdown-label-content'}
				<div class="inside m0 w100">
					<div class="items-list cart-icon-dropdown nav-item">
						{include file='basket/cart_dropdown.tpl' isSidebar="1"}
					</div>
				</div>
			{/block}
			{block name='basket-cart-dropdown-label-helpers'}
				<div class="overlay-bg"></div>
				<button class="close-sidebar close-btn" aria-label="{lang key='close' section='account data'}: {lang key='basket'}"></button>
			{/block}
			</div>
    {/block}
{/block}