{block name="km-header-2"}
	{block name="header-branding-content"}
		<header class="hidden-print" id="shop-nav">
			<div class="mw-container flx-ac flx-w">
				{block name="km-header-mobile"}
					<div class="col-4 visible-xs">
						{block name="km-header-mobile-navtoggle"}
							{include file="snippets/mobilenav-toggle.tpl"}
						{/block}
						{block name="km-header-mobile-searchtoggle"}
							<div id="sr-tg-m" class="pr">
								<span class="img-ct icon">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-search"></use>
									</svg>
								</span>
								<span class="close close-btn"></span>
							</div>
						{/block}
					</div>
				{/block}
				{block name="km-header-left"}
					<div class="col-12 col-sm-4 hidden-xs">
						{block name="km-header-left-social"}
							{if $snackyConfig.headerSocial == 0}
								{include file="snippets/socialprofiles.tpl"}
							{/if}
						{/block}
					</div>
				{/block}
				{block name="km-header-center"}
					{block name="km-header-center-search-overlay"}
						<div class="col-12 col-sm-4 inside flx-ac flx-jc" id="search">
							{include file="snippets/header-search.tpl"}
						</div>
					{/block}
					{block name="km-header-center-logo"}
						<div class="col-4 flx-ac flx-jc text-center" id="logo">
							{include file='layout/shoplogo.tpl'}
						</div>
					{/block}
				{/block}
				{block name="header-branding-shop-nav"}
					<div class="col-4">
						{include file='layout/header_shop_nav.tpl'}
					</div>
				{/block}
			</div>
		</header>
	{/block}
	{block name="km-header-category-breadcrumb"}
		{if $nSeitenTyp !== 11}
			{block name="km-header-category"}
				<div class="category-nav navbar-wrapper hidden-xs" id="cat-w">
					{include file="layout/header_category_nav.tpl"}
				</div>
			{/block}
			{block name="km-header-overlay"}
				<div class="overlay-bg" id="cls-catw"></div>
			{/block}
			{block name="km-header-breadcrumb"}
				{include file='layout/breadcrumb.tpl'}
			{/block}
		{/if}
	{/block}
{/block}