{block name="product-pagination"}
	{if !$isMobile}
		{block name="product-pagination-desktop"}
			<div id="prevNextRow" class="flx-ac flx-jb flx-w mb-sm hidden-xs">
				{block name="product-pagination-desktop-prev"}
					<div class="visible-lg visible-md product-pagination previous">
						{if isset($NavigationBlaettern->vorherigerArtikel) && $NavigationBlaettern->vorherigerArtikel->kArtikel}
							<a href="{$NavigationBlaettern->vorherigerArtikel->cURLFull}" title="{$NavigationBlaettern->vorherigerArtikel->cName}" class="flx">
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
					<h1 class="fn product-title text-center">{$Artikel->cName}</h1>
				{/block}
				{block name="product-pagination-desktop-next"}
					<div class="visible-lg visible-md product-pagination next">
						{if isset($NavigationBlaettern->naechsterArtikel) && $NavigationBlaettern->naechsterArtikel->kArtikel}
							<a href="{$NavigationBlaettern->naechsterArtikel->cURLFull}" title="{$NavigationBlaettern->naechsterArtikel->cName}" class="flx">
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
							<a href="{$NavigationBlaettern->vorherigerArtikel->cURLFull}" title="{$NavigationBlaettern->vorherigerArtikel->cName}" class="flx-ac">
								<span class="ar ar-l"></span> {lang key="previous"}
							</a>
						{/if}
					</div>
				{/block}
				{block name="product-pagination-mobile-next"}
					<div class="product-pagination next">
						{if isset($NavigationBlaettern->naechsterArtikel) && $NavigationBlaettern->naechsterArtikel->kArtikel}
							<a href="{$NavigationBlaettern->naechsterArtikel->cURLFull}" title="{$NavigationBlaettern->naechsterArtikel->cName}" class="flx-ac">
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
{/block}