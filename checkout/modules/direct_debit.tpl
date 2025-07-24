{block name='checkout-modules-direct-debit'}
    <fieldset id="payment_debit">
       <legend>{lang key='paymentOptionDebitDesc' section='shipping payment'}</legend>

        {if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kontoinhaber_abfrage !== 'N'}
        {row}
            {col cols=12 md=8}
                {formgroup
                    class="owner {if isset($fehlendeAngaben.inhaber) && $fehlendeAngaben.inhaber > 0} has-error{/if}"
                    label="{lang key='owner' section='shipping payment'}{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kontoinhaber_abfrage !== 'Y'}<span class='optional'> - {lang key='optional'}</span>{/if}"
                    label-for="inp_owner"
                }
                    {input id="inp_owner" type="text" name="inhaber" maxlength="32" size="32"
                        value="{if isset($ZahlungsInfo->cInhaber) && $ZahlungsInfo->cInhaber|count_characters > 0}{$ZahlungsInfo->cInhaber}{elseif isset($oKundenKontodaten->cInhaber)}{$oKundenKontodaten->cInhaber}{/if}"
                        required=($Einstellungen.zahlungsarten.zahlungsart_lastschrift_kontoinhaber_abfrage === 'Y')}
                    {if isset($fehlendeAngaben.inhaber) && $fehlendeAngaben.inhaber > 0}
                        {alert variant="danger"}{lang key='fillOut'}{/alert}
                    {/if}
                {/formgroup}
            {/col}
        {/row}
        {/if}
        {if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kreditinstitut_abfrage !== 'N'}
        {row}
            {col cols=12 md=8}
                {formgroup
                    class="bankname{if isset($fehlendeAngaben.bankname) && $fehlendeAngaben.bankname > 0} has-error{/if}"
                    label="{lang key='bankname' section='shipping payment'}{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_kreditinstitut_abfrage !== 'Y'}<span class='optional'> - {lang key='optional'}</span>{/if}"
                    label-for="inp_bankname"
                }
                    {input id="inp_bankname" type="text" name="bankname" size="20" maxlength="90" placeholder=" "
                        value="{if isset($ZahlungsInfo->cBankName) && $ZahlungsInfo->cBankName|count_characters > 0}{$ZahlungsInfo->cBankName}{elseif isset($oKundenKontodaten->cBankName)}{$oKundenKontodaten->cBankName}{/if}"
                        required=($Einstellungen.zahlungsarten.zahlungsart_lastschrift_kreditinstitut_abfrage === 'Y')}
                   {if isset($fehlendeAngaben.bankname) && $fehlendeAngaben.bankname > 0}
                       {alert variant="danger"}{lang key='fillOut'}{/alert}
                   {/if}
                {/formgroup}
            {/col}
        {/row}
        {/if}

        {row}
            {col cols=12 md=8}
                {formgroup
                    class="iban{if isset($fehlendeAngaben.iban) && $fehlendeAngaben.iban > 0} has-error{/if}"
                    label="{lang key='iban' section='shipping payment'}"
                    label-for="inp_iban"
                }
                    {input id="inp_iban" type="text" name="iban" maxlength="32" size="20" placeholder=" "
                        value="{if isset($ZahlungsInfo->cIBAN) && $ZahlungsInfo->cIBAN|count_characters > 0}{$ZahlungsInfo->cIBAN}{elseif isset($oKundenKontodaten->cIBAN)}{$oKundenKontodaten->cIBAN}{/if}"
                        required=true}
                    {if isset($fehlendeAngaben.iban)}
                        {alert variant="danger"}
                            {if $fehlendeAngaben.iban === 1}{lang key='fillOut'}{/if}
                            {if $fehlendeAngaben.iban === 2}{lang key='wrongIban' section='checkout'}{/if}
                        {/alert}
                    {/if}
                {/formgroup}
            {/col}
        {/row}
        {if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_bic_abfrage !== 'N'}
        {row}
            {col cols=12 md=8}
                {formgroup
                    class="bic{if isset($fehlendeAngaben.bic) && $fehlendeAngaben.bic > 0} has-error{/if}"
                    label="{lang key='bic' section='shipping payment'}{if $Einstellungen.zahlungsarten.zahlungsart_lastschrift_bic_abfrage !== 'Y'}<span class='optional'> - {lang key='optional'}</span>{/if}"
                    label-for="inp_bic"
                }
                    {input id="inp_bic" type="text" name="bic" maxlength="32" size="20" placeholder=" "
                        value="{if isset($ZahlungsInfo->cBIC) && $ZahlungsInfo->cBIC|count_characters > 0}{$ZahlungsInfo->cBIC}{elseif isset($oKundenKontodaten->cBIC)}{$oKundenKontodaten->cBIC}{/if}"
                        required=($Einstellungen.zahlungsarten.zahlungsart_lastschrift_bic_abfrage === 'Y')}
                    {if isset($fehlendeAngaben.bic)}
                        {alert variant="danger"}
                            {if $fehlendeAngaben.bic === 1}{lang key='fillOut'}{/if}
                            {if $fehlendeAngaben.bic === 2}{lang key='wrongBIC' section='checkout'}{/if}
                        {/alert}
                    {/if}
                {/formgroup}
            {/col}
        {/row}
        {/if}
    </fieldset>
{/block}
