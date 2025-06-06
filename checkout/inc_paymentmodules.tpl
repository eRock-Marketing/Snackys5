{block name='checkout-inc-paymentmodules'}
	{if !isset($abschlussseite) || $abschlussseite !== 1}
		{if $oPlugin !== null && $oPlugin instanceof JTL\Plugin\PluginInterface}
			{$method = $oPlugin->getPaymentMethods()->getMethodByID($Bestellung->Zahlungsart->cModulId)}
		{else}
			{$method = null}
		{/if}
		{block name="checkout-order-confirmation"}
			<div class="row">
				{block name="confirmation-details"}
					<div class="col-12 col-md-4 col-lg-3 al-wp">
						<div class="panel small">
							{block name="confirmation-details-headline"}
								<div class="panel-heading h4">
									{lang key="orderCompletedPre" section="checkout"}: {$Bestellung->cBestellNr} 
								</div>
							{/block}
							{block name="confirmation-details-billing-address"}
								<div class="panel-title h6 mb-xxs">
									{lang key="billingAdress" section="checkout"}
								</div>
								{$Bestellung->oRechnungsadresse->cVorname} {$Bestellung->oRechnungsadresse->cNachname|entferneFehlerzeichen}
								{if isset($Bestellung->oRechnungsadresse->cFirma) && $Bestellung->oRechnungsadresse->cFirma !== ''}
									<br>{$Bestellung->oRechnungsadresse->cFirma}
								{/if}
								<br>{$Bestellung->oRechnungsadresse->cStrasse|entferneFehlerzeichen} {$Bestellung->oRechnungsadresse->cHausnummer}
								<br>{$Bestellung->oRechnungsadresse->cPLZ} {$Bestellung->oRechnungsadresse->cOrt}
								<br>{$Bestellung->oRechnungsadresse->angezeigtesLand}
								<br>
								<br>{$Bestellung->oRechnungsadresse->cMail}
								<hr>
							{/block}
							{block name="confirmation-details-shipping-address"}
								<div class="panel-title h6 mb-xxs">
									{lang key="shippingAdress" section="checkout"}
								</div>
								{if $Bestellung->kLieferadresse != 0}
									{$Bestellung->Lieferadresse->cVorname} {$Bestellung->Lieferadresse->cNachname|entferneFehlerzeichen}
									{if isset($Bestellung->Lieferadresse->cFirma) && $Bestellung->Lieferadresse->cFirma !== ''}
										<br>{$Bestellung->Lieferadresse->cFirma}
									{/if}
									<br>{$Bestellung->Lieferadresse->cStrasse|entferneFehlerzeichen} {$Bestellung->Lieferadresse->cHausnummer}
									<br>{$Bestellung->Lieferadresse->cPLZ} {$Bestellung->Lieferadresse->cOrt}
									<br>{$Bestellung->Lieferadresse->angezeigtesLand}
									<br>
									{$Bestellung->Lieferadresse->cMail}
								{else}
									{lang key="shippingAdressEqualBillingAdress" section="account data"}
								{/if}
								<hr>
							{/block}
							{block name="confirmation-details-payment"}
								<div class="panel-title h6 mb-xxs">
									{lang key="paymentMethod" section="checkout"} 
								</div>
								{$Bestellung->cZahlungsartName}
								<hr>
							{/block}
							{block name="confirmation-details-shipping"}
								<div class="panel-title h6 mb-xxs">
									{lang key="shipmentMode" section="checkout"}
								</div>
								{$Bestellung->oVersandart->cName}<br>
								{if $snackyConfig.deliveryDate == '1'}
									{block name='confirmation-details-shipping-snackys'}
										<strong>{lang key="deliveryDate" section="custom"}:</strong>
										{getDeliveryDate calculateDays=$snackyConfig.daysForDeliverCalculation days=$Bestellung->oVersandart->nMinLiefertage saturday=$snackyConfig.deliveryDateSaturday state=$snackyConfig.deliveryDateState endTime=$snackyConfig.deliveryDateFinishTime format=$snackyConfig.deliveryDateFormat}
										{if $Bestellung->oVersandart->nMinLiefertage < $Bestellung->oVersandart->nMaxLiefertage}
											- {getDeliveryDate calculateDays=$snackyConfig.daysForDeliverCalculation days=$Bestellung->oVersandart->nMaxLiefertage saturday=$snackyConfig.deliveryDateSaturday state=$snackyConfig.deliveryDateState endTime=$snackyConfig.deliveryDateFinishTime format=$snackyConfig.deliveryDateFormat}
										{/if}
									{/block}
								{else}
									<strong>{lang key="shippingTime"}</strong>: {$Bestellung->cEstimatedDeliveryEx}
								{/if}
							{/block}
						</div>
					</div>
				{/block}
				{block name="confirmation-order"}
					<div class="col-12 col-md-8 col-lg-9">
						{block name="confirmation-order-headline"}
							{if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
								<h1 class="mb-sm">{lang key="orderCompletedPre" section="checkout"}</h1>
							{else}
								<h1 class="mb-sm">{lang key="orderCompletedPost" section="checkout"}</h1>
							{/if}
						{/block}
						{block name="confirmation-order-confirm-info"}
							{if ($method === null || $Bestellung->Zahlungsart->cModulId !== $method->getModuleID())
							&& $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'}
								{if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
									<div class="alert alert-info">{lang key='orderConfirmationPre' section='checkout'}</div>
								{else}
									<div class="alert alert-info">{lang key='orderConfirmationPost' section='checkout'}</div>
								{/if}
							{/if}
						{/block}
						{block name="confirmation-order-items"}
							{if isset($showBasket) && $showBasket == 'inc-order-items'}
								{include file='checkout/inc_order_items.tpl' tplscope='init-payment'}
							{/if}
						{/block}
						{block name="confirmation-order-payment-inner"}
							<div class="payment-method-inner">
								{if $Bestellung->Zahlungsart->cModulId === 'za_paypal_jtl'}
									{include file='checkout/modules/paypal/bestellabschluss.tpl'}
								{elseif $method !== null && $Bestellung->Zahlungsart->cModulId === $method->getModuleID()}
									{include file=$method->getTemplateFilePath()}
								{/if}
							</div>
						{/block}
						{block name="confirmation-order-items2"}
							{if isset($showBasket) && $showBasket == 'order-item'}
								{if $snackyConfig.basketVersion == 0}
									{include file='account/order_item.tpl' tplscope='confirmation'}
								{else}
									{include file='account/basket.tpl' tplscope='confirmation'}
								{/if}
							{/if}
						{/block}
					</div>
				{/block}
			</div>
		{/block}
	{/if}
{/block}