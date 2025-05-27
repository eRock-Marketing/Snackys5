{block name='boxes-box-coming-soon'}
	{if $isMobile && $oBox->getPosition() == 'left'}
		{* Don't show in mobile Sidebar *}
	{else}
		{lang key='upcomingProducts' assign='slidertitle'}
		{assign var=moreLink value=$oBox->getURL()}
		{lang key='showAllUpcomingProducts' assign='moreTitle'}
		{block name='boxes-box-coming-soon-include-product-slider'}
			{include file='snippets/product_slider.tpl'
				id="boxslider-comingsoon-{$oBox->getID()}"
				productlist=$oBox->getProducts()->elemente
				title=$slidertitle
				tplscope='box'
				moreLink=$moreLink
				moreTitle=$moreTitle
			}
		{/block}
	{/if}
{/block}