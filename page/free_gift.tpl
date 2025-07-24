{block name='page-free-gift'}
	{include file="snippets/zonen.tpl" id="opc_before_free_gift"}
	{block name='free-gift-notice'}
		<p class="alert alert-info">{lang key="freeGiftFromOrderValue"}</p>
	{/block}
	{block name='free-gift-list'}
		{if !empty($oArtikelGeschenk_arr)}
			{include file="snippets/zonen.tpl" id="before_free_gift_list" title="before_free_gift_list"}
			<div id="freegift" class="row row-eq-height">
				{foreach $oArtikelGeschenk_arr as $oArtikelGeschenk}
					<div class="col-6 text-center">
						<a href="{$oArtikelGeschenk->cURLFull}">
							{block name='free-gift-image'}
								<span class="img-ct mb-xs">
									{include file='snippets/image.tpl'
										fluid=false
										item=$oArtikelGeschenk
										srcSize='md'
										sizes='auto'
										class='image'}
								</span>
							{/block}
							{block name='free-gift-name'}
								<span class="mt-xxs title word-break block h4 m0">{$oArtikelGeschenk->cName}</span>
							{/block}
							{block name='free-gift-ordervalue'}
								<small class="block text-muted mt-xxs">{lang key="freeGiftFrom1"} {$oArtikelGeschenk->cBestellwert} {lang key="freeGiftFrom2"}</small>
							{/block}
						</a>
					</div>
				{/foreach}
			</div>
		{/if}
	{/block}
{/block}