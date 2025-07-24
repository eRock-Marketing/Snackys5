{block name='snippets-currency-dropdown'}
    {$allCurrencies = JTL\Session\Frontend::getCurrencies()}
    {$currentCurrency = JTL\Session\Frontend::getCurrency()}
    {if $allCurrencies|count > 1}
        {navitemdropdown
            class="currency-dropdown"
            right=true
            text=$currentCurrency->getName()}
            {foreach $allCurrencies as $currency}
                {dropdownitem href=$currency->getURLFull() rel="nofollow"
                    active=($currentCurrency->getName() === $currency->getName())}
                    {$currency->getName()}
                {/dropdownitem}
            {/foreach}
        {/navitemdropdown}
    {/if}
{/block}
