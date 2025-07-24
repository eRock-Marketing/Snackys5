{block name='boxes-box-bestseller'}
	{if $isMobile && $oBox->getPosition() == 'left'}
		{* Don't show in mobile Sidebar *}
	{else}
		{lang key='showAllBestsellers' assign='moreTitle'}
		{lang key='bestsellers' assign='slidertitle'}
		{block name='boxes-box-bestseller-include-product-slider'}
			{include file='snippets/product_slider.tpl'
				id="boxslider-bestsellers-{$oBox->getID()}"
				productlist=$oBox->getProducts()->elemente
				title=$slidertitle
				tplscope='box'
				moreLink=$oBox->getURL()
				moreTitle=$moreTitle
			}
		{/block}
	{/if}
{/block}