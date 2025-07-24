{block name='productdetails-config-summary'}
{strip}
	{block name='config-summary-main-article'}
		<tr>
			<td colspan="2">{$Artikel->cName}</td>
			<td class="text-right no-wrap">{$Artikel->Preise->cVKLocalized[$NettoPreise]}</td>
		</tr>
	{/block}
	{block name='config-summary-configurations'}
		{if $oKonfig->oKonfig_arr|@count > 0}
			{block name='config-summary-configurations-components'}
				{$isIgnoreMultiplier = false}
				{foreach $oKonfig->oKonfig_arr as $oKonfiggruppe}
					{if $oKonfiggruppe->bAktiv}
						{foreach $oKonfiggruppe->oItem_arr as $oKonfigitem}
							{if $oKonfigitem->bAktiv && !$oKonfigitem->ignoreMultiplier()}
								<tr>
									<td class="no-wrap">{$oKonfigitem->fAnzahl} &times;</td>
									<td class="word-break">{$oKonfigitem->getName()}</td>
									<td class="text-right no-wrap">{$oKonfigitem->getFullPriceLocalized(true, false, 1)}</td>
								</tr>
							{elseif $oKonfigitem->bAktiv && $oKonfigitem->ignoreMultiplier()}
								{$isIgnoreMultiplier = true}
							{/if}
						{/foreach}
					{/if}
				{/foreach}
			{/block}
			{block name='config-summary-configurations-components-oneoff'}
				{if $isIgnoreMultiplier}
					<tr>
						<td colspan="3" class="highlighted">{lang key="one-off" section="checkout"}</td>
					</tr>
					{foreach $oKonfig->oKonfig_arr as $oKonfiggruppe}
						{if $oKonfiggruppe->bAktiv}
							{foreach $oKonfiggruppe->oItem_arr as $oKonfigitem}
								{if $oKonfigitem->bAktiv && $oKonfigitem->ignoreMultiplier()}
									<tr>
										<td class="no-wrap">{$oKonfigitem->fAnzahl} &times;</td>
										<td class="word-break">{$oKonfigitem->getName()}</td>
										<td class="text-right">{$oKonfigitem->getFullPriceLocalized()}</td>
									</tr>
								{/if}
							{/foreach}
						{/if}
					{/foreach}
				{/if}
			{/block}
		{/if}
	{/block}
{/strip}
{/block}