{block name='boxes-box-categories'}
    <section class="panel box box-categories word-break" id="sidebox-categories-{$oBox->getID()}">
        {block name='boxes-box-categories-content'}
            {block name='boxes-box-categories-title'}
                <div class="h5 panel-heading dpflex-a-center">
                    {if !empty($oBox->getTitle())}{$oBox->getTitle()}{else}{lang key='categories'}{/if}
                    {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                </div>
            {/block}
            {block name='boxes-box-categories-collapse'}
            <div class="panel-body">
                <ul class="nav blanklist">
                    {block name='boxes-box-categories-include-categories-recursive'}
                        {include file='snippets/categories_recursive.tpl'
                            i=0
                            categoryId=0
                            categoryBoxNumber=$oBox->getCustomID()
                            limit=3
                            categories=$oBox->getItems()
                            id=$oBox->getID()}
                    {/block}
                </ul>
            </div>
            {/block}
        {/block}
    </section>
{/block}
