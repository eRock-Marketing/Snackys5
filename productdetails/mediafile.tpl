{block name='productdetails-mediafile'}
{if !empty($Artikel->oMedienDatei_arr)}
    {assign var=mp3List value=false}
    {assign var=titles value=false}
    <div class="row row-multi">
    {foreach $Artikel->oMedienDatei_arr as $oMedienDatei}
        {if ($mediaType->name == $oMedienDatei->cMedienTyp
            && $oMedienDatei->cAttributTab|count_characters == 0)
            || ($oMedienDatei->cAttributTab|count_characters > 0
                && $mediaType->name|@seofy == $oMedienDatei->cAttributTab|@seofy)}
            {if $oMedienDatei->nErreichbar == 0}
                <div class="col-12">
                    <p class="alert alert-danger">
                        {lang key='noMediaFile' section='errorMessages'}
                    </p>
                </div>
            {else}
                {assign var=cName value=$oMedienDatei->cName}
                {assign var=titles value=$titles|cat:$cName}
                {if !$oMedienDatei@last}
                    {assign var=titles value=$titles|cat:'|'}
                {/if}

                {* Images *}
                {if $oMedienDatei->nMedienTyp == 1}
                    <div class="col-6 col-sm-4 col-md-3 col-lg3{if $snackyConfig.css_maxTabsWidth >= 1600} col-xl-2{/if}">
                        <div class="card">
                            <div class="card-header"><span class="h6 m0 block">{$oMedienDatei->cName}</h3></div>
                            <div class="card-body">
                                {if $oMedienDatei->cBeschreibung}<span class="block mb-xxs">{$oMedienDatei->cBeschreibung}</span>{/if}
                                {if isset($oMedienDatei->oMedienDateiAttribut_arr) && $oMedienDatei->oMedienDateiAttribut_arr|@count > 0}
                                    {foreach $oMedienDatei->oMedienDateiAttribut_arr as $oAttribut}
                                        {if $oAttribut->cName === 'img_alt'}
                                            {assign var=cMediaAltAttr value=$oAttribut->cWert}
                                        {/if}
                                    {/foreach}
                                {/if}
                                {if !empty($oMedienDatei->cPfad)}
                                    <img alt="{if isset($cMediaAltAttr)}{$cMediaAltAttr}{/if}" src="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" class="img-responsive" />
                                {elseif !empty($oMedienDatei->cURL)}
                                    <img alt="{if isset($cMediaAltAttr)}{$cMediaAltAttr}{/if}" src="{$oMedienDatei->cURL}" class="img-responsive" />
                                {/if}
                            </div>
                        </div>
                    </div>
                {* Audio *}
                {elseif $oMedienDatei->nMedienTyp == 2}
                    {if $oMedienDatei->cName|strlen > 1}
                        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                            <div class="card">
                                <div class="card-header"><span class="h6 m0 block">{$oMedienDatei->cName}</span></div>
                                <div class="card-body">
                                    {if $oMedienDatei->cBeschreibung}<span class="block mb-xxs">{$oMedienDatei->cBeschreibung}</span>{/if}
                                    {* Music *}
                                    {if $oMedienDatei->cPfad|strlen > 1 || $oMedienDatei->cURL|strlen > 1}
                                        {assign var=audiosrc value=$oMedienDatei->cURL}
                                        {if $oMedienDatei->cPfad|strlen > 1}
                                            {assign var=audiosrc value=$smarty.const.PFAD_MEDIAFILES|cat:$oMedienDatei->cPfad}
                                        {/if}
                                        {if $audiosrc|strlen > 1}
                                            <audio controls controlsList="nodownload">
                                                <source src="{$audiosrc}" type="audio/mpeg">
                                                {lang key='audioTagNotSupported' section='errorMessages'}
                                            </audio>
                                        {/if}
                                    {/if}
                                </div>
                            </div>
                        </div>
                        {* Audio *}
                    {/if}

                {* Video *}
                 {elseif $oMedienDatei->nMedienTyp === 3}
                        {block name='productdetails-mediafile-video'}
                        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                            <div class="card">
                                <div class="card-header"><span class="h6 m0 block">{$oMedienDatei->cName}</span></div>
                                <div class="card-body">
                                {if ($oMedienDatei->videoType === 'mp4' 
                                || $oMedienDatei->videoType === 'webm'
                                || $oMedienDatei->videoType === 'ogg')}
                                    <video class="product-detail-video" controls>
                                        <source src="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" type="video/{$oMedienDatei->videoType}">
                                        {lang key='videoTagNotSupported' section='errorMessages'}
                                    </video> 
                                {else}
                                    <div class="alert alert-info">{lang key='videoTypeNotSupported' section='errorMessages'}</div>
                                {/if}   
                                </div>
                            </div>
                        </div>
                        {/block}
                {* Sonstiges *}
                {elseif $oMedienDatei->nMedienTyp == 4}
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="card">
                            <div class="card-header"><span class="h6 m0 block">{$oMedienDatei->cName}</span></div>
                            <div class="card-body">
                                {if $oMedienDatei->cBeschreibung}<span class="block mb-xxs">{$oMedienDatei->cBeschreibung}</span>{/if}
                                {if $oMedienDatei->cURL|strpos:'youtube' !== false || $oMedienDatei->cURL|strpos:'youtu.be' !== false}
                                    {include file='productdetails/mediafile_youtube_embed.tpl'}
                                {else}
                                    {if isset($oMedienDatei->oEmbed) && $oMedienDatei->oEmbed->code}
                                        {$oMedienDatei->oEmbed->code}
                                    {/if}
                                    {if !empty($oMedienDatei->cPfad)}
                                        <a href="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" target="_blank" class="td-u">{$oMedienDatei->cName}</a>
                                    {elseif !empty($oMedienDatei->cURL)}
                                        <a href="{$oMedienDatei->cURL}" target="_blank" class="td-u"><i class="fa fa-external-link"></i> {$oMedienDatei->cName}</a>
                                    {/if}
                                {/if}
                            </div>
                        </div>
                    </div>
                    {* PDF *}
                {elseif $oMedienDatei->nMedienTyp == 5}
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="card">
                            <div class="card-header"><span class="h6 m0 block">{$oMedienDatei->cName}</span></div>
                            <div class="card-body">
                                    {if $oMedienDatei->cBeschreibung}<span class="block mb-xxs">{$oMedienDatei->cBeschreibung}</span>{/if}
                                    {if !empty($oMedienDatei->cPfad)}
                                        <a href="{$ShopURL}/{$smarty.const.PFAD_MEDIAFILES}{$oMedienDatei->cPfad}" target="_blank" class="dpflex-a-c">
                                            <span class="img-ct icon icon-xl icon-wt">
                                                <img alt="PDF" src="{$ShopURL}/{$smarty.const.PFAD_BILDER}intern/file-pdf.png" />
                                            </span>
                                            {$oMedienDatei->cName}
                                        </a>
                                    {elseif !empty($oMedienDatei->cURL)}
                                        <a href="{$oMedienDatei->cURL}" target="_blank" class="dpflex-a-c">
                                            <span class="img-ct icon icon-xl icon-wt">
                                                <img alt="PDF" src="{$ShopURL}/{$smarty.const.PFAD_BILDER}intern/file-pdf.png" />
                                            </span>
                                            {$oMedienDatei->cName}
                                        </a>
                                    {/if}
                            </div>
                        </div>
                    </div>
                {/if}
            {/if}
        {/if}
    {/foreach}
    </div>
{/if}
{/block}
