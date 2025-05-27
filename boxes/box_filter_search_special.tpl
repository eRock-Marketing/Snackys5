{block name='boxes-box-filter-search-special'}
    {assign var=ssf value=$NaviFilter->getSearchSpecialFilter()}
    {if $bBoxenFilterNach
        && $ssf->getVisibility() !== \JTL\Filter\Visibility::SHOW_NEVER
        && $ssf->getVisibility() !== \JTL\Filter\Visibility::SHOW_CONTENT
        && (!empty($Suchergebnisse->getSearchSpecialFilterOptions()) || $ssf->isInitialized())}
        {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}
            <section id="sidebox{$oBox->getID()}" class="box box-filter-special panel">
					{block name='boxes-box-filter-search-special-headline'}
						<div class="h5 panel-heading flx-ac">
							{$ssf->getFrontendName()}
							{if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
						</div>
					{/block}
                    {block name='boxes-box-filter-search-special-content'}
						<div class="panel-body">
							{include file='snippets/filter/genericFilterItem.tpl' filter=$ssf}
						</div>
                    {/block}
            </section>
        {/if}
    {/if}
{/block}
