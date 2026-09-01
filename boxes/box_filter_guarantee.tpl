{block name='boxes-box-filter-guarantee'}
    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}
        <section id="sidebox{$oBox->getID()}" class="box box-filter-guarantee panel">
            {block name='boxes-box-filter-guarantee-headline'}
                <div class="h5 panel-heading flx-ac">
                    {lang key='filterGuarantee'}
                    {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                </div>
            {/block}
            {block name='boxes-box-filter-guarantee-content'}
                <div class="panel-body">
                    {include file='snippets/filter/genericFilterItem.tpl' filter=$oBox->getItems()}
                </div>
            {/block}
        </section>
    {/if}
{/block}