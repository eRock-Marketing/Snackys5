{block name='boxes-box-filter-rating'}
    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}
        <section id="sidebox{$oBox->getID()}" class="box box-filter-rating panel small">
            <div class="h5 panel-heading dpflex-a-c">
                {lang key='Votes'}
                {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
            </div>
            {block name='boxes-box-filter-rating-content'}
            <div class="panel-body">
                {include file='snippets/filter/genericFilterItem.tpl' filter=$oBox->getItems()}
            </div>
            {/block}
        </section>
    {/if}
{/block}
