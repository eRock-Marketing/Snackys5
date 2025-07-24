{block name='layout-header-shopnav-wish'}
{if !empty($smarty.session.Wunschliste->CWunschlistePos_arr)}
<div class="wish-list-menu hidden-xs">
    <a href="{get_static_route id='wunschliste.php'}" title="{lang key="Wishlist" sektion="global"}" class="link_to_wishlist popup">
            <span class="img-ct icon icon-xl">
				<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
				  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-heart"></use>
				</svg>
            </span>
        <sup class="badge"><em>{$smarty.session.Wunschliste->CWunschlistePos_arr|count}</em></sup>
    </a>
</div>
{/if}
{/block}