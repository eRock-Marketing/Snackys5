{block name='snippets-filter-category'}
	{foreach $Suchergebnisse->Kategorieauswahl as $Kategorie}
		{if $Kategorie->nAnzahl >= 1}
			<li class="nav-it{if $NaviFilter->hasCategoryFilter() && $NaviFilter->getCategory()->getValue() == $Kategorie->kKategorie} active{/if}">
				<a rel="nofollow" href="{$Kategorie->cURL}" class="flx">
					{block name='snippets-filter-category-name'}
						<span class="value">
							{$Kategorie->cName|escape:'html'}
						</span>
					{/block}
					{block name='snippets-filter-category-counter'}
						<span class="ctr">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Kategorie->nAnzahl}{/if}</span>
					{/block}
				</a>
			</li>
		{/if}
	{/foreach}
{/block}