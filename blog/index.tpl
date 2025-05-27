{block name='blog-index'}
	{block name='blog-index-viewportimages'}
		{if !isset($viewportImages)}
			{assign var="viewportImages" value=0}
		{/if}
	{/block}
	{block name="header"}
		{include file='layout/header.tpl'}
	{/block}
	{block name='content'}
		{if \JTL\Shop::$AktuelleSeite === 'NEWSDETAIL'}
			{block name='content-details'}
				{include file='blog/details.tpl'}
			{/block}
		{else}
			{block name='content-overview'}
				{include file='blog/overview.tpl'}
			{/block}
		{/if}
	{/block}
	{block name="footer"}
		{include file='layout/footer.tpl'}
	{/block}
{/block}