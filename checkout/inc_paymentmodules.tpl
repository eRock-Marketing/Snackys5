{block name='checkout-inc-paymentmodules'}
{if !isset($abschlussseite) || $abschlussseite !== 1}
    {if $oPlugin !== null && $oPlugin instanceof JTL\Plugin\PluginInterface}
        {$method = $oPlugin->getPaymentMethods()->getMethodByID($Bestellung->Zahlungsart->cModulId)}
    {else}
        {$method = null}
    {/if}
    {if empty($smarty.get.payAgain) && !empty($smarty.session.Kunde->kKunde)}
        <div class="row">
            <div class="col-12 col-md-4 col-lg-3 al-wp">
                <div class="panel small">
                    <div class="panel-heading h4">
                        {lang key="orderCompletedPre" section="checkout"}: {$Bestellung->cBestellNr} 
                    </div>
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
                    <div class="panel-title h6 mb-xxs">
                        {lang key="paymentMethod" section="checkout"} 
                    </div>
                    {$Bestellung->cZahlungsartName}
                    <hr>
                    <div class="panel-title h6 mb-xxs">
                        {lang key="shipmentMode" section="checkout"}
                    </div>
                    {$Bestellung->oVersandart->cName}<br>
                    <strong>{lang key="shippingTime"}</strong>: {$Bestellung->cEstimatedDeliveryEx}
                </div>
            </div>
            <div class="col-12 col-md-8 col-lg-9">
                {if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
                    <h1 class="mb-spacer mb-small">{lang key="orderCompletedPre" section="checkout"}</h1>
                {elseif $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl' && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'}
                    <h1 class="mb-spacer mb-small">{lang key="orderCompletedPost" section="checkout"}</h1>
                {/if}
                {if ($method === null || $Bestellung->Zahlungsart->cModulId !== $method->getModuleID())
                && $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl' && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'}
                    {if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
                        <div class="alert alert-info">{lang key='orderConfirmationPre' section='checkout'}</div>
                    {else}
                        <div class="alert alert-info">{lang key='orderConfirmationPost' section='checkout'}</div>
                    {/if}
                {/if}

                {* if (empty($smarty.session.Zahlungsart->nWaehrendBestellung) || $smarty.session.Zahlungsart->nWaehrendBestellung != 1) && $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl' && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'}
                    <div class="pament-method-during-order">
                        <p>{lang key='yourOrderId' section='checkout'}: <strong>{$Bestellung->cBestellNr}</strong></p>
                        <p>{lang key='yourChosenPaymentOption' section='checkout'}: <strong>{$Bestellung->cZahlungsartName}</strong></p>
                    </div>
                {/if *}
                <div class="payment-method-inner">
                    {if $Bestellung->Zahlungsart->cModulId === 'za_paypal_jtl'}
                        {include file='checkout/modules/paypal/bestellabschluss.tpl'}
                    {elseif $Bestellung->Zahlungsart->cModulId === 'za_kreditkarte_jtl'}
                        {include file='account/retrospective_payment.tpl'}
                    {elseif $method !== null && $Bestellung->Zahlungsart->cModulId === $method->getModuleID()}
                        {include file=$method->getTemplateFilePath()}
                    {/if}
                    <br />
                </div>
                {include file='account/order_item.tpl' tplscope='confirmation'}
            </div>
        </div>
    {else} 
        {assign var=cModulId value=$Bestellung->Zahlungsart->cModulId}
        {if ($method === null || $Bestellung->Zahlungsart->cModulId !== $method->getModuleID())
            && $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl'
            && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'
        }
            {block name='checkout-inc-paymentmodules-alert'}
                <p class="checkout-paymentmodules-alert">
                    {if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
                        {lang key='orderConfirmationPre' section='checkout'}
                    {else}
                        {lang key='orderConfirmationPost' section='checkout'}
                    {/if}
                </p>
            {/block}
        {/if}

        {if (empty($smarty.session.Zahlungsart->nWaehrendBestellung) || $smarty.session.Zahlungsart->nWaehrendBestellung != 1)
            && $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl'
            && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'
        }
            {block name='checkout-inc-paymentmodules-during-order'}
                <ul class="list-unstyled payment-method-module-ids">
                    <li><strong>{lang key='yourOrderId' section='checkout'}: </strong>{$Bestellung->cBestellNr}</li>
                    <li><strong>{lang key='yourChosenPaymentOption' section='checkout'}: </strong>{$Bestellung->cZahlungsartName}</li>
                </ul>
            {/block}
        {/if}
        {block name='checkout-inc-paymentmodules-method-inner'}
            <div class="payment-method-inner">
                {if $Bestellung->Zahlungsart->cModulId === 'za_paypal_jtl'}
                    {block name='checkout-inc-paymentmodules-include-bestellabschluss'}
                        {include file='checkout/modules/paypal/bestellabschluss.tpl'}
                    {/block}
                {elseif $Bestellung->Zahlungsart->cModulId === 'za_kreditkarte_jtl'}
                    {block name='checkout-inc-paymentmodules-include-retrospective-payment'}
                        {include file='account/retrospective_payment.tpl'}
                    {/block}
                {elseif $method !== null && $Bestellung->Zahlungsart->cModulId === $method->getModuleID()}
                    {block name='checkout-inc-paymentmodules-include-plugin'}
                        {include file=$method->getTemplateFilePath()}
                    {/block}
                {/if}
            </div>
        {/block}
    {/if}
{/if}
{/block}
