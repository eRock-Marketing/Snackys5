{block name='boxes-box-filter-search'}
    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}
        <section id="sidebox{$oBox->getID()}" class="box box-search-category panel small">
            <div class="h5 panel-heading dpflex-a-c">
                {lang key='searchFilter'}
                {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
            </div>
            {block name='boxes-box-filter-search-content'}
            <div class="panel-body">
                {include file='snippets/filter/search.tpl'}
            </div>
            {/block}
        </section>
    {/if}
{/block}
