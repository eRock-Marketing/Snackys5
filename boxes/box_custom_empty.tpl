{block name='boxes-box-custom-empty'}
{if $snackyConfig.filterPos == 1 && $oBox->getPosition() == 'left'}
{else}
    <section class="panel box box-custom box-normal" id="sidebox{$oBox->getID()}"}>
        {block name='boxes-box-custom-empty-content'}
            {eval var=$oBox->getContent()}
        {/block}
    </section>
{/if}
{/block}
