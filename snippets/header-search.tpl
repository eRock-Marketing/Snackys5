{block name='snippets-header-search'}
<form action="index.php" method="GET" class="input-group">
	<input id="{if !$isMobile}search-header{else}search-header-mobile-fixed{/if}" minlength="{$Einstellungen.artikeluebersicht.suche_min_zeichen}" name="qs" type="search" list="km-search-keys" class="form-control ac_input" placeholder="{lang key='search'}" autocomplete="off" aria-label="{lang key='search'}"/>
	<button type="submit" name="search" id="search-submit-button" aria-label="{lang key='search'}">
		<span class="img-ct icon">
			<svg class="">
			  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-search"></use>
			</svg>
		</span>
	</button>
</form>
{/block}