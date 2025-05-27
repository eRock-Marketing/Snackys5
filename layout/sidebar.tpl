{block name='layout-sidebar'}
	{block name='layout-sidebar-assigns'}
		{assign var=ismobile value=false}
		{if $isMobile && !$isTablet}
			{assign var=ismobile value=true}
		{/if}
	{/block}
	{block name="footer-sidepanel-left"}
		<aside id="sp-l" class="hidden-print col-12{if !isset($smarty.get.sidebar) & $isMobile} lazy{/if}">
			{if isset($smarty.get.sidebar) || !$isMobile || $isTablet}
				<div class="inside">
					{include file="snippets/zonen.tpl" id="before_sidepanel" title="before_sidepanel"}
					{block name='layout-sidebar-headline'}
						<div class="{if !$isMobile}visible-xs visible-sm{/if}">
							<span class="block h3">{lang key="filterBy" setion="global"}</span>
							<hr class="op0 hr-sm">
						</div>
					{/block}
					{block name='layout-sidebar-mobile-elements'}
						{if $nSeitenTyp == 2 && $isMobile}
							{include file="productlist/improve_search.tpl"}
							{include file="productlist/filter_top.tpl"}
						{/if}
					{/block}
					{block name="footer-sidepanel-left-content"}
						{$boxes.left}
					{/block}
					{include file="snippets/zonen.tpl" id="after_sidepanel" title="after_sidepanel"}
				</div>
				<div class="visible-xs visible-sm overlay-bg"></div>
				<div class="visible-xs visible-sm close-sidebar close-btn"></div>
			{/if}
		</aside>
	{/block}
{/block}