{block name='snippets-header-search'}
<form action="{$ShopURL}/search/" method="get" class="input-group" id="search-form">
	<input id="{if !$isMobile}search-header{else}search-header-mobile-fixed{/if}" minlength="{$Einstellungen.artikeluebersicht.suche_min_zeichen}" name="qs" type="search" list="km-search-keys" class="form-control ac_input" placeholder="{lang key='search'}" autocomplete="off" aria-label="{lang key='search'}"/>
	<button type="submit" name="search" id="search-submit-button" aria-label="{lang key='search'}">
		<span class="img-ct icon ic-md">
			<svg class="">
			  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-search"></use>
			</svg>
		</span>
	</button>
</form>
	{if $snackyConfig.liveSearch == 'Y'}
		<div id="km_snackys_search" class="hidden" data-url="{$ShopURL}">
		</div>
	{/if}
{/block}