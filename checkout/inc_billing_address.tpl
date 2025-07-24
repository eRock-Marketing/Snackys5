{block name='checkout-inc-billing-address'}
    {block name='checkout-inc-billing-address-vars'}
        {$addressData = $billingAddress|default:$Kunde}
    {/block}
    {block name='checkout-inc-billing-address-wrapper'}
        <ul class="blanklist">
            {if isset($orderDetail)}
                {if $addressData->cFirma}<li>{$addressData->cFirma|entferneFehlerzeichen}</li>{/if}
                <li>{$addressData->cTitel} {$addressData->cVorname} {$addressData->cNachname|entferneFehlerzeichen}</li>
                <li>
                    {$addressData->cStrasse|entferneFehlerzeichen} {$addressData->cHausnummer} {if $addressData->cAdressZusatz}{$addressData->cAdressZusatz}{/if},
                    {$addressData->cPLZ} {$addressData->cOrt},
                    {$addressData->cLand}
                </li>
            {else}
                {if $addressData->cFirma}<li>{$addressData->cFirma|entferneFehlerzeichen}</li>{/if}
                {if $addressData->cZusatz}<li>{$addressData->cZusatz|entferneFehlerzeichen}</li>{/if}
                <li>{$addressData->cTitel} {$addressData->cVorname} {$addressData->cNachname|entferneFehlerzeichen}</li>
                <li>{$addressData->cStrasse|entferneFehlerzeichen} {$addressData->cHausnummer}</li>
                {if $addressData->cAdressZusatz}<li>{$addressData->cAdressZusatz}</li>{/if}
                <li>{$addressData->cPLZ} {$addressData->cOrt}</li>
                {if $addressData->cBundesland}<li>{$addressData->cBundesland}</li>{/if}
                <li>{if $addressData->angezeigtesLand}{$addressData->angezeigtesLand}{else}{$addressData->cLand}{/if}</li>
            {/if}
            {if $addressData->cUSTID}<li>{lang key='ustid' section='account data'}: {$addressData->cUSTID}</li>{/if}
            {if $addressData->cTel}<li>{lang key='tel' section='account data'}: {$addressData->cTel}</li>{/if}
            {if $addressData->cFax}<li>{lang key='fax' section='account data'}: {$addressData->cFax}</li>{/if}
            {if $addressData->cMobil}<li>{lang key='mobile' section='account data'}: {$addressData->cMobil}</li>{/if}
            <li>{$addressData->cMail}</li>
        </ul>
    {/block}
{/block}