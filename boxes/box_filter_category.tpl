{block name='boxes-box-filter-category'}
    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}
        <section id="sidebox{$oBox->getID()}" class="box box-filter-category panel">
            <div class="h5 panel-heading dpflex-a-c">
                {$oBox->getTitle()}
                {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
            </div>
            <div class="panel-body">
                {block name='boxes-box-filter-category-content'}
                    {include file='snippets/filter/genericFilterItem.tpl' filter=$oBox->getItems()}
                {/block}
            </div>
        </section>
    {/if}
{/block}
