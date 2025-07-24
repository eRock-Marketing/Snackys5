{block name='boxes-box-news-categories'}
    <section class="box box-newscategories box-normal panel" id="sidebox{$oBox->getID()}">
        {block name='boxes-box-news-categories-content'}
            {block name='boxes-box-news-categories-title'}
                <div class="h5 panel-heading dpflex-a-c">
                    {lang key='newsBoxCatOverview'}
                    {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                </div>
            {/block}
            {block name='boxes-box-news-categories-collapse'}
            <div class="panel-body">
                <ul class="nav blanklist">
                    {foreach $oBox->getItems() as $newsCategory}
                        {if $newsCategory@index === 10}{break}{/if}
                        <li class="nav-it">
                            <a href="{$newsCategory->cURLFull}" title="{$newsCategory->cName}" class="dpflex">
                                <span class="name">{$newsCategory->cName}</span>
                                <span class="ctr">{$newsCategory->nAnzahlNews}</span>
                            </a>
                        </li>
                    {/foreach}
                </ul>
            </div>
            {/block}
        {/block}
    </section>
{/block}
