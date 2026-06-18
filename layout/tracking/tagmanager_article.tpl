<script type="application/json" id="{$Artikel->kArtikel}" class="json-article-data">
	{
		'item_name': '{getTrackingName article=$Artikel }',
		'item_id': '{if $snackyConfig.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr|escape}{/if}',
		'price': {$Artikel->Preise->fVKNetto|number_format:2:".":""},
		{if !empty($Artikel->cHersteller)}
		'brand': '{$Artikel->cHersteller|escape}',
		'item_brand': '{$Artikel->cHersteller|escape}',
		{/if}
		{getTrackingCategory article=$Artikel}
		'quantity': 1
	}
</script>