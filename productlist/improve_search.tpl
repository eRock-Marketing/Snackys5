{block name='productlist-improve-search'}
{assign var=ismobile value=false}
{if $isMobile && !$isTablet}
    {assign var=ismobile value=true}
{/if}
    {block name='productlist-sorting-options'}
    {if count($Suchergebnisse->getSortingOptions()) > 0}
        <div class="col-12{if !$isMobile} col-sm-12 col-md-6 col-lg-4{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-3{/if}{/if}">
            {include file='productlist/result_options.tpl'}
        </div>
    {/if}
    {/block}
    {block name='productlist-layout-options'}
        {if isset($oErweiterteDarstellung->nDarstellung)
        && $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung === 'Y'
        && empty($AktuelleKategorie->categoryFunctionAttributes['darstellung']) && !$isMobile}
            <div class="col-12 col-sm-12 col-md-6 col-lg-4{if $snackyConfig.css_maxPageWidth >= 1600} col-xl-3{/if}">
            {buttongroup class="form-group l-op"}
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
                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-pll"></use>
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
                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-plg"></use>
                        </svg>
                    </div>
                    {/link}
                {/block}
            {/buttongroup}
            </div>
        {/if}
    {/block}
{/block}