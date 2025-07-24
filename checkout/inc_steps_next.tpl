{block name='checkout-inc-steps-next'}
	{block name='checkout-inc-steps-assigns'}
		{assign var="step1_active" value=($bestellschritt[1] == 1 || $bestellschritt[2] == 1)}
		{assign var="step2_active" value=($bestellschritt[3] == 1 || $bestellschritt[4] == 1)}
		{assign var="step3_active" value=($bestellschritt[5] == 1)}
	{/block}
	{block name='checkout-inc-steps-list'}
		{if $bestellschritt[1] != 3}
			<ul class="nav c-stps last mt-md">
				{block name='checkout-inc-steps-first'}
					{if ($bestellschritt[1] < 3 || $bestellschritt[2] < 3) == false}
						<li class="c-stp">
							<span class="flx-ac flx-jb">
								<h2 class="h3 m0">1. {lang section='account data' key='billingAndDeliveryAddress'}</h2>
							</span>
						</li>
					{/if}
				{/block}
				{block name='checkout-inc-steps-second'}
					{if ($bestellschritt[3] < 3 || $bestellschritt[4] < 3) == false}
						<li class="c-stp">
							<span class="flx-ac flx-jb">
								<h2 class="h3 m0">2. {lang section='account data' key='shippingAndPaymentOptions'}</h2>
							</span>
						</li>
					{/if}
				{/block}
				{block name='checkout-inc-steps-last'}
					{if $step3_active == false}
						<li class="c-stp">
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