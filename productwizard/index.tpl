{block name='productwizard-index'}
{if !empty($oAuswahlAssistent->kAuswahlAssistentGruppe)}
	{include file="snippets/zonen.tpl" id="opc_before_selection_wizard"}
    <div id="selection_wizard">
        {include file="productwizard/form.tpl"}
    </div>
{elseif isset($AWA)}
	{include file="snippets/zonen.tpl" id="opc_before_selection_wizard"}
    {include file="selectionwizard/index.tpl"}
{/if}
{/block}