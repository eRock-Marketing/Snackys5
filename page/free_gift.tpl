{block name='page-free-gift'}
	{include file="snippets/zonen.tpl" id="opc_before_free_gift"}
	{block name='free-gift-notice'}
		<p class="alert alert-info">{lang key="freeGiftFromOrderValue"}</p>
	{/block}
	{block name='free-gift-list'}
		{if !empty($freeGifts)}
			{include file="snippets/zonen.tpl" id="before_free_gift_list" title="before_free_gift_list"}
			<div id="freegift" class="row row-eq-height">
				{foreach $freeGifts as $freeGiftProduct}
					{$basketValue = $freeGiftProduct->availableFrom - $freeGiftProduct->getStillMissingAmount()}
					{$isFreeGiftAvailableNow = $basketValue >= $freeGiftProduct->availableFrom}
					<div class="col-6 text-center">
						<a href="{$freeGiftProduct->getProduct()->cURLFull|cat:'?isfreegift=1'}">
							{block name='free-gift-image'}
								<span class="img-ct mb-xs">
									{include file='snippets/image.tpl'
										fluid=false
										item=$freeGiftProduct->getProduct()
										srcSize='md'
										sizes='auto'
										class='image'}
								</span>
							{/block}
							{block name='free-gift-name'}
								<a href="{$freeGiftProduct->getProduct()->cURLFull|cat:'?isfreegift=1'}" class="mt-xxs title word-break block h4 m0">{$freeGiftProduct->getProduct()->cName}</s>
							{/block}
							{block name='free-gift-ordervalue'}
								<small class="block text-muted mt-xxs">{lang key="freeGiftFrom1"} {$freeGiftProduct->getProduct()->cBestellwert} {lang key="freeGiftFrom2"}</small>
							{/block}
						</a>
					</div>
				{/foreach}
			</div>
		{/if}
	{/block}
{/block}