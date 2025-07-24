{block name='snippets-filter-category'}
{foreach $Suchergebnisse->Kategorieauswahl as $Kategorie}
	{if $Kategorie->nAnzahl >= 1}
		<li class="nav-it{if $NaviFilter->hasCategoryFilter() && $NaviFilter->getCategory()->getValue() == $Kategorie->kKategorie} active{/if}">
			<a rel="nofollow" href="{$Kategorie->cURL}" class="dpflex">
				<span class="value">
					{$Kategorie->cName|escape:'html'}
				</span>
				<span class="ctr">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Kategorie->nAnzahl}{/if}</span>
			</a>
		</li>
	{/if}
{/foreach}
{/block}