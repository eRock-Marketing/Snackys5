{block name="account-orders"}
	{block name="account-orders-headline"}
    	<h1 class="h2 mb-sm">
			{block name="account-orders-title"}
				{lang key="myOrders"}
			{/block}
		</h1>
	{/block}
	{block name="account-orders-outer"}
		{if $Bestellungen|count > 0}
			{block name="account-orders-body"}
				{assign var=bDownloads value=false}
				{foreach $Bestellungen as $order}
					{if isset($order->bDownload) && $order->bDownload > 0}
						{assign var=bDownloads value=true}
					{/if}
				{/foreach}
				<div class="card">
					<div class="card-body">
						{get_static_route id='jtl.php' assign='ordersURL'}
						{foreach $orderPagination->getPageItems() as $order}
							{block name="account-orders-orderitem"}
								<a href="{$ordersURL}?bestellung={$order->kBestellung}" class="flx-ac item" title="{lang key='showOrder' section='login'}: {lang key='orderNo' section='login'} {$order->cBestellNr}">
									{block name="account-orders-orderitem-information"}
										<span class="w100">
											<span class="row flx-ac">
												{block name="account-orders-orderitem-name-status"}
													<span class="col-6">
														{block name="account-orders-orderitem-name"}
															<strong class="block">{lang key="order"}: {$order->cBestellNr}</strong>
														{/block}
														{block name="account-orders-orderitem-status"}
															<span class="block">{lang key="status"}: {$order->Status}</span>
														{/block}
													</span>
												{/block}
												{block name="account-orders-orderitem-date-price"}
													<span class="text-muted small col-6">
														{block name="account-orders-orderitem-date"}
															<span class="block">{$order->dBestelldatum}</span>
														{/block}
														{block name="account-orders-orderitem-price"}
															<span class="block">{$order->cBestellwertLocalized}</span>
														{/block}
													</span>
												{/block}
											</span>
										</span>
									{/block}
									{block name="account-orders-orderitem-detail-arrow"}
										<span class="img-ct icon icon-wt">
											<svg>
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#ar-right"></use>
											</svg>
										</span>
									{/block}
								</a>
							{/block}
						{/foreach}
					</div>
				</div>
				{block name="account-orders-pagination"}
					{include file='snippets/pagination.tpl' oPagination=$orderPagination cThisUrl='jtl.php' cParam_arr=['bestellungen'=>1] parts=['pagi', 'label']}
				{/block}
			{/block}
		{else}
			{block name="account-orders-no-orders"}
				<div class="alert alert-info">{lang key='noEntriesAvailable'}</div>
			{/block}
		{/if}
	{/block}
{/block}