{block name='snippets-withdrawal-link'}
    {if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_ONLINE_WRB_FORMULAR])}
        <div class="mt-3">
            {button href=$oSpezialseiten_arr[$smarty.const.LINKTYP_ONLINE_WRB_FORMULAR]->getURL()
                    variant='primary'
                    class='btn-block btn-outline-primary btn-sm'}
                {lang key='withdrawalForm' section='global'}
            {/button}
        </div>
    {/if}
{/block}
