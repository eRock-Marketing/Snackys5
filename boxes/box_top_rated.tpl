{block name='boxes-box-top-rated'}
	{if $isMobile && $oBox->getPosition() == 'left'}
		{* Don't show in mobile Sidebar *}
	{else}
		{lang key='topReviews' assign='slidertitle'}
		{assign var=moreLink value=$oBox->getURL()}
		{lang key='topReviews' assign='moreTitle'}
		{block name='boxes-box-top-rated-include-product-slider'}
			{include file='snippets/product_slider.tpl'
				id="boxslider-toprated-{$oBox->getID()}"
				productlist=$oBox->getProducts()
				title=$slidertitle
				tplscope='box'
				moreLink=$moreLink
				moreTitle=$moreTitle
			}
		{/block}
	{/if}
{/block}