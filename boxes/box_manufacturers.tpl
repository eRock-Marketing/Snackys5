{block name='boxes-box-manufacturers'}
    <section class="box box-manufacturers box-normal panel" id="sidebox{$oBox->getID()}">
        {block name='boxes-box-manufacturers-content'}
            {block name='boxes-box-manufacturers-title'}
                <div class="h5 panel-heading flx-ac">
                    {lang key='manufacturers'}
                    {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                </div>
            {/block}
            {block name='boxes-box-manufacturers-collapse'}
                <div class="panel-body">
                    <ul class="nav blanklist">
                        {foreach $oBox->getManufacturers() as $manufacturer}
                            <li class="nav-it">
                                <a href="{$manufacturer->getURL()}" title="{$manufacturer->getName()|escape:'html'}" class="flx">
                                    <span class="name">{$manufacturer->getName()|escape:'html'}</span>
                                </a>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            {/block}
        {/block}
    </section>
{/block}
