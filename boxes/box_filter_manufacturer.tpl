{block name='boxes-box-filter-manufacturer'}
    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}
        <section id="sidebox{$oBox->getID()}" class="box box-filter-manufacturer panel small">
			{block name='boxes-box-filter-manufacturer-headline'}
				<div class="h5 panel-heading flx-ac">
					{lang key='manufacturers'}
					{if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
				</div>
			{/block}
            {block name='boxes-box-filter-manufacturer-include-manufacturer'}
				<div class="panel-body">
					{include file='snippets/filter/manufacturer.tpl' filter=$oBox->getItems()}
				</div>
            {/block}
        </section>
    {/if}
{/block}