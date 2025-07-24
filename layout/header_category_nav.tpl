{block name='layout-header-category-nav'}
{* desktop navigation (> screen-min-sm) *}
{strip}
{assign var=ismobile value=false}
{if $isMobile && !$isTablet}
    {assign var=ismobile value=true}
{/if}
{*<div class="panel-slider">*}
<div class="{*panel-body *}mgm mw-container{if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N'} has-images{/if}{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6} fullscreen-menu{/if}"{if $ismobile == true || ($snackyConfig.megaStyle == 1 && $snackyConfig.headerType != 4 && $snackyConfig.headerType != 4.5 && $snackyConfig.headerType != 6)} id="mm-dropdown"{/if}>
	{block name="category-nav-megamenu"}
	<div class="hidden-sm hidden-md hidden-lg menu-title dpflex-a-center dpflex-j-between nowrap">
		<span class="m0 notextov block h3">{lang key="menu" section="custom"}</span>
		<button class="close-btn"></button>
	</div>
    {*<div class="mm-ar mw-container">
        <div class="in">
        <span class="sl-ar sl-pr btn inactive">
            <span class="ar ar-l"></span>
        </span>
        <span class="sl-ar sl-nx btn">
            <span class="ar ar-r"></span>
        </span>
        </div>
    </div>*}
    <ul class="{*p-sl no-scrollbar *}dpflex-a-center dpflex-j-center blanklist dpflex-wrap{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6} no-scrollbar{/if}">
        {if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6}
            <div class="dpflex-a-center dpflex-j-between nowrap fullscreen-title">
                <span class="m0 notextov block h3">{lang key="menu" section="custom"}</span>
                <button class="close-btn"></button>
            </div>
        {/if}
        {if $ismobile != true && ($snackyConfig.megaStyle == 0 || $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6)} 
            {include file='snippets/categories_mega.tpl'}
        {elseif $snackyConfig.megaStyle == 1 && $ismobile != true}
            {include file='snippets/categories_dropdown.tpl'}
        {elseif $isMobile}
            {include file='snippets/categories_mobile.tpl'}
        {/if}
    </ul>
	{/block}
</div>
{*</div>*}
{/strip}
{/block}