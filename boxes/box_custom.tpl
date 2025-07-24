{block name='boxes-box-custom'}
{if $snackyConfig.filterPos == 1 && empty($oBox->getTitle()) && $oBox->getPosition() == 'left'}
{else}
    <section class="panel box box-custom box-normal" id="sidebox{$oBox->getID()}"}>
        {block name='boxes-box-custom-title'}
            <div class="h5 panel-heading dpflex-a-c">
                {$oBox->getTitle()}
                {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
            </div>
        {/block}
        <div class="panel-body">
            {eval var=$oBox->getContent()}
        </div>
    </section>
{/if}
{/block}
