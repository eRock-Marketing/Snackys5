{if isset($returnAddresses)}
    {$selectedID=$selectedID|default:0}
    <option value="-1">{lang key='newReturnAddress' section='rma'}</option>
    {foreach $returnAddresses as $returnAddress}
        <option value="{$returnAddress->kLieferadresse}"{if
                ($returnAddress->nIstStandardLieferadresse === 1 && $selectedID === 0)
                || $selectedID === $returnAddress->kLieferadresse
                } selected{/if}>
            {if $returnAddress->cFirma}{$returnAddress->cFirma}, {/if}
            {$returnAddress->cStrasse} {$returnAddress->cHausnummer},
            {$returnAddress->cPLZ} {$returnAddress->cOrt}
        </option>
    {/foreach}
{/if}
