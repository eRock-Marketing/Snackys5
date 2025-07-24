{block name='checkout-inc-order-completed'}
{if empty($smarty.get.payAgain) && JTL\Session\Frontend::getCustomer()->getID() !== 0}
	<div id="order-confirmation">
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
								{$Bestellung->Lieferadresse->cVorname} {$Bestellung->Lieferadresse->cNachname|entferneFehlerzeichen}
								<br>{$Bestellung->Lieferadresse->cStrasse|entferneFehlerzeichen} {$Bestellung->Lieferadresse->cHausnummer}
								<br>{$Bestellung->Lieferadresse->cPLZ} {$Bestellung->Lieferadresse->cOrt}
								<br>{$Bestellung->Lieferadresse->angezeigtesLand}
								<br>
								{$Bestellung->Lieferadresse->cMail}
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
								<strong>{lang key="shippingTime"}</strong>: {$Bestellung->cEstimatedDeliveryEx}
							{/block}
						</div>
					</div>
				{/block}
				{block name="confirmation-order"}
					<div class="col-12 col-md-8 col-lg-9">
						{block name="confirmation-order-headline"}
							{if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
								<h1 class="mb-sm">{lang key="orderCompletedPre" section="checkout"}</h1>
							{elseif $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'}
								<h1 class="mb-sm">{lang key="orderCompletedPost" section="checkout"}</h1>
							{/if}
						{/block}
						{block name="confirmation-order-confirm-info"}
							<div class="alert alert-info">{lang key="orderConfirmationPost" section="checkout"}</div>
						{/block}
						{block name="confirmation-order-items"}
							{include file='account/order_item.tpl' tplscope='confirmation'}
						{/block}
					</div>
				{/block}
			</div>
		{/block}
	</div>
{else}
    {card id="order-confirmation"}
        {block name='checkout-inc-order-completed-alert'}
            <p class="order-confirmation-note">{lang key='orderConfirmationPost' section='checkout'}</p>
        {/block}
        {block name='checkout-inc-order-completed-id-payment'}
            <ul class="list-unstyled order-confirmation-details">
                <li><strong>{lang key='yourOrderId' section='checkout'}:</strong> {$Bestellung->cBestellNr}</li>
                <li><strong>{lang key='yourChosenPaymentOption' section='checkout'}:</strong> {$Bestellung->cZahlungsartName}</li>
            </ul>
        {/block}
    {/card} 
{/if}
{/block}