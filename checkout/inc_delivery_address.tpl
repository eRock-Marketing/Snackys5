{block name='checkout-inc-delivery-address'}
    {$hideMainInfo=$hideMainInfo|default:false}
    <ul class="blanklist">
        {if isset($orderDetail)}
            {if $Lieferadresse->cFirma}<li>{$Lieferadresse->cFirma|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>{/if}
            {if $Lieferadresse->cZusatz}<li>{$Lieferadresse->cZusatz|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>{/if}
            <li>{$Lieferadresse->cTitel|escape:'html':'UTF-8':false} {$Lieferadresse->cVorname|escape:'html':'UTF-8':false} {$Lieferadresse->cNachname|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>
            <li>
                {$Lieferadresse->cStrasse|entferneFehlerzeichen|escape:'html':'UTF-8':false} {$Lieferadresse->cHausnummer|escape:'html':'UTF-8':false}, {if $Lieferadresse->cAdressZusatz}{$Lieferadresse->cAdressZusatz|escape:'html':'UTF-8':false},{/if}
                {$Lieferadresse->cPLZ|escape:'html':'UTF-8':false} {$Lieferadresse->cOrt|escape:'html':'UTF-8':false},
                {if $Lieferadresse->cLand}{$Lieferadresse->cLand|escape:'html':'UTF-8':false}{/if}
            </li>
        {else}
            {if !$hideMainInfo}
                {if $Lieferadresse->cFirma}<li>{$Lieferadresse->cFirma|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>{/if}
                {if $Lieferadresse->cZusatz}<li>{$Lieferadresse->cZusatz|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>{/if}
                <li>{$Lieferadresse->cTitel|escape:'html':'UTF-8':false} {$Lieferadresse->cVorname|escape:'html':'UTF-8':false} {$Lieferadresse->cNachname|entferneFehlerzeichen|escape:'html':'UTF-8':false}</li>
                <li>{$Lieferadresse->cStrasse|entferneFehlerzeichen|escape:'html':'UTF-8':false} {$Lieferadresse->cHausnummer|escape:'html':'UTF-8':false}</li>
            {/if}
            {if $Lieferadresse->cAdressZusatz}<li>{$Lieferadresse->cAdressZusatz|escape:'html':'UTF-8':false}</li>{/if}
            {if !$hideMainInfo}
                <li>{$Lieferadresse->cPLZ|escape:'html':'UTF-8':false} {$Lieferadresse->cOrt|escape:'html':'UTF-8':false}</li>
            {/if}
            {if $Lieferadresse->cBundesland}<li>{$Lieferadresse->cBundesland|escape:'html':'UTF-8':false}</li>{/if}
            {if $Lieferadresse->angezeigtesLand}<li>{$Lieferadresse->angezeigtesLand|escape:'html':'UTF-8':false}</li>{/if}
        {/if}
        {if $Lieferadresse->cTel}<li>{lang key='tel' section='account data'}: {$Lieferadresse->cTel|escape:'html':'UTF-8':false}</li>{/if}
        {if $Lieferadresse->cFax}<li>{lang key='fax' section='account data'}: {$Lieferadresse->cFax|escape:'html':'UTF-8':false}</li>{/if}
        {if $Lieferadresse->cMobil}<li>{lang key='mobile' section='account data'}: {$Lieferadresse->cMobil|escape:'html':'UTF-8':false}</li>{/if}
        {if $Lieferadresse->cMail}<li>{$Lieferadresse->cMail|escape:'html':'UTF-8':false}</li>{/if}
    </ul>
{/block}