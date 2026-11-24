{block name='snippets-guarantee-label-small'}
    {if $guaranteeLabel->isActive()}
        {include file='snippets/guarantee/guarantee_label_image.tpl'
            guaranteeYears=$guaranteeLabel->getYears()
            guaranteeManufacturer=$guaranteeLabel->getManufacturer()
            guaranteeIdentifier=$guaranteeLabel->getModelIdentifier()}
    {/if}
{/block}
