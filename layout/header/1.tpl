{block name="km-header-1"}
	{block name="header-branding-content"}
		<header class="hidden-print" id="shop-nav">
			<div class="mw-container flx-ac flx-w">
				{block name="km-header-mobile"}
					<div class="col-4 visible-xs">
						{block name="km-header-mobile-navtoggle"}
							{include file="snippets/mobilenav-toggle.tpl"}
						{/block}
						{block name="km-header-mobile-searchtoggle"}
							<div id="sr-tg-m">
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
					<div class="col-4 col-sm-6 col-md-6 col-lg-2 flx-ac flx-jc text-center" id="logo">
						{block name="km-header-left-logo"}
							{include file='layout/shoplogo.tpl'}
						{/block}
					</div>
				{/block}
				{block name="km-header-center"}
					{if $nSeitenTyp !== 11}
						<div class="col-12 col-sm-12 col-md-12 col-lg-8 header-shop-menu" id="search">
							{block name="km-header-center-search"}
								<div class="inside flx-ac flx-jc">
									{include file="snippets/header-search.tpl"}
								</div>
							{/block}
							{block name="km-header-center-categorys"}
								<div class="category-nav navbar-wrapper hidden-xs" id="cat-w">
									{include file="layout/header_category_nav.tpl"}
								</div>
							{/block}
							{block name="km-header-center-overlay-bg"}
								<div class="overlay-bg" id="cls-catw"></div>
							{/block}
						</div>
					{/if}
				{/block}
				{block name="header-branding-shop-nav"}
					<div class="col-4 col-sm-6 col-md-6 col-lg-2">
						{include file='layout/header_shop_nav.tpl'}
					</div>
				{/block}
			</div>
		</header>
	{/block}
	{block name="header-breadcrumb"}
		{if $nSeitenTyp !== 11}
			{include file='layout/breadcrumb.tpl'}
		{/if}
	{/block}
{/block}