{block name='snackys-content-html'}
    {getPluginEdition cAssign="pluginEdition" plugin="km_snackys"}
    {if $pluginEdition != 'standard'}
        {$entry->cContent}
    {/if}
{/block}