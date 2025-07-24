{block name="logo"}
<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="loaded w100 block ps-rel{if !empty($snackyConfig.mobileLogo)} hidden-xs{/if}">
	{if !empty($snackyConfig.svgLogo)}
		<img src="{$snackyConfig.svgLogo}" alt="{$Einstellungen.global.global_shopname}">
	{else}
		{if isset($ShopLogoURL)}
			{image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname}
		{else}
			<strong class="h2 m0 dpflex-a-center dpflex-j-c">{$Einstellungen.global.global_shopname}</strong>
		{/if}
	{/if}
</a>
{if !empty($snackyConfig.mobileLogo)}
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="loaded visible-xs">
		<img src="{$snackyConfig.mobileLogo}" alt="{$Einstellungen.global.global_shopname}">
	</a>
{/if}
{/block}