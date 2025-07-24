{block name='layout-bing-tracking'}

	{if $nSeitenTyp == 33 && $Bestellung->Positionen|count > 0}
		<script>
		window.uetq = window.uetq || [];
		window.uetq.push('event', 'purchase', {ldelim}"revenue_value":{$Bestellung->fWarensummeNetto|number_format:2:".":""},"currency":"{$smarty.session.Waehrung->getCode()}"{rdelim});
        </script>
    {/if}
{/block}