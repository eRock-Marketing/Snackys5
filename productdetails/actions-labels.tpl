{block name='productdetails-actions'}
	{if !isset($smarty.get.quickView) || $smarty.get.quickView != 1}
		<div id="product-actions" class="product-actions hidden-print flx-je" role="group">
			{block name='productdetails-actions-assigns'}
				{assign var=kArtikel value=$Artikel->kArtikel}
				{if $Artikel->kArtikelVariKombi > 0}
					{assign var=kArtikel value=$Artikel->kArtikelVariKombi}
				{/if}
			{/block}
			{if !($Artikel->nIstVater && $Artikel->kVaterArtikel == 0)}
				{block name='productdetails-actions-wishlist'}
					{if $Einstellungen.global.global_wunschliste_anzeigen === 'Y'}
						<button id="wl-action" name="Wunschliste" type="button" title="{lang key='addToWishlist' section='productDetails'}" aria-label="{lang key='addToWishlist' section='productDetails'}" class="btn wishlist flx-ac flx-jc">					
							<span class="img-ct icon ic-md">
								<svg>
								  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-heart"></use>
								</svg>
							</span>
						</button>
					{/if}
				{/block}
				{block name='productdetails-actions-comparelist'}
					{if $Einstellungen.artikeldetails.artikeldetails_vergleichsliste_anzeigen === 'Y' && $Einstellungen.vergleichsliste.vergleichsliste_anzeigen === 'Y'}
						<button id="vg-action" name="Vergleichsliste" type="button" title="{lang key='addToCompare' section='productDetails'}" aria-label="{lang key='addToCompare' section='productDetails'}" class="btn compare flx-ac flx-jc">
							<span class="img-ct icon ic-md">
								<svg>
								  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-compare"></use>
								</svg>
							</span>
						</button>
					{/if}
				{/block}
			{/if}
			{block name='productdetails-actions-productquestion'}
				{if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
					<button type="button" id="z{$kArtikel}" class="btn popup-dep question flx-ac flx-jc" title="{lang key='productQuestion' section='productDetails'}" aria-label="{lang key='productQuestion' section='productDetails'}" data-toggle="modal" data-target="#pp-question_on_item">
						<span class="img-ct icon ic-md">
							<svg>
							  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-question"></use>
							</svg>
						</span>
					</button>
				{/if}
			{/block}
		</div>
	{/if}
{/block}