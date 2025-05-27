{block name='snippets-banner'}
{if isset($oImageMap)}
	{include file="snippets/zonen.tpl" id="opc_before_banner"}
    <div class="banner">
        {block name="banner-map"}
            {if ($snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5) && $nSeitenTyp === 18 && $snackyConfig.fullscreenElement == 2}
                {image lazy=true src=$oImageMap->cBildPfad alt=$oImageMap->cTitel width=$oImageMap->fWidth height=$oImageMap->fHeight}
            {else}
                {image fluid=true lazy=true src=$oImageMap->cBildPfad alt=$oImageMap->cTitel width=$oImageMap->fWidth height=$oImageMap->fHeight}
                {foreach $oImageMap->oArea_arr as $oImageMapArea}
                    {strip}
                    <{if !$isMobile}a href="{$oImageMapArea->cUrl}"{else}span{/if} class="area {$oImageMapArea->cStyle}" style="left:{math equation="(100/bWidth)*posX" bWidth=$oImageMap->fWidth posX=$oImageMapArea->oCoords->x}%;top:{math equation="(100/bHeight)*posY" bHeight=$oImageMap->fHeight posY=$oImageMapArea->oCoords->y}%;width:{math equation="(100/bWidth)*aWidth" bWidth=$oImageMap->fWidth aWidth=$oImageMapArea->oCoords->w}%;height:{math equation="(100/bHeight)*aHeight" bHeight=$oImageMap->fHeight aHeight=$oImageMapArea->oCoords->h}%" title="{$oImageMapArea->cTitel|strip_tags|escape:'html'|escape:'quotes'}">
                        {if $oImageMapArea->oArtikel || $oImageMapArea->cBeschreibung|strlen > 0}
                            {assign var="oArtikel" value=$oImageMapArea->oArtikel}
                            <{if $isMobile}a href="{$oImageMapArea->cUrl}"{else}div{/if} class="area-desc">
                                <div class="inside text-center pr">
                                    {if $oImageMapArea->cTitel|strip_tags|escape:"html"|escape:"quotes"|@strlen > 0}
                                     <span class="block h4">{$oImageMapArea->cTitel|strip_tags|escape:"html"|escape:"quotes"}</span>
                                    {/if}
                                    {if $oImageMapArea->oArtikel !== null}
                                        <div class="img-ct">
                                            {include file='snippets/image.tpl' item=$oArtikel square=false class="img-responsive center-block"}
                                        </div>
                                    {/if}
                                    {if $oImageMapArea->oArtikel !== null}
                                        {include file="productdetails/price.tpl" Artikel=$oArtikel tplscope="box"}
                                    {/if}
                                    {if $oImageMapArea->cBeschreibung|strlen > 0}
                                        <p>
                                            {$oImageMapArea->cBeschreibung}
                                        </p>
                                    {/if}
                                </div>
                            {if $isMobile}</a>{else}</div>{/if}
                        {/if}
                    {if !$isMobile}</a>{else}</span>{/if}
                    {/strip}
                {/foreach}
            {/if}
        {/block}
    </div>
{/if}
{/block}