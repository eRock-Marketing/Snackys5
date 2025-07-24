{block name='boxes-box-filter-characteristics'}
    {if $nSeitenTyp === $smarty.const.PAGE_ARTIKELLISTE}
        {foreach $oBox->getItems() as $characteristic}
            <section id="sidebox{$oBox->getID()}-{$characteristic->getID()}" class="box box-filter-characteristics panel">
                <div class="h5 dpflex-a-center panel-heading dpflex-a-c">
                    {$img = $characteristic->getImage(\JTL\Media\Image::SIZE_XS)}
                    {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T'
                    && $img !== null
                    && $img|strpos:$smarty.const.BILD_KEIN_MERKMALBILD_VORHANDEN === false
                    && $img|strpos:$smarty.const.BILD_KEIN_ARTIKELBILD_VORHANDEN === false}
                        <span class="img-ct icon ic-lg icon-wt">
                        {include file='snippets/image.tpl'
                            item=$characteristic
                            square=false
                            class='img-xs'
                            srcSize='xs'
                            sizes='24px'}
                        </span>
                    {/if}
                    {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'B'}
                        {$characteristic->getName()}
                    {/if}
                    {if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
                </div>
                <div class="panel-body">
                    {block name='boxes-box-filter-characteristics-characteristics'}
                        {if ($characteristic->getData('cTyp') === 'SELECTBOX') && $characteristic->getOptions()|@count > 0}
                            {block name='boxes-box-filter-characteristics-select'}
                                {dropdown variant="outline-secondary" text="{lang key='selectFilter' section='global'} " toggle-class="btn-block text-left-util btn-sm"}
                                {block name='boxes-box-filter-characteristics-include-characteristics-dropdown'}
                                    {include file='snippets/filter/characteristic.tpl' Merkmal=$characteristic}
                                {/block}
                                {/dropdown}
                            {/block}
                        {else}
                            {block name='boxes-box-filter-characteristics-link'}
                                {block name='boxes-box-filter-characteristics-include-characteristics-link'}
                                    {include file='snippets/filter/characteristic.tpl' Merkmal=$characteristic}
                                {/block}
                            {/block}
                        {/if}
                    {/block}
                </div>
            </section>
        {/foreach}
    {/if}
{/block}
