{block name='layout-header-category-nav'}
	{strip}
		{block name='category-nav-assigns'}
			{assign var=ismobile value=false}
			{if $isMobile && !$isTablet}
				{assign var=ismobile value=true}
			{/if}
		{/block}
		<div class="{*panel-body *}mgm mw-container{if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N'} has-images{/if}{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6} fullscreen-menu{/if}"{if $ismobile == true || ($snackyConfig.megaStyle == 1 && $snackyConfig.headerType != 4 && $snackyConfig.headerType != 4.5 && $snackyConfig.headerType != 6)} id="mm-dropdown"{/if}>
			{block name="category-nav-megamenu"}
				{block name='category-nav-mobile-elements'}
					<div class="hidden-sm hidden-md hidden-lg menu-title flx-ac flx-jb nowrap">
						<span class="m0 notextov block h3">{lang key="menu" section="custom"}</span>
						<button class="close-btn"></button>
					</div>
				{/block}
				{block name='category-nav-menu'}
					<ul class="flx-ac flx-jc blanklist flx-w{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6} no-scrollbar{/if}" id="cat-ul">
						{block name='category-nav-fullscreen-menu-elements'}
							{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6}
								<div class="flx-ac flx-jb nowrap fullscreen-title">
									<span class="m0 notextov block h3">{lang key="menu" section="custom"}</span>
									<button class="close-btn"></button>
								</div>
							{/if}
						{/block}
						{if $ismobile != true && ($snackyConfig.megaStyle == 0 || $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6)}
							{block name='category-nav-menu-megamenu'}
								{include file='snippets/categories_mega.tpl'}
							{/block}
						{elseif $snackyConfig.megaStyle == 1 && $ismobile != true}
							{block name='category-nav-menu-dropdown'}
								{include file='snippets/categories_dropdown.tpl'}
							{/block}
						{elseif $isMobile}
							{block name='category-nav-menu-mobile'}
								{include file='snippets/categories_mobile.tpl'}
							{/block}
						{/if}
					</ul>
				{/block}
			{/block}
		</div>
	{/strip}
{/block}