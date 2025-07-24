{block name='layout-bing-tracking'}
	{if $nSeitenTyp == 33 && $Bestellung->Positionen|count > 0}
		<script type="text/javascript">

			window.uetq = window.uetq || [];
			window.uetq.push('event', 'purchase', {
				'transaction_id': '{$Bestellung->cBestellNr}',
				'ecomm_prodid': [
					{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}
						{if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
							{if !$smarty.foreach.prodid.first},{/if}
							'{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}'
						{/if}
					{/foreach}
				], 
				'ecomm_pagetype': 'purchase',
				'ecomm_totalvalue': {$Bestellung->fWarensummeNetto|number_format:2:".":""},
				'revenue_value': {$Bestellung->fWarensummeNetto|number_format:2:".":""},
				'currency': '{$smarty.session.Waehrung->getCode()}',
				'items': [
					{foreach from=$Bestellung->Positionen item="prodid" name="prodid"}
						{if $prodid->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
							{if !$smarty.foreach.prodid.first},{/if}
							{ 
							'id': '{if $snackyConfig.artnr == "id"}{$prodid->Artikel->kArtikel}{else}{$prodid->Artikel->cArtNr|escape}{/if}', 
							'quantity': {$prodid->nAnzahl}, 
							'price': {$prodid->Artikel->Preise->fVKNetto|number_format:2:".":""} 
							}
						{/if}
					{/foreach}
				] 
			}
			);
		</script>
	{/if}
{/block}