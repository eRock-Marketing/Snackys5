{block name='blog-index'}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name='content'}
    {if \JTL\Shop::$AktuelleSeite === 'NEWSDETAIL'}
		{include file='blog/details.tpl'}
    {else}
        {include file='blog/overview.tpl'}
	{/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}
{/block}