{block name='checkout-modules-creditcard'}
    {block name='checkout-modules-creditcard-alert'}
        <fieldset>
            {if isset($fehlendeAngaben)}
                {alert variant="danger"}{lang key='invadivdDataWarning' section=''}{/alert}
            {else}
                {alert variant="info"}{lang key='mandatoryFieldNotification' section='errorMessages'}{/alert}
            {/if}
        </fieldset>
    {/block}
    {block name='checkout-modules-creditcard-payment-creditcard'}
        <fieldset id="payment_creditcard">
            <legend>{lang key='paymentOptionCreditcardDesc' section='shipping payment'}</legend>
            {row}
                {col cols=12 md=6}
                    {formgroup
                        class="crc_no {if isset($fehlendeAngaben.kreditkartennr) && $fehlendeAngaben.kreditkartennr > 0} has-error{/if}"
                        label="{lang key='creditcardNo' section='shipping payment'}"
                        label-for="inp_creditcardNo"
                    }
                        {input type="text" name="kreditkartennr" id="inp_creditcardNo" maxlength="32" size="32" value="{if isset($ZahlungsInfo->cKartenNr)}{$ZahlungsInfo->cKartenNr}{/if}" required=true}
                        {if isset($fehlendeAngaben.kreditkartennr) && $fehlendeAngaben.kreditkartennr > 0}
                            {alert variant="danger"}{lang key='fillOut'}{/alert}
                        {/if}
                    {/formgroup}
                {/col}

                {col cols=12 md=6}
                    {formgroup
                        class="crc_vadivd {if isset($fehlendeAngaben.gueltigkeit) && $fehlendeAngaben.gueltigkeit > 0} has-error{/if}"
                        label="{lang key='validity' section='shipping payment'}"
                        label-for="inp_validity"
                    }
                        {input type="text" name="gueltigkeit" id="inp_validity" maxlength="12"  size="12" value="{if isset($ZahlungsInfo->cGueltigkeit)}{$ZahlungsInfo->cGueltigkeit}{/if}" required=true}
                        {if isset($fehlendeAngaben.gueltigkeit) && $fehlendeAngaben.gueltigkeit > 0}
                            {alert variant="danger"}{lang key='fillOut'}{/alert}
                        {/if}
                    {/formgroup}
                {/col}
            {/row}

            {row}
                {col cols=12 md=6}
                    {formgroup
                        class="crc_cvv {if isset($fehlendeAngaben.cvv) && $fehlendeAngaben.cvv > 0} has-error{/if}"
                        label="{lang key='cvv' section='shipping payment'}"
                        label-for="inp_cvv"
                    }
                        {input type="text" name="cvv" id="inp_cvv" maxlength="4" size="4" value="{if isset($ZahlungsInfo->cCVV)}{$ZahlungsInfo->cCVV}{/if}" required=true}
                        {if isset($fehlendeAngaben.cvv) && $fehlendeAngaben.cvv > 0}
                            {alert variant="danger"}{lang key='fillOut'}{/alert}
                        {/if}
                    {/formgroup}
                {/col}

                {col cols=12 md=6}
                    {formgroup
                        class="crc_type {if isset($fehlendeAngaben.kartentyp) && $fehlendeAngaben.kartentyp > 0} has-error{/if}"
                        label="{lang key='creditcardType' section='shipping payment'}"
                        label-for="inp_creditcardType"
                    }
                        {input type="text" name="kartentyp" id="inp_creditcardType" maxlength="45" size="32" value="{if isset($ZahlungsInfo->cKartenTyp)}{$ZahlungsInfo->cKartenTyp}{/if}"}
                        {if isset($fehlendeAngaben.kartentyp) && $fehlendeAngaben.kartentyp > 0}
                            {alert variant="danger"}{lang key='fillOut'}{/alert}
                        {/if}
                    {/formgroup}
                {/col}
            {/row}

            {row}
                {col cols=12 md=6}
                    {formgroup
                        class="crc_owner {if isset($fehlendeAngaben.inhaber) && $fehlendeAngaben.inhaber > 0} has-error{/if}"
                        label="{lang key='owner' section='shipping payment'}"
                        label-for="inp_owner"
                    }
                        {input type="text" name="inhaber" id="inp_owner" maxlength="80" size="32" value="{if isset($ZahlungsInfo->cInhaber)}{$ZahlungsInfo->cInhaber}{/if}" required=true}
                        {if isset($fehlendeAngaben.inhaber) && $fehlendeAngaben.gueltigkeit > 0}
                            {alert variant="danger"}{lang key='fillOut'}{/alert}
                        {/if}
                    {/formgroup}
                {/col}
            {/row}
        </fieldset>
    {/block}
{/block}
