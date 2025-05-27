{block name='snackys-content-content'}
	{getPluginEdition cAssign="pluginEdition" plugin="km_snackys"}
	{if $pluginEdition != 'standard'}
		<div class="snackys-content {$entry->cClass}">
			{$entry->cContent}
		</div>
	{/if}
{/block}