{block name="km-header-default"}
	{block name="header-branding-content"}
	<header class="hidden-print" id="shop-nav" role="banner">
		<div class="mw-container flx-ac flx-w">
			{block name="km-header-mobile"}
				<div class="col-4 visible-xs">
					{block name="km-header-mobile-navtoggle"}
						{include file="snippets/mobilenav-toggle.tpl"}
					{/block}
					{block name="km-header-mobile-searchtoggle"}
						{include file="snippets/mobilesearch-toggle.tpl"}
					{/block}
				</div>
			{/block}
			{block name="km-header-left"}
				<div id="search" class="col-12 col-sm-4">
					{block name="km-header-left-search"}
						{include file="snippets/header-search.tpl"}
					{/block}
				</div>
			{/block}
			{block name="km-header-center"}
				<div class="col-4 flx-ac flx-jc text-center" id="logo">
					{block name="km-header-center-logo"}
						{include file='layout/shoplogo.tpl'}
					{/block}
				</div>
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
				<div id="cat-w" role="navigation" tabindex="-1">
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