{block name='checkout-inc-payment-methods'}
{if (int)$ShopCreditAmount > 0 && (int)$OrderAmount === 0}
    <div class="col-12">
        <div class="checkbox">
            <label class="btn-block" for="using-shop-credit">
                <input type="checkbox" name="using-shop-credit" id="using-shop-credit"{if (int)$OrderAmount === 0} checked{/if}>
                <input type="hidden" name="Zahlungsart" value="{$AktiveZahlungsart}">
                <span style="text-transform:none; font-size:12pt;">
                    {if (int)$OrderAmount === 0}
                    <span class="">Guthaben verrechnet. Keine Zahlung erforderlich.</span>
                    {/if}
                </span>
            </label>
        </div>
    </div>
{else}
	{foreach name=paymentmethod from=$Zahlungsarten item=zahlungsart}
		<div id="{$zahlungsart->cModulId}" class="payship-option col-12">
			<label for="payment{$zahlungsart->kZahlungsart}" class="dpflex-a-center m0 stc-radio">
				<span class="stc-input">
					<input name="Zahlungsart" value="{$zahlungsart->kZahlungsart}" class="radio-checkbox" type="radio" id="payment{$zahlungsart->kZahlungsart}"
					{if $AktiveZahlungsart === $zahlungsart->kZahlungsart || $Zahlungsarten|@count == 1} checked{/if}{if $smarty.foreach.paymentmethod.first} required{/if}>
					<span class="stc-radio-btn"></span>
				</span>
				{if $zahlungsart->cBild}
				<span class="payship-img">
					<span class="img-ct icon contain">
						{image src=$zahlungsart->cBild alt="{$zahlungsart->angezeigterName|trans}"}
					</span>
				</span>
				{/if}
				<span class="payship-content">
					<strong class="block">
						{$zahlungsart->angezeigterName|trans}	
						{if $zahlungsart->fAufpreis != 0}
							<span class="badge small">
								{$zahlungsart->cPreisLocalized}
							</span>
						{/if}
					</strong>	
					{if $zahlungsart->cHinweisText|has_trans}
						<span class="block small">
							{$zahlungsart->cHinweisText|trans}
						</span>
					{/if}
				</span>
			</label>
		</div>
	{/foreach}
{/if}
{/block}