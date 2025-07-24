{block name="logo"}
	{block name="logo-desktop"}
		<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="loaded w100 block ps-rel{if !empty($snackyConfig.mobileLogo)} hidden-xs{/if}">
			{if !empty($snackyConfig.svgLogo)}
				{block name="logo-svg"}
					<img src="{$snackyConfig.svgLogo}" alt="{$Einstellungen.global.global_shopname}">
				{/block}
			{else}
				{if isset($ShopLogoURL)}
					{block name="logo-upload-img"}
						{image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname}
					{/block}
				{else}
					{block name="logo-text"}
						<strong class="h2 m0 flx-ac flx-jc">{$Einstellungen.global.global_shopname}</strong>
					{/block}
				{/if}
			{/if}
		</a>
	{/block}
	{block name="logo-mobile"}
		{if !empty($snackyConfig.mobileLogo)}
			<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="loaded visible-xs">
				<img src="{$snackyConfig.mobileLogo}" alt="{$Einstellungen.global.global_shopname}">
			</a>
		{/if}
	{/block}
{/block}