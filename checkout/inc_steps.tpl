{block name='checkout-inc-steps'}
	{block name='checkout-inc-steps-assigns'}
		{assign var="step1_active" value=($bestellschritt[1] == 1 || $bestellschritt[2] == 1)}
		{assign var="step2_active" value=($bestellschritt[3] == 1 || $bestellschritt[4] == 1)}
		{assign var="step3_active" value=($bestellschritt[5] == 1)}
		{assign var="coupon" value=""}
	{/block}
	{block name='checkout-inc-steps-list'}
		{if $bestellschritt[1] != 3}
			{strip}
			<ul class="nav c-stps first mb-sm">
			{/strip}
				{block name='checkout-inc-steps-first'}
					{if $bestellschritt[1] < 3 || $bestellschritt[2] < 3}
						<li class="c-stp{if $step1_active} active{/if}">
							<a href="{get_static_route id='bestellvorgang.php'}?editRechnungsadresse=1" title="{lang section='account data' key='billingAndDeliveryAddress'}" class="flx-ac flx-jb">
								<h2 class="h3 m0">1. {lang section='account data' key='billingAndDeliveryAddress'}</h2>
								{if !($step1_active)}
									<div class="img-ct icon icon-wt ic-md">
										<svg>
										  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
										</svg>
									</div>
								{/if}
							</a>
						</li>
					{/if}
				{/block}
				{block name='checkout-inc-steps-second'}
					{if $bestellschritt[3] < 3 || $bestellschritt[4] < 3}
						<li class="c-stp{if $step2_active} active{/if}">
								<a href="{get_static_route id='bestellvorgang.php'}?editVersandart=1" title="{lang section='account data' key='shippingAndPaymentOptions'}" class="flx-ac flx-jb">
									<h2 class="h3 m0">2. {lang section='account data' key='shippingAndPaymentOptions'}</h2>
									{if !($step2_active)}
										<div class="img-ct icon icon-wt ic-md">
											<svg>
											  <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-edit"></use>
											</svg>
										</div>
									{/if}
								</a>
						</li>
					{/if}
				{/block}
				{block name='checkout-inc-steps-last'}
					{if $step3_active}
						<li class="c-stp active">
							<span class="flx-ac flx-jb">
								<h2 class="h3 m0">3. {lang section='checkout' key='summary'}</h2>
							</span>
						</li>
					{/if} 
				{/block}
			</ul>
		{/if}
	{/block}
{/block}