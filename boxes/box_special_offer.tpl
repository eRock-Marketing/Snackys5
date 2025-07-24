{block name='boxes-box-special-offer'}
	{if $isMobile && $oBox->getPosition() == 'left'}
		{* Don't show in mobile Sidebar *}
	{else}
		{assign var=moreLink value=$oBox->getURL()}
		{lang key='showAllSpecialOffers' assign='moreTitle'}
		{assign var=specialOfferArticles value=$oBox->getProducts()->elemente}
		{if $specialOfferArticles|count > 1}
			{lang key='specialOffers' assign='slidertitle'}
		{else}
			{lang key='specialOffer' assign='slidertitle'}
		{/if}
		{block name='boxes-box-special-offer-include-product-slider'}
			{include file='snippets/product_slider.tpl'
				id="boxslider-special-offer-{$oBox->getID()}"
				productlist=$specialOfferArticles
				title=$slidertitle
				tplscope='box'
				moreLink=$moreLink
				moreTitle=$moreTitle
			}
		{/block}
	{/if}
{/block}