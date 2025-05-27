{block name='productdetails-uploads'}
{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

{if !empty($oUploadSchema_arr)}
    <script type="text/javascript" src="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/fileinput.min.js" defer></script>
    {assign var=availableLocale value=array('ar', 'bg', 'cr', 'cz', 'da', 'de', 'el', 'es', 'fa', 'fr', 'hu', 'lt', 'nl', 'pl', 'pt', 'sk', 'uk')}
    {if isset($smarty.session.currentLanguage->cISO639) && $smarty.session.currentLanguage->cISO639|in_array:$availableLocale}
        {assign var=uploaderLang value=$smarty.session.currentLanguage->cISO639}
    {else}
        {assign var=uploaderLang value='en'}
    {/if}
    <script type="text/javascript" src="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/fileinput_locale_{$uploaderLang}.js" defer></script>

    <link href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}themes/base/fileinput.min.css" rel="stylesheet" type="text/css">
    <div class="panel-heading">
        <span class="block h5 panel-title m0">{lang key="uploadHeadline"}</span>
    </div>
    <p class="small alert alert-info">{lang key="maxUploadSize"}: <strong>{$cMaxUploadSize}</strong></p>
    {foreach from=$oUploadSchema_arr item=oUploadSchema name=schema}
        <div class="card">
            <div class="card-header">
                    {$oUploadSchema->cName}
                    {if !empty($oUploadSchema->WarenkorbPosEigenschaftArr)}
                        <small>
                            {foreach name=variationen from=$oUploadSchema->WarenkorbPosEigenschaftArr item=Variation}
                                - {$Variation->cEigenschaftName|trans}: {$Variation->cEigenschaftWertName|trans}
                            {/foreach}
                        </small>
                    {/if}
            </div>
            <div class="card-body">
                {foreach from=$oUploadSchema->oUpload_arr item=oUpload name=upload}
                    <div class="row">
                        {if !empty($oUpload->cName) || !empty($oUpload->cBeschreibung)}
                            <div class="col-12">
                                {if !empty($oUpload->cName)}
                                    <p class="upload_title">{$oUpload->cName}</p>
                                {/if}
                                {if !empty($oUpload->cBeschreibung)}
                                    <p class="upload_desc">{$oUpload->cBeschreibung}</p>
                                {/if}
                            </div>
                        {/if}
                        <div class="col-12 word-break text-right">
                            <div id="queue{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}" style="margin-bottom: 15px;" class="uploadifyMsg">
                                <span class="current-upload small text-success">
                                    {if $oUpload->bVorhanden}
                                        <i class="fa fa-check" aria-hidden="true"></i>
                                        {$oUpload->cDateiname} ({$oUpload->cDateigroesse})
                                    {/if}
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="text-center
                                {if isset($smarty.get.fillOut) && $smarty.get.fillOut == 12 && ($oUpload->nPflicht
                                    && !$oUpload->bVorhanden)} upload-error{/if}"
                                 id="upload-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}">
                                <input id="fileinput{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}"
                                    type="file" multiple class="file-upload file-loading" />
                                <div id="kv-error-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}"
                                    style="margin-top:10px; display:none;"></div>
                            </div>
							{inline_script}
                            <script type="text/javascript">
                                $(function () {ldelim}
                                    $('#fileinput{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}').fileinput({
                                        uploadUrl:             '{$ShopURL}/{$PFAD_UPLOAD_CALLBACK}',
                                        uploadAsync:           true,
                                        showPreview:           false,
                                        showRemove:            false,
                                        allowedFileExtensions: [{$oUpload->cDateiListe|replace:'*.':'\''|replace:';':'\','|cat:'\''}],
                                        language:              '{$uploaderLang}',
                                        uploadExtraData:       {
                                            sid:        "{$cSessionID}",
                                            jtl_token:  "{$smarty.session.jtl_token}",
                                            uniquename: "{$oUpload->cUnique}",
                                            uploader:   "4.00",
                                            cname:      "{$oUploadSchema->cName|replace:" ":"_"}"
                                            {if !empty($oUploadSchema->WarenkorbPosEigenschaftArr)},
                                            variation:  "{strip}
                                            {foreach name=variationen from=$oUploadSchema->WarenkorbPosEigenschaftArr item=Variation}_{$Variation->cEigenschaftWertName|trans|replace:" ":"_"}{/foreach}
                                                "{/strip}
                                            {/if}
                                        },
                                        maxFileSize:           {$nMaxUploadSize/1024},
                                        elErrorContainer:      '#kv-error-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}',
                                        maxFilesNum:           1
                                    }).on('fileuploaded', function(event, data) {
                                        var ip = $('#fileinput{$smarty.foreach.schema.index}{$smarty.foreach.upload.index}'),
                                            msgField = $('#queue{$smarty.foreach.schema.index}{$smarty.foreach.upload.index} .current-upload'),
                                            uploadMsgField = $('.uploadifyMsg');
                                        if (typeof data.response !== 'undefined' && typeof data.response.cName !== 'undefined') {
                                            msgField.html('<i class="fa fa-check" aria-hidden="true"></i>' + data.response.cName + ' (' + data.response.cKB + ' KB)');
                                        } else {
                                            msgField.html('{lang key="uploadError"}');
                                        }
                                        $('#msgWarning').hide();
                                        uploadMsgField.find('.alert-danger').hide();
                                        $('#cart-form').find('.upload-error').removeClass('upload-error');
                                        ip.fileinput('reset');
                                        ip.fileinput('refresh');
                                        ip.fileinput('clear');
                                        ip.fileinput('enable');
                                    }).on('fileuploaderror', function() {
                                        $('#upload-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index} .fileinput-upload').addClass('disabled');
                                    }).on('fileloaded', function() {
                                        $('#upload-{$smarty.foreach.schema.index}{$smarty.foreach.upload.index} .fileinput-upload').removeClass('disabled');
                                    });
                                    {rdelim});
                            </script>
							{/inline_script}
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    {/foreach}
{/if}
{/block}