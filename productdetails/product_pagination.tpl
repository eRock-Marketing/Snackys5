{block name="product-pagination"}
{if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern == 'Y' && isset($NavigationBlaettern)}
	{if !$isMobile && $snackyConfig.positionHeadline != 1}
		{block name="product-pagination-desktop"}
			<div id="prevNextRow" class="flx-ac flx-jb flx-w mb-sm hidden-xs big">
				{block name="product-pagination-desktop-prev"}
					<div class="visible-lg visible-md product-pagination previous">
						{if isset($NavigationBlaettern->vorherigerArtikel) && $NavigationBlaettern->vorherigerArtikel->kArtikel}
							<a href="{$NavigationBlaettern->vorherigerArtikel->cURLFull}" title="{$NavigationBlaettern->vorherigerArtikel->cName}" aria-label="{lang key='details'}: {$NavigationBlaettern->vorherigerArtikel->cName}" class="flx">
								<span class="button flx-ac flx-jc">
									<span class="ar ar-l"></span>
								</span>
								<span class="img-ct">
									{include file='snippets/image.tpl' item=$NavigationBlaettern->vorherigerArtikel square=false srcSize='sm'}
								</span>	
							</a>
						{/if}
					</div>
				{/block}
				{block name="product-pagination-desktop-headline"}
					<div class="center">
						{if $snackyConfig.positionManufacturer == 0}
							{include file="productdetails/manufacturer.tpl"}
						{/if}
						<h1 class="fn product-title text-center">{$Artikel->cName}</h1>
						{if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}
							{block name="productdetails-info-rating-wrapper-top"}
								<div class="rating-wrapper mt-xxs">
									<a id="jump-to-votes-tab" class="hidden-print"{if $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen == 'N' || $isMobile} data-toggle="collapse" href="#tab-votes" role="button"{else} href="{$Artikel->cURLFull}#tab-votes" {/if}>
										{include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
									</a>
								</div>
							{/block}
						{/if}
					</div>
				{/block}
				{block name="product-pagination-desktop-next"}
					<div class="visible-lg visible-md product-pagination next">
						{if isset($NavigationBlaettern->naechsterArtikel) && $NavigationBlaettern->naechsterArtikel->kArtikel}
							<a href="{$NavigationBlaettern->naechsterArtikel->cURLFull}" title="{$NavigationBlaettern->naechsterArtikel->cName}" aria-label="{lang key='details'}: {$NavigationBlaettern->naechsterArtikel->cName}" class="flx">
								<span class="img-ct">
									{include file='snippets/image.tpl' item=$NavigationBlaettern->naechsterArtikel square=false srcSize='sm'}
								</span>
								<span class="button flx-ac flx-jc">
									<span class="ar ar-r"></span>
								</span>
							</a>
						{/if}
					</div>
				{/block}
			</div>
		{/block}
	{else}
		{block name="product-pagination-mobile"}
			<div id="prevNextRow" class="flx-ac flx-jb small">
				{block name="product-pagination-mobile-prev"}
					<div class="product-pagination previous">
						{if isset($NavigationBlaettern->vorherigerArtikel) && $NavigationBlaettern->vorherigerArtikel->kArtikel}
							<a href="{$NavigationBlaettern->vorherigerArtikel->cURLFull}" title="{$NavigationBlaettern->vorherigerArtikel->cName}" aria-label="{lang key='details'}: {$NavigationBlaettern->vorherigerArtikel->cName}" class="flx-ac">
								<span class="ar ar-l"></span> {lang key="previous"}
							</a>
						{/if}
					</div>
				{/block}
				{block name="product-pagination-mobile-next"}
					<div class="product-pagination next">
						{if isset($NavigationBlaettern->naechsterArtikel) && $NavigationBlaettern->naechsterArtikel->kArtikel}
							<a href="{$NavigationBlaettern->naechsterArtikel->cURLFull}" title="{$NavigationBlaettern->naechsterArtikel->cName}" aria-label="{lang key='details'}: {$NavigationBlaettern->naechsterArtikel->cName}" class="flx-ac">
								{lang key="next"} <span class="ar ar-r"></span>
							</a>
						{/if}
					</div>
				{/block}
			</div>
			{block name="product-pagination-mobile-spacer"}
				<div class="hidden-xs"><hr class="invisible"></div>
			{/block}
		{/block}
	{/if}
{elseif !$isMobile}
	{block name="product-headline-center"}
		<div class="hidden-xs">
			{if $snackyConfig.positionManufacturer == 0}
				{include file="productdetails/manufacturer.tpl"}
			{/if}
			<h1 class="fn product-title text-center {if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}mb-xxs{else}mb-sm{/if}">{$Artikel->cName}</h1>
			{if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}
				{block name="productdetails-info-rating-wrapper-top-single"}
					<div class="rating-wrapper mt-xxs flx-jc mb-sm">
						<a id="jump-to-votes-tab" class="hidden-print"{if $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen == 'N' || $isMobile} data-toggle="collapse" href="#tab-votes" role="button"{else} href="{$Artikel->cURLFull}#tab-votes" {/if}>
							{include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
						</a>
					</div>
				{/block}
			{/if}
		</div>
	{/block}
{/if}
{/block}