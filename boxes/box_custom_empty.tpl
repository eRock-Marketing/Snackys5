{block name='boxes-box-custom-empty'}
    <section class="panel box box-custom box-normal" id="sidebox{$oBox->getID()}">
        {block name='boxes-box-custom-empty-content'}
            {eval var=$oBox->getContent()}
        {/block}
    </section>
{/block}