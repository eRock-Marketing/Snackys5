{block name='layout-header-shopnav-wish'}
	{$wlCount = 0}
	{if \JTL\Session\Frontend::getWishlist()->getID() > 0}
		{$wlCount = \JTL\Session\Frontend::getWishlist()->getItems()|count}
	{/if}
	{if $wlCount >= 1}
		<div class="wish-list-menu hidden-xs">
			<a href="{get_static_route id='wunschliste.php'}" title="{lang key="wishlist" sektion="global"}" class="link_to_wishlist popup">
				<span class="img-ct icon icon-xl">
					<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
					  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-heart"></use>
					</svg>
				</span>
				<sup class="badge"><em>{$wlCount}</em></sup>
			</a>
		</div>
	{/if}
{/block}