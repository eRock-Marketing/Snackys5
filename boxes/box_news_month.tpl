{block name='boxes-box-news-month'}
    <section class="box box-monthlynews box-normal panel" id="sidebox{$oBox->getID()}">
        {block name='boxes-box-news-month-content'}
            {block name='boxes-box-news-month-title'}
                <div class="h5 panel-heading dpflex-a-c">
                    {lang key='newsBoxMonthOverview'}
                    {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                </div>
            {/block}
            {block name='boxes-box-news-month-collapse'}
            <div class="panel-body">
                <ul class="nav blanklist">
                    {foreach $oBox->getItems() as $newsMonth}
                        {block name='boxes-box-news-month-news-link'}
                            <li class="nav-it">
                                <a href="{$newsMonth->cURL}" title="{$newsMonth->cName}" class="dpflex">
                                    <span class="name">{$newsMonth->cName}</span>
                                    <span class="ctr">{$newsMonth->nAnzahl}</span>
                                </a>
                            </li>
                        {/block}
                    {/foreach}
                </ul>
            </div>
            {/block}
        {/block}
    </section>
{/block}
