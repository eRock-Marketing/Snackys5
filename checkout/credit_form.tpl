{block name='checkout-credit-form'}
{if $Kunde->fGuthaben > 0 && (!isset($smarty.session.Bestellung->GuthabenNutzen) || !$smarty.session.Bestellung->GuthabenNutzen)}
    <form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form form-inline">
        {$jtl_token}
        <fieldset>
            <div class="row">
                <div class="col-12 col-sm-6">
                    <span class="credit-description block">{lang key="creditDesc" section="account data"}</span>
                </div>
                <div class="col-12 col-sm-6">
                    <hr class="hr-sm invisible visible-xxs">
                    <p class="alert alert-info credit-amount-description text-center m0">{lang key="yourCreditIs" section="account data"} <strong class="credit-amount">{$GuthabenLocalized}</strong></p>
                    <input type="hidden" name="guthabenVerrechnen" value="1" />
                    <input type="hidden" name="guthaben" value="1" />
                    <hr class="hr-xs invisible">
                    <input type="submit" value="{lang key="useCredits" section="checkout"}" class="submit btn btn-block btn-primary" />
                </div>
            </div>
        </fieldset>
    </form>
{/if}
{/block}