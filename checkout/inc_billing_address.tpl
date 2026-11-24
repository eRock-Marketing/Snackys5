{block name='checkout-inc-billing-address'}
    {block name='checkout-inc-billing-address-vars'}
        {$addressData = $billingAddress|default:$Kunde}
    {/block}
    {block name='checkout-inc-billing-address-wrapper'}
        <ul class="blanklist">
            {if isset($orderDetail)}
                {if $addressData->cFirma}<li>{$addressData->cFirma|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>{/if}
                <li>{$addressData->cTitel} {$addressData->cVorname|escape:'html':'UTF-8':false} {$addressData->cNachname|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>
                <li>
                    {$addressData->cStrasse|entferneFehlerzeichen|escape:'html':'UTF-8':false} {$addressData->cHausnummer|escape:'html':'UTF-8':false} {if $addressData->cAdressZusatz}{$addressData->cAdressZusatz|escape:'html':'UTF-8':false}{/if},
                    {$addressData->cPLZ|escape:'html':'UTF-8':false} {$addressData->cOrt|escape:'html':'UTF-8':false},
                    {$addressData->cLand|escape:'html':'UTF-8':false}
                </li>
            {else}
                {if $addressData->cFirma}<li>{$addressData->cFirma|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>{/if}
                {if $addressData->cZusatz}<li>{$addressData->cZusatz|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>{/if}
                <li>{$addressData->cTitel} {$addressData->cVorname|escape:'html':'UTF-8':false} {$addressData->cNachname|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>
                <li>{$addressData->cStrasse|entferneFehlerzeichen|escape:'html':'UTF-8':false} {$addressData->cHausnummer|escape:'html':'UTF-8':false}</li>
                {if $addressData->cAdressZusatz}<li>{$addressData->cAdressZusatz|escape:'html':'UTF-8':false}</li>{/if}
                <li>{$addressData->cPLZ|escape:'html':'UTF-8':false} {$addressData->cOrt|escape:'html':'UTF-8':false}</li>
                {if $addressData->cBundesland}<li>{$addressData->cBundesland|escape:'html':'UTF-8':false}</li>{/if}
                <li>{if $addressData->angezeigtesLand}{$addressData->angezeigtesLand|escape:'html':'UTF-8':false}{else}{$addressData->cLand|escape:'html':'UTF-8':false}{/if}</li>
            {/if}
            {if $addressData->cUSTID}<li>{lang key='ustid' section='account data'}: {$addressData->cUSTID|escape:'html':'UTF-8':false}</li>{/if}
            {if $addressData->cTel}<li>{lang key='tel' section='account data'}: {$addressData->cTel|escape:'html':'UTF-8':false}</li>{/if}
            {if $addressData->cFax}<li>{lang key='fax' section='account data'}: {$addressData->cFax|escape:'html':'UTF-8':false}</li>{/if}
            {if $addressData->cMobil}<li>{lang key='mobile' section='account data'}: {$addressData->cMobil|escape:'html':'UTF-8':false}</li>{/if}
            <li>{$addressData->cMail|escape:'html':'UTF-8':false}</li>
        </ul>
    {/block}
{/block}