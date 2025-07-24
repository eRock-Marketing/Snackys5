{block name='account-my-account'}
	{block name='account-my-account-headline'}
		<h1 class="mb-sm">{lang key='welcome' section='login'} {$Kunde->cVorname} {$Kunde->cNachname}</h1>
	{/block}
	{block name='account-my-account-reg-success'}
		{if isset($smarty.get.reg)}
			<div class="alert alert-success">{lang key='accountCreated' section='global'}</div>
		{/if}
	{/block}
	{include file="snippets/zonen.tpl" id="after_account_page_headline" title="after_account_page_headline"}
	{block name='account-my-account-welcometext'}
		<p>{lang key="myAccountDesc" section="login"}</p>
	{/block}
	{block name="account-credit"}
		<div class="alert alert-info credit-info">
			{lang key="yourMoneyOnAccount" section="login"}: {$Kunde->cGuthabenLocalized}
		</div>
	{/block}
	<hr class="invisible">
	{block name="my-orders-overview"}
		{block name="my-orders-overview-headline"}
			<div class="h4">{lang key='myOrders'}</div>
		{/block}
		{block name="my-orders-overview-content"}
			<div class="card">
    			<div class="card-body">
        			{if count($Bestellungen) > 0}
            			{block name='account-my-account-orders-body'}
                			{foreach $Bestellungen as $order}
                				{if $order@index === 5}{break}{/if}
								{block name='account-my-account-orders-item'}
									<a href="{$cCanonicalURL}?bestellung={$order->kBestellung}" class="flx-ac item" title="{lang key='showOrder' section='login'}: {lang key='orderNo' section='login'} {$order->cBestellNr}">
										<span class="w100">
											<span class="row flx-ac">
												<span class="col-6">
													<strong class="block">{lang key="order"}: {$order->cBestellNr}</strong>
													<span class="block">{lang key="status"}: {$order->Status}</span>
												</span>
											<span class="text-muted small col-6">
												<span class="block">{$order->dBestelldatum}</span> <span class="block">{$order->cBestellwertLocalized}</span></span>
											</span>
										</span>
										<span class="img-ct icon icon-wt">
											<svg>
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#ar-right"></use>
											</svg>
										</span>
									</a>
								{/block}
							{/foreach}
							{block name='account-my-account-orders-showall'}
								<a href="{$cCanonicalURL}?bestellungen=1" class="flx-ac item" title="{lang key='showOrder' section='login'}: {lang key='orderNo' section='login'} {$order->cBestellNr}">
									<strong class="w100">{lang key="showAll"}</strong>
									<span class="img-ct icon icon-wt">
										<svg>
										  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#ar-right"></use>
										</svg>
									</span>
								</a>
							{/block}
            			{/block}
        			{else}
						{block name='account-my-account-orders-content-nodata'}
							{lang key='noOrdersYet' section='account data'}
						{/block}
        			{/if}
    			</div>
			</div>
		{/block}
		<hr class="invisible">
		{block name="my-personal-data"}
			{block name="my-personal-data-headline"}
				<span class="h4 block">{lang key="myPersonalData"}</span>
			{/block}
			{block name="my-personal-data-content"}
				<div class="card">
    				<div class="card-body">
						{block name="my-personal-data-address"}
							<a href="{$cCanonicalURL}?editRechnungsadresse=1" class="flx-ac item">
								<span class="w100">
									<strong class="block">{lang key='billingAdress' section='account data'}</strong>
									<small class="text-muted">{$Kunde->cStrasse|entferneFehlerzeichen} {$Kunde->cHausnummer}, {$Kunde->cPLZ} {$Kunde->cOrt}, {$Kunde->cLand}</small>
								</span>
								<span class="img-ct icon icon-wt">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
									</svg>
								</span>
							</a>
						{/block}
						{block name="my-personal-data-contactdata"}
							<a href="{$cCanonicalURL}?editRechnungsadresse=1" class="flx-ac item">
								<span class="w100">
									<strong class="block">{lang key='contactInformation' section='account data'} {lang key='and'} {lang key='email' section='account data'}</strong>
									<small class="text-muted">{$Kunde->cMail}</small>
								</span>
								<span class="img-ct icon icon-wt">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
									</svg>
								</span>
							</a>
						{/block}
						{block name="my-personal-data-shippingaddresses"}
							<a href="{$cCanonicalURL}?editLieferadresse=1" class="flx-ac item">
								<span class="w100">
									<strong class="block">{lang key="myShippingAddresses"}</strong>
								</span>
								<span class="img-ct icon icon-wt">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
									</svg>
								</span>
							</a>
						{/block}
						{block name="my-personal-data-password"}
							<a class="flx-ac item" href="{get_static_route id='jtl.php' params=['pass' => 1]}">
								<strong class="w100">{lang key="changePassword" section="login"}</strong>
								<span class="img-ct icon icon-wt">
									<svg>
									  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
									</svg>
								</span>
							</a>
						{/block}
    				</div>
				</div>
			{/block}
			{block name="my-downloads"}
				{include file='account/downloads.tpl'}
			{/block}
			<hr class="invisible hr-sm">
			{block name="delete-my-account"}
				<div class="text-right">
					<a class="btn btn-danger" href="{get_static_route id='jtl.php' params=['del' => 1]}">
						{lang key="deleteAccount" section="login"}
					</a>
				</div>
			{/block}
		{/block}
	{/block}
{/block}