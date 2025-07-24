{block name='checkout-step3-shipping-options'}
<div class="row">
    <div class="col-12">
        {if !isset($Versandarten)}
            <div class="alert alert-danger">{lang key="noShippingMethodsAvailable" section="checkout"}</div>
        {else}
            <form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form jtl-validate shipping-payments checkout-shipping-form">
                {$jtl_token}
                <div class="panel-wrap mb-sm">
                    <fieldset id="checkout-shipping-payment">
                        <legend>{lang section='global' key='shippingOptions'}</legend>
                        <div class="form-group">
                            {foreach name=shipment from=$Versandarten item=versandart}
                            <div id="shipment_{$versandart->kVersandart}" class="payship-option">
								<label for="del{$versandart->kVersandart}" class="dpflex-a-center m0 stc-radio">
									<span class="stc-input">
										<input name="Versandart" value="{$versandart->kVersandart}" type="radio" class="radio-checkbox" id="del{$versandart->kVersandart}"{if $Versandarten|@count == 1 || $AktiveVersandart == $versandart->kVersandart} checked{/if}{if $smarty.foreach.shipment.first} required{/if}>
										<span class="stc-radio-btn"></span>
									</span>
									{if $versandart->cBild}
										<span class="payship-img">
											<span class="img-ct icon contain">
												{image src=$versandart->cBild alt="{$versandart->angezeigterName|trans}"}
											</span>
										</span>
									{/if}
									<span class="payship-content">
										<strong class="block">
											{$versandart->angezeigterName|trans}	
											<span class="badge small">
												{$versandart->cPreisLocalized}
											</span>
										</strong>
										<span class="block small">
											<span class="block">{$versandart->angezeigterHinweistext|trans}</span>
											{if !empty($versandart->cLieferdauer|trans)}
											<span class="block">{lang key="shippingTime"}: {$versandart->cLieferdauer|trans}</span>
											{/if}
											{if isset($versandart->specificShippingcosts_arr)}
												{foreach $versandart->specificShippingcosts_arr as $specificShippingcosts}
													<span class="block">{$specificShippingcosts->cName|trans}: {$specificShippingcosts->cPreisLocalized}</span>
												{/foreach}
											{/if}
											{if !empty($versandart->Zuschlag->fZuschlag)}
											<span class="block">{$versandart->Zuschlag->angezeigterName|trans} (+{$versandart->Zuschlag->cPreisLocalized})</span>
											{/if}
										</span>
									</span>
								</label>
                            </div>
                            {/foreach}
                        </div>
                    </fieldset>
                </div>
                {if isset($Verpackungsarten) && $Verpackungsarten|@count > 0}
                <div class="panel-wrap mb-sm">
                    <fieldset>
                        <legend>{lang section='checkout' key='additionalPackaging'}</legend>
                        <div class="form-group">
                            {foreach $Verpackungsarten as $oVerpackung}
                            <div id="packaging_{$oVerpackung->kVerpackung}" class="payship-option">
								<label for="pac{$oVerpackung->kVerpackung}" class="dpflex-a-center m0 stc-checkbox">
									<span class="stc-input">
										<input name="kVerpackung[]" type="checkbox" class="radio-checkbox" value="{$oVerpackung->kVerpackung}" id="pac{$oVerpackung->kVerpackung}" {if isset($oVerpackung->bWarenkorbAktiv) && $oVerpackung->bWarenkorbAktiv === true || (isset($AktiveVerpackung[$oVerpackung->kVerpackung]) && $AktiveVerpackung[$oVerpackung->kVerpackung] === 1)}checked{/if}/>
										<span class="stc-checkbox-btn"></span>
									</span>
									<span class="payship-content">
										<strong class="block">
											{$oVerpackung->cName}	
											<span class="badge small">
												{if $oVerpackung->nKostenfrei == 1}{lang key="ExemptFromCharges" section="global"}{else}{$oVerpackung->fBruttoLocalized}{/if}
											</span>
										</strong>	
										<span class="block small">
											{$oVerpackung->cBeschreibung}
										</span>
									</span>
								</label>
                            </div>
                            {/foreach}
                        </div>
                    </fieldset>
                </div>
                {/if}
                <div class="panel-wrap mb-sm">
                    <fieldset id="fieldset-payment">
                        <legend>{lang section='global' key='paymentOptions'}</legend>
                        {$step4_payment_content}
                    </fieldset>
                </div>
                {if isset($Versandarten)}
                <div class="text-right">
                    <input type="hidden" name="versandartwahl" value="1" />
                    <input type="hidden" name="zahlungsartwahl" value="1" />
                    <input type="submit" value="{lang key="continueOrder" section="account data"}" class="submit btn btn-lg submit_once btn-primary" />
                </div>
                {/if}
            </form>
			{if isset($bAjaxRequest) && $bAjaxRequest}
			<div class="hidden" id="checkout-cart-ajaxversand">
				{include file="basket/cart_dropdown_checkout.tpl"}
			</div>
			{/if}
        {/if}
    </div>
</div>
{/block}