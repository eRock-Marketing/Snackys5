{block name='snippets-withdrawal-link'}
    {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_ONLINE_WRB_FORMULAR])}
        {if $snackyConfig.widerrufPosition == 0 && $nSeitenTyp != 11}
            {button href=$oSpezialseiten_arr[$smarty.const.LINKTYP_ONLINE_WRB_FORMULAR]->getURL()
                    variant='primary'
                    class='btn-block btn-outline-primary btn-sm'}
                {lang key='withdrawalForm' section='global'}
            {/button}
        {else}
            {button href=$oSpezialseiten_arr[$smarty.const.LINKTYP_ONLINE_WRB_FORMULAR]->getURL()
                    variant='primary'
                    class='btn-outline-primary btn-sm'}
                {lang key='withdrawalForm' section='global'}
            {/button}
        {/if}
    {/if}
{/block}
