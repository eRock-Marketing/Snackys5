{block name='layout-header-shop-nav-compare'}
	{$productCount = count(JTL\Session\Frontend::getCompareList()->oArtikel_arr)}
	{if $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
		<div class="hidden-xs compare-list-menu{if $productCount === 0} hidden{/if}">
			<a href="{get_static_route id='vergleichsliste.php'}" title="{lang key="compare" sektion="global"}"{if $Einstellungen.vergleichsliste.vergleichsliste_target === 'blank'} target="_blank"{/if} 
			class="hidden-xs{if $Einstellungen.vergleichsliste.vergleichsliste_target === 'popup'} popup{/if}">
				<span class="img-ct icon icon-xl">
					<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
					  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-compare"></use>
					</svg>
				</span>
				<sup class="badge"><em>{$productCount}</em></sup>
			</a>
		</div>
	{/if}
{/block}