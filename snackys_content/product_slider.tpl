{block name='snackys-content-product-slider'}
	{getPluginEdition cAssign="pluginEdition" plugin="km_snackys"}
	{if $pluginEdition != 'standard'}
		<div class="snackys-content {$entry->cClass}">
			{include file='snippets/product_slider.tpl' productlist=$snackysProducts title=$snackysTitle hideOverlays=true}
		</div>
	{/if}
{/block}