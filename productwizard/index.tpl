{block name='productwizard-index'}
    {if !empty($oAuswahlAssistent->kAuswahlAssistentGruppe)}
        {if $snackyConfig.old_content_ids === 'Y'}
            {include file="snippets/zonen.tpl" id="opc_before_selection_wizard"}
        {else}
            {include file="snippets/zonen.tpl" id="before_selection_wizard"}
        {/if}
        <div id="selection_wizard">
            {include file="productwizard/form.tpl"}
        </div>
    {elseif isset($AWA)}
        {if $snackyConfig.old_content_ids === 'Y'}
            {include file="snippets/zonen.tpl" id="opc_before_selection_wizard"}
        {else}
            {include file="snippets/zonen.tpl" id="before_selection_wizard"}
        {/if}
        {include file="selectionwizard/index.tpl"}
    {/if}
{/block}