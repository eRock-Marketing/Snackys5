{block name='checkout-coupon-form'}
{if $KuponMoeglich == 1}
    <form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form form-inline jtl-validate">
        {$jtl_token}
        <input type="hidden" name="pruefekupon" value="1" />
        <div class="mb-xs">{lang key='couponFormDesc' section='checkout'}</div>
        <div class="input-group w100">
            <input type="text" name="Kuponcode"  maxlength="32" value="{if !empty($Kuponcode)}{$Kuponcode}{/if}" id="kupon" class="form-control" placeholder="{lang key='couponCodePlaceholder' section='checkout'}" aria-label="{lang key="couponCode" section="account data"}" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" required />
            <div class="input-group-btn">
                <input type="submit" value="{lang key='couponSubmit' section='checkout'}" class="submit btn btn-default" />
            </div>
        </div>
    </form>
{/if}
{/block}