{block name='checkout-step3-shipping-options'}
	<div class="row">
    	<div class="col-12">
        	{if !isset($Versandarten)}
				{block name='step3-no-shipping'}
            		<div class="alert alert-danger">{lang key="noShippingMethodsAvailable" section="checkout"}</div>
				{/block}
        	{else}
				{block name='step3-has-shipping'}
            		<form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form jtl-validate shipping-payments checkout-shipping-form">
                		{$jtl_token}
						{block name='step3-shippings'}
                			<div class="panel-wrap mb-sm">
                    			<fieldset id="checkout-shipping-payment">
									{block name='step3-shippings-legend'}
                        				<legend>{lang section='global' key='shippingOptions'}</legend>
									{/block}
									{block name='step3-shippings-list'}
                        				<div class="form-group">
                            				{foreach name=shipment from=$Versandarten item=versandart}
												{block name='step3-shippings-list-item'}
                            						<div id="shipment_{$versandart->kVersandart}" class="payship-option">
														<label for="del{$versandart->kVersandart}" class="flx-ac m0 stc-radio">
															{block name='step3-shippings-list-item-radio'}
																<span class="stc-input">
																	<input name="Versandart" value="{$versandart->kVersandart}" type="radio" class="radio-checkbox" id="del{$versandart->kVersandart}"{if $Versandarten|count == 1 || $AktiveVersandart == $versandart->kVersandart} checked{/if}{if $smarty.foreach.shipment.first} required{/if}>
																	<span class="stc-radio-btn"></span>
																</span>
															{/block}
															{block name='step3-shippings-list-item-image'}
																{if $versandart->cBild}
																	<span class="payship-img">
																		<span class="img-ct icon contain">
																			{image src=$versandart->cBild alt="{$versandart->angezeigterName|trans}"}
																		</span>
																	</span>
																{/if}
															{/block}
															{block name='step3-shippings-list-item-content'}
																<span class="payship-content">
																	{block name='step3-shippings-list-item-content-name'}
																		<strong class="block">
																			{if $versandart->angezeigterName|trans === '' && $versandart->cBild === ''}
																				{$versandart->cName}
																			{else}
																				{$versandart->angezeigterName|trans}
																			{/if}
																			<span class="badge small">
																				{$versandart->cPreisLocalized}
																			</span>
																		</strong>
																	{/block}
																	{block name='step3-shippings-list-item-content-infos'}
																		<span class="block small">
																			{block name='step3-shippings-list-item-content-infos-notice'}
																				<span class="block">{$versandart->angezeigterHinweistext|trans}</span>
																			{/block}
																			{block name='step3-shippings-list-item-content-infos-shippingtime'}
																				{if !empty($versandart->cLieferdauer|trans)}
																					<span class="block">{lang key="shippingTime"}: {$versandart->cLieferdauer|trans}</span>
																				{/if}
																			{/block}
																			{block name='step3-shippings-list-item-content-infos-specific-costs'}
																				{if isset($versandart->specificShippingcosts_arr)}
																					{foreach $versandart->specificShippingcosts_arr as $specificShippingcosts}
																						<span class="block">{$specificShippingcosts->cName|trans}: {$specificShippingcosts->cPreisLocalized}</span>
																					{/foreach}
																				{/if}
																			{/block}
																			{block name='step3-shippings-list-item-content-infos-zuschlag'}
																				{if !empty($versandart->Zuschlag->fZuschlag)}
																					<span class="block">{$versandart->Zuschlag->angezeigterName|trans} (+{$versandart->Zuschlag->cPreisLocalized})</span>
																				{/if}
																			{/block}
																		</span>
																	{/block}
																</span>
															{/block}
														</label>
                            						</div>
												{/block}
                            				{/foreach}
                        				</div>
									{/block}
                    			</fieldset>
                			</div>
						{/block}
						{block name='step3-packaging'}
                			{if isset($Verpackungsarten) && $Verpackungsarten|@count > 0}
                				<div class="panel-wrap mb-sm">
                    				<fieldset>
										{block name='step3-packaging-legend'}
                        					<legend>{lang section='checkout' key='additionalPackaging'}</legend>
										{/block}
										{block name='step3-packaging-list'}
                        					<div class="form-group">
                            					{foreach $Verpackungsarten as $oVerpackung}
													{block name='step3-packaging-item'}
                            							<div id="packaging_{$oVerpackung->kVerpackung}" class="payship-option">
															<label for="pac{$oVerpackung->kVerpackung}" class="flx-ac m0 stc-checkbox">
																{block name='step3-packaging-item-radio'}
																	<span class="stc-input">
																		<input name="kVerpackung[]" type="checkbox" class="radio-checkbox" value="{$oVerpackung->kVerpackung}" id="pac{$oVerpackung->kVerpackung}" {if isset($oVerpackung->bWarenkorbAktiv) && $oVerpackung->bWarenkorbAktiv === true || (isset($AktiveVerpackung[$oVerpackung->kVerpackung]) && $AktiveVerpackung[$oVerpackung->kVerpackung] === 1)}checked{/if}/>
																		<span class="stc-checkbox-btn"></span>
																	</span>
																{/block}
																{block name='step3-packaging-item-content'}
																	<span class="payship-content">
																		{block name='step3-packaging-item-content-name'}
																			<strong class="block">
																				{$oVerpackung->cName}	
																				<span class="badge small">
																					{if $oVerpackung->nKostenfrei == 1}{lang key="ExemptFromCharges" section="global"}{else}{$oVerpackung->fBruttoLocalized}{/if}
																				</span>
																			</strong>	
																		{/block}
																		{block name='step3-packaging-item-content-description'}
																			<span class="block small">
																				{$oVerpackung->cBeschreibung}
																			</span>
																		{/block}
																	</span>
																{/block}
															</label>
                            							</div>
													{/block}
												{/foreach}
											</div>
										{/block}
                    				</fieldset>
								</div>
                			{/if}
						{/block}
						{block name='step3-payments'}
							<div class="panel-wrap mb-sm">
								<fieldset id="fieldset-payment">
									<legend>{lang section='global' key='paymentOptions'}</legend>
									{$step4_payment_content}
								</fieldset>
							</div>
						{/block}
						{block name='step3-submit'}
							{if isset($Versandarten)}
								<div class="text-right">
									<input type="hidden" name="versandartwahl" value="1" />
									<input type="hidden" name="zahlungsartwahl" value="1" />
									<input type="submit" value="{lang key="continueOrder" section="account data"}" class="submit btn btn-lg submit_once btn-primary" />
								</div>
							{/if}
						{/block}
            		</form>
				{/block}
				{block name='step3-sidecart'}
					{if isset($bAjaxRequest) && $bAjaxRequest}
						<div class="hidden" id="checkout-cart-ajaxversand">
							{include file="basket/cart_dropdown_checkout.tpl"}
						</div>
					{/if}
				{/block}
        	{/if}
		</div>
	</div>
{/block}