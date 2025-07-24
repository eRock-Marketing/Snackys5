{block name='productlist-improve-search'}
{assign var=ismobile value=false}
{if $isMobile && !$isTablet}
    {assign var=ismobile value=true}
{/if}
<div id="improve_search"{if !$ismobile} class="dpflex-j-end right dpflex-a-c"{/if}>
    {block name='productlist-layout-options'}
        {if isset($oErweiterteDarstellung->nDarstellung)
        && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung === 'Y'
        && empty($AktuelleKategorie->categoryFunctionAttributes['darstellung'])}
            {buttongroup class="form-group"}
                {block name='productlist-layout-options-quare'}
                    {link href=$oErweiterteDarstellung->cURL_arr[$smarty.const.ERWDARSTELLUNG_ANSICHT_LISTE]
                        id="ed_list"
                        class="btn btn-outline-secondary btn-option ed list{if $oErweiterteDarstellung->nDarstellung === $smarty.const.ERWDARSTELLUNG_ANSICHT_LISTE} active{/if}"
                        role="button"
                        title="{lang key='list' section='productOverview'}"
                        aria=["label"=>{lang key='list' section='productOverview'}]
                    }
                    <div class="img-ct icon">
                        <svg class="{if $oErweiterteDarstellung->nDarstellung === $smarty.const.ERWDARSTELLUNG_ANSICHT_LISTE}icon-darkmode{/if}">
                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-pll"></use>
                        </svg>
                    </div>
                    {/link}
                {/block}
                {block name='productlist-layout-options-list'}
                    {link href=$oErweiterteDarstellung->cURL_arr[$smarty.const.ERWDARSTELLUNG_ANSICHT_GALERIE]
                        id="ed_gallery"
                        class="btn btn-outline-secondary btn-option ed icon-wt gallery{if $oErweiterteDarstellung->nDarstellung === $smarty.const.ERWDARSTELLUNG_ANSICHT_GALERIE} active{/if}"
                        role="button"
                        title="{lang key='gallery' section='productOverview'}"
                        aria=["label"=>{lang key='gallery' section='productOverview'}]
                    }
                    <div class="img-ct icon">
                        <svg class="{if $oErweiterteDarstellung->nDarstellung === $smarty.const.ERWDARSTELLUNG_ANSICHT_GALERIE}icon-darkmode{/if}">
                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-plg"></use>
                        </svg>
                    </div>
                    {/link}
                {/block}
            {/buttongroup}
        {/if}
    {/block}
    {if !$ismobile}
        <div class="hidden-xs ml-xxs">
        {include file='productlist/result_options.tpl'}
        </div>
    {else}
        {include file='productlist/result_options.tpl'}
    {/if}
</div>
{/block}