{block name='checkout-inc-payment-methods'}
    {radiogroup}
        {foreach $Zahlungsarten as $zahlungsart}
            {col cols=12 id=$zahlungsart->cModulId class="checkout-payment-method"}
                {radio name="Zahlungsart"
                        value=$zahlungsart->kZahlungsart
                        id="payment{$zahlungsart->kZahlungsart}"
                        checked=($AktiveZahlungsart === $zahlungsart->kZahlungsart || $Zahlungsarten|@count === 1)
                        required=($zahlungsart@first)
                }
                    {block name='checkout-inc-payment-methods-image-title'}
                        {if $zahlungsart->cBild}
                            {image src=$zahlungsart->cBild alt=$zahlungsart->angezeigterName|trans fluid=true class="img-sm"}
                        {/if}
                    {/block}
                    {block name='checkout-inc-payment-methods-content-wrapper'}
                        <span class="pay-wrap">
                            {block name='checkout-inc-payment-methods-text-title'}
                                <span class="block">
                                    <span class="title">{$zahlungsart->angezeigterName|trans}</span>
                                    {if $zahlungsart->fAufpreis != 0}
                                        {block name='checkout-inc-payment-methods-badge'}
                                            <strong class="checkout-payment-method-badge">
                                                {if $zahlungsart->cGebuehrname|has_trans}
                                                    <span>{$zahlungsart->cGebuehrname|trans} </span>
                                                {/if}
                                                {$zahlungsart->cPreisLocalized}
                                            </strong>
                                        {/block}
                                    {/if}
                                </span>
                            {/block}
                            {if $zahlungsart->cHinweisText|has_trans}
                                {block name='checkout-inc-payment-methods-note'}
                                    <span class="checkout-payment-method-note">
                                        <small>{$zahlungsart->cHinweisText|trans}</small>
                                    </span>
                                {/block}
                            {/if}
                        </span>
                    {/block}
                {/radio}
            {/col}
        {/foreach}
    {/radiogroup}
{/block}
