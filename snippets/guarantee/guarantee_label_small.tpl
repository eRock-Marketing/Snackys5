{block name='snippets-guarantee-label-small'}
    {if $guaranteeLabel->isActive()}
        {include file='snippets/guarantee/guarantee_label_small_image.tpl'
            guaranteeYears=$guaranteeLabel->getYears()}
    {/if}
{/block}
