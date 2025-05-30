{block name='layout-header-shop-nav'}
	{strip}
		<div class="hdr-nav flx-ac flx-je">
			{include file="snippets/zonen.tpl" id="before_hdr_nav" title="before_hdr_nav"}
			{block name="navbar-languageswitch-outer"}
				{if $snackyConfig.languageShopNav == 'Y'}
					{block name="navbar-languageswitch"}
						{if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
							{include file="snippets/language_dropdown.tpl" isHeader=true}
						{/if}
					{/block}
				{/if}
			{/block}
			{block name="navbar-productsearch-outer"}
				{if $snackyConfig.headerType == 1 || $snackyConfig.headerType == 2 || $snackyConfig.headerType == 3 || $snackyConfig.headerType == 4 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 6 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5.5 || $snackyConfig.headerType == 7}
					{block name="navbar-productsearch"}
						<button class="sr-tg hidden-xs" aria-label="{lang key='find'}">
							<span class="img-ct icon icon-xl">
								<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
								  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-search"></use>
								</svg>
							</span>
							<span class="img-ct icon icon-xl">
								<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
								  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-close"></use>
								</svg>
							</span>
						</button>
					{/block}
				{/if}
			{/block}
			{block name="navbar-top-user"}
				{block name="navbar-top-user-account"}
					<div class="dropdown">
						<a href="#" data-toggle="modal" class="hdr-l" data-target="#login-popup" {if empty($smarty.session.Kunde->kKunde)}title="{lang key='login'}"{else}title="{lang key='myAccount'}"{/if} {if empty($smarty.session.Kunde->kKunde)}aria-label="{lang key='login'}"{else}aria-label="{lang key='myAccount'}"{/if}>
							<span class="img-ct icon icon-xl">
								<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
								  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-user"></use>
								</svg>
							</span>
						</a>
						{include file='layout/header_shopnav_user.tpl'}
					</div>
				{/block}
				{block name="navbar-top-user-compare"}
					{include file='layout/header_shop_nav_compare.tpl'}
				{/block}
				{block name="navbar-top-user-wish"}
					{if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
						{include file='layout/header_shop_nav_wish.tpl'}
					{/if}
				{/block}
				{block name="navbar-top-user-cart"}
					<div class="cart-menu dropdown{if $WarenkorbArtikelPositionenanzahl >= 1} items{/if}{if $nSeitenTyp == 3} current{/if}{if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt} open{/if}" data-toggle="basket-items">
						{include file='basket/cart_dropdown_label.tpl'}
					</div>
				{/block}
			{/block}
			{include file="snippets/zonen.tpl" id="after_hdr_nav" title="after_hdr_nav"}
		</div>
	{/strip}
{/block}