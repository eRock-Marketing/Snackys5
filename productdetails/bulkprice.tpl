{block name="details-staffelpreise-wrapper"}
	<div class="bulk-price">
		{block name="detail-bulk-price"}
			<table class="table table-condensed table-hover">
				{block name="detail-bulk-price-header"}
					<thead>
						<tr>
							<th class="text-right">
								{lang key='fromDifferential' section='productOverview'}
							</th>
							<th class="text-right">{lang key='pricePerUnit' section='productDetails'}{if $Artikel->cEinheit} / {$Artikel->cEinheit}{/if}
								{if isset($Artikel->cMasseinheitName) && isset($Artikel->fMassMenge) && $Artikel->fMassMenge > 0 && $Artikel->cTeilbar !== 'Y' && ($Artikel->fAbnahmeintervall == 0 || $Artikel->fAbnahmeintervall == 1) && isset($Artikel->cMassMenge)}
									({$Artikel->cMassMenge} {$Artikel->cMasseinheitName})
								{/if}
							</th>
							{if !empty($Artikel->staffelPreis_arr[0].cBasePriceLocalized)}
								<th class="text-right">
									{lang key='basePrice'}
								</th>
							{/if}
						</tr>
					</thead>
				{/block}
				{block name="detail-bulk-price-prices"}
					<tbody>
						{foreach $Artikel->staffelPreis_arr as $bulkPrice}
							{if $bulkPrice.nAnzahl > 0}
								<tr class="bulk-price-{$bulkPrice.nAnzahl}">
									<td class="text-right">{$bulkPrice.nAnzahl}</td>
									<td class="text-right bulk-price">
										{$bulkPrice.cPreisLocalized[$NettoPreise]} <span class="footnote-reference">*</span>
									</td>
									{if !empty($bulkPrice.cBasePriceLocalized)}
										<td class="text-right bulk-base-price">
											{$bulkPrice.cBasePriceLocalized[$NettoPreise]}
										</td>
									{/if}
								</tr>
							{/if}
						{/foreach}
					</tbody>
				{/block}
			</table>
		{/block}
	</div>
{/block}