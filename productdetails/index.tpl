{block name='productdetails-index'}
	{block name='productdetails-index-assigns'}
		{if !isset($viewportImages)}{assign var="viewportImages" value=0}{/if}
	{/block}
	{block name="header"}
		{if !isset($bAjaxRequest) || !$bAjaxRequest}
			{include file='layout/header.tpl'}
		{elseif isset($smarty.get.quickView) && $smarty.get.quickView == 1}
			{include file='layout/modal_header.tpl'}
		{/if}
	{/block}
	{block name="content"}
		{if isset($bAjaxRequest) && $bAjaxRequest && isset($listStyle) && ($listStyle === 'list' || $listStyle === 'gallery')}
			{block name="content-ajax"}
				{if $listStyle === 'list'}
					{assign var="tplscope" value="list"}
					{include file='productlist/item_list.tpl'}
				{elseif $listStyle === 'gallery'}
					{assign var="tplscope" value="gallery"}
					{assign var="class" value="thumbnail"}
					{include file='productlist/item_box.tpl'}
				{/if}
			{/block}
		{else}
			{block name="content-details"}
				<div id="result-wrapper" data-wrapper="true" variations-type="{if isset($varKombiArr) && $varKombiArr|@count > 0}varkombi{else if $Artikel->Variationen}simple{else}none{/if}">
					{block name="content-details-extension"}
						{include file="snippets/extension.tpl"}
					{/block}
					{block name="content-details-content"}
						{include file='productdetails/details.tpl'}
					{/block}
				</div>
			{/block}
		{/if}
	{/block}
	{block name="footer"}
		{if !isset($bAjaxRequest) || !$bAjaxRequest}
			{include file='layout/footer.tpl'}
		{elseif isset($smarty.get.quickView) && $smarty.get.quickView == 1}
			{include file='layout/modal_footer.tpl'}
		{/if}
	{/block}
{/block}