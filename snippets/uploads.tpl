{block name='snippets-uploads'}
    {if !empty($oUploadSchema_arr)}
        {getUploaderLang iso=$smarty.session.currentLanguage->cISO639|default:'' assign='uploaderLang'}
        {if $tplscope === 'product' && !empty($Artikel) && !($Artikel->nIstVater || $Artikel->kVaterArtikel > 0 || $Artikel->isSimpleVariation || $Artikel->bHasKonfig)}
        <div class="small mt-xs mb-xs" id="dt-upload">
            {block name='snippets-uploads-subheading-product'}
                <div class="h5 section-heading">{lang key='uploadHeadline'}</div>
            {/block}
            {block name='snippets-uploads-alert-product'}
                {alert variant="info" class="m0"}
                    {lang key='maxUploadSize'}: <strong>{$cMaxUploadSize}</strong>
                {/alert}
            {/block}
            {block name='snippets-uploads-schemes-product'}
                {foreach $oUploadSchema_arr as $oUploadSchema}
                    {row class="upload-scheme-product mt-xs"}
                        {if !empty($oUploadSchema->cName) || !empty($oUploadSchema->cBeschreibung)}
                            {block name='snippets-uploads-scheme-product-name'}
                                {col cols=12}
                                    {if !empty($oUploadSchema->cName)}
                                        <div class="h6 upload_title m0">{$oUploadSchema->cName}</div>
                                    {/if}
                                    {if !empty($oUploadSchema->cBeschreibung)}
                                        <small class="upload_desc block mt-xxs">{$oUploadSchema->cBeschreibung}</small>
                                    {/if}
                                {/col}
                            {/block}
                        {/if}

                        {block name='snippets-uploads-scheme-product-data-main'}
                            {col cols=12}
                                {block name='snippets-uploads-scheme-product-input'}
                                    <div class="text-center-util
                                        {if isset($smarty.get.fillOut) && $smarty.get.fillOut == 12 && ($oUploadSchema->nPflicht
                                    && !$oUploadSchema->bVorhanden)} upload-error{/if}"
                                         id="upload-{$oUploadSchema@index}">
                                        <input id="fileinput{$oUploadSchema@index}"
                                               type="file" class="file-upload file-loading" />
                                        <div id="kv-error-{$oUploadSchema@index}"
                                             style="margin-top:10px; display:none;"></div>
                                    </div>
                                {/block}
                                {block name='snippets-uploads-scheme-product-script'}
                                    {inline_script}<script>
                                        var clientUploadErrorIsActive = false;
                                        $(function () {
                                            var $el =  $('#fileinput{$oUploadSchema@index}');
                                            $el.fileinput({
                                                uploadUrl:             '{$ShopURL}/{$smarty.const.PFAD_UPLOAD_CALLBACK}',
                                                uploadAsync:           false,
                                                showPreview:           true,
                                                showUpload:            false,
                                                showRemove:            false,
                                                browseClass:           'btn btn-light',
                                                fileActionSettings:    {
                                                    showZoom: false,
                                                    showRemove: false
                                                },
                                                allowedFileExtensions: [{$oUploadSchema->cDateiListe|replace:'*.':'\''|replace:';':'\','|cat:'\''}],
                                                language:              '{$uploaderLang}',
                                                theme:                 'fas',
                                                browseOnZoneClick:     true,
                                                uploadExtraData:       {
                                                    sid:        "{$cSessionID}",
                                                    kUploadSchema:"{$oUploadSchema->kUploadSchema}",
                                                    jtl_token:  "{$smarty.session.jtl_token}",
                                                    uniquename: "{$oUploadSchema->cUnique}",
                                                    uploader:   "4.00",
                                                    prodID:     "{$oUploadSchema->prodID}",
                                                    cname:      "{$Artikel->cName|replace:" ":"_"}_{$oUploadSchema->cName|replace:" ":"_"}"
                                                    {if !empty($oUploadSchema->WarenkorbPosEigenschaftArr)},
                                                    variation:  "{strip}
                                                    {foreach name=variationen from=$oUploadSchema->WarenkorbPosEigenschaftArr item=Variation}_{$Variation->cEigenschaftWertName|trans|replace:" ":"_"}{/foreach}
                                                        "{/strip}
                                                    {/if}
                                                },
                                                maxFileSize:           {$nMaxUploadSize/1024},
                                                elErrorContainer:      false,
                                                maxFilesNum:           1
                                            }).on("filebrowse", function(event, files) {
                                                clientUploadErrorIsActive = false;
                                                $el.fileinput('clear');
                                            }).on("filebatchselected", function(event, files) {
                                                $el.fileinput("upload");
                                            }).on('filebatchuploadsuccess', function(event, data) {
                                                clientUploadErrorIsActive = false;
                                                let msgField = $('#queue{$oUploadSchema@index} .current-upload'),
                                                    uploadMsgField = $('.uploadifyMsg');
                                                msgField.removeClass('text-danger').addClass('text-success');
                                                if (typeof data.response !== 'undefined' && typeof data.response.cName !== 'undefined') {
                                                    msgField.removeClass('text-danger').addClass('text-success');
                                                    msgField.html('<i class="check" aria-hidden="true"></i>' + data.response.cName + ' (' + data.response.cKB + ' KB)');
                                                } else {
                                                    msgField.removeClass('text-success').addClass('text-danger');
                                                    msgField.html('{lang key='uploadError'}');
                                                    msgField.removeClass('text-success').addClass('text-danger');
                                                    $el.fileinput('clear');
                                                }
                                                $('#msgWarning').hide();
                                                uploadMsgField.find('.alert-danger').hide();
                                                $('#buy-form').find('.upload-error').removeClass('upload-error');
                                            }).on('filebatchuploaderror', function(event, data, msg) {
                                                if(clientUploadErrorIsActive === false){
                                                    let msgField = $('#queue{$oUploadSchema@index} .current-upload');
                                                    let message  = '{lang key='uploadError'}';
                                                    let status;
                                                    try{
                                                        let response =JSON.parse(msg);
                                                        status = response.status;
                                                    }catch(e){
                                                        status = 'response_error';
                                                    }
                                                    switch(status){
                                                        case 'reached_limit_per_hour':
                                                            message = '{lang key='uploadErrorReachedLimitPerHour'}';
                                                            break;
                                                        case 'filetype_forbidden':
                                                            message = '{lang key='uploadErrorFiletypeForbidden'}';
                                                            break;
                                                        case 'extension_not_listed':
                                                            message = '{lang key='uploadErrorExtensionNotListed'}';
                                                            break;
                                                    }
                                                    msgField.html(message);
                                                    msgField.removeClass('text-success').addClass('text-danger');
                                                    $el.fileinput('clear');
                                                }
                                            }).on('fileuploaderror', function(event, data, msg) {
                                                clientUploadErrorIsActive = true;
                                                let msgField = $('#queue{$oUploadSchema@index} .current-upload');
                                                msgField.html(msg);
                                                msgField.removeClass('text-success').addClass('text-danger');
                                                $el.fileinput('clear');
                                                $('#upload-{$oUploadSchema@index} .fileinput-upload').addClass('disabled');
                                            }).on('fileloaded', function() {
                                                $('#upload-{$oUploadSchema@index} .fileinput-upload').removeClass('disabled');
                                            });
                                        });
                                    </script>{/inline_script}
                                {/block}
                            {/col}
                        {/block}
                        {block name='snippets-uploads-scheme-product-filedata'}
                            {col cols=12 class="word-break text-right-util"}
                                <div id="queue{$oUploadSchema@index}" style="margin-bottom: 15px;" class="uploadifyMsg">
                                    <span class="current-upload small text-success">
                                        {if $oUploadSchema->bVorhanden}
                                            <i class="check" aria-hidden="true"></i>
                                            {$oUploadSchema->cDateiname} ({$oUploadSchema->cDateigroesse})
                                        {/if}
                                    </span>
                                </div>
                            {/col}
                        {/block}
                    {/row}
                {/foreach}
            {/block}
        </div>
        {elseif $tplscope === 'basket'}
            {block name='snippets-uploads-subheading'}
                <div class="h5 section-heading">{lang key='uploadHeadline'}</div>
            {/block}
            {block name='snippets-uploads-schemes'}
                {foreach $oUploadSchema_arr as $oUploadSchema}
                    <div class="upload-scheme-cart">
                        {block name='snippets-uploads-scheme-name'}
                            <span class="upload-scheme-cart-name h6 block m0">
                                {$oUploadSchema->cName}
                                {if !empty($oUploadSchema->WarenkorbPosEigenschaftArr)}
                                    <small>
                                        {foreach name=variationen from=$oUploadSchema->WarenkorbPosEigenschaftArr item=Variation}
                                            - {$Variation->cEigenschaftName|trans}: {$Variation->cEigenschaftWertName|trans}
                                        {/foreach}
                                    </small>
                                {/if}
                            </span>
                        {/block}
                        {block name='snippets-uploads-scheme-uploads'}
                            {foreach $oUploadSchema->oUpload_arr as $oUpload}
                                {row class="upload-scheme-cart-upload mt-xxs"}
                                    {if !empty($oUpload->cName) || !empty($oUpload->cBeschreibung)}
                                        {block name='snippets-uploads-scheme-upload-name-desc'}
                                            {col cols=12}
                                                {if !empty($oUpload->cName)}
                                                    <strong class="upload_title block">{$oUpload->cName}</strong>
                                                {/if}
                                                {if !empty($oUpload->cBeschreibung)}
                                                    <small class="upload_desc block">{$oUpload->cBeschreibung}</small>
                                                {/if}
                                            {/col}
                                        {/block}
                                    {/if}
                                    {block name='snippets-uploads-scheme-upload-filedata-main'}
                                        {col cols=12 class="word-break text-right-util"}
                                            {block name='snippets-uploads-scheme-upload-filedata'}
                                                <div id="queue{$oUploadSchema@index}{$oUpload@index}" style="margin-bottom: 15px;" class="uploadifyMsg">
                                                        <span class="current-upload small text-success">
                                                            {if $oUpload->bVorhanden}
                                                                <i class="check" aria-hidden="true"></i>
                                                                {$oUpload->cDateiname} ({$oUpload->cDateigroesse})
                                                            {/if}
                                                        </span>
                                                </div>
                                                <div class="text-center-util {if isset($smarty.get.fillOut) && $smarty.get.fillOut == 12 && ($oUpload->nPflicht
                                                && !$oUpload->bVorhanden)} upload-error{/if}"
                                                     id="upload-{$oUploadSchema@index}{$oUpload@index}">
                                                    <input id="fileinput{$oUploadSchema@index}{$oUpload@index}"
                                                           type="file" class="file-upload file-loading"/>
                                                    <div id="kv-error-{$oUploadSchema@index}{$oUpload@index}"
                                                         style="margin-top:10px; display:none;"></div>
                                                </div>
                                            {/block}
                                            {block name='snippets-uploads-scheme-script'}
                                                {inline_script}<script>
                                                    var clientUploadErrorIsActive = false;
                                                    $(function () {
                                                        var $el = $('#fileinput{$oUploadSchema@index}{$oUpload@index}');
                                                        $el.fileinput({
                                                            uploadUrl:             '{$ShopURL}/{$smarty.const.PFAD_UPLOAD_CALLBACK}',
                                                            uploadAsync:           false,
                                                            showPreview:           false,
                                                            showUpload:            false,
                                                            showRemove:            false,
                                                            required:              true,
                                                            browseClass:           'btn btn-light',
                                                            fileActionSettings:    {
                                                                showZoom:   false,
                                                                showRemove: false
                                                            },
                                                            allowedFileExtensions: [{$oUpload->cDateiListe|replace:'*.':'\''|replace:';':'\','|cat:'\''}],
                                                            language:              '{$uploaderLang}',
                                                            theme:                 'fas',
                                                            browseOnZoneClick:     true,
                                                            uploadExtraData:       {
                                                                sid:        "{$cSessionID}",
                                                                jtl_token:  "{$smarty.session.jtl_token}",
                                                                uniquename: "{$oUpload->cUnique}",
                                                                uploader:   "4.00",
                                                                kUploadSchema:"{$oUpload->kUploadSchema}",
                                                                prodID:     "{$oUpload->prodID}",
                                                                cname:      "{$oUpload->cName|replace:" ":"_"}"
                                                                {if !empty($oUploadSchema->WarenkorbPosEigenschaftArr)},
                                                                variation: "{strip}
                                                                {foreach name=variationen from=$oUploadSchema->WarenkorbPosEigenschaftArr item=Variation}_{$Variation->cEigenschaftWertName|trans|replace:" ":"_"}{/foreach}
                                                                    "{/strip}
                                                                {/if}
                                                            },
                                                            maxFileSize:           {$nMaxUploadSize/1024},
                                                            elErrorContainer:      '#kv-error-{$oUploadSchema@index}{$oUpload@index}',
                                                            maxFilesNum:           1
                                                        }).on("filebrowse", function (event, files) {
                                                            clientUploadErrorIsActive = false;
                                                            $el.fileinput('clear');
                                                        }).on("filebatchselected", function (event, files) {
                                                            $el.fileinput("upload");
                                                        }).on('filebatchuploadsuccess', function (event, data) {
                                                            var msgField       = $('#queue{$oUploadSchema@index}{$oUpload@index} .current-upload'),
                                                                uploadMsgField = $('.uploadifyMsg');
                                                            msgField.removeClass('text-danger').addClass('text-success');
                                                            if (typeof data.response !== 'undefined' && typeof data.response.cName !== 'undefined') {
                                                                msgField.removeClass('text-danger').addClass('text-success');
                                                                msgField.html('<i class="check" aria-hidden="true"></i>' + data.response.cName + ' (' + data.response.cKB + ' KB)');
                                                            } else {
                                                                msgField.removeClass('text-success').addClass('text-danger');
                                                                msgField.html('{lang key='uploadError'}');
                                                                msgField.removeClass('text-success').addClass('text-danger');
                                                                $el.fileinput('clear');
                                                            }
                                                            $('#msgWarning').hide();
                                                            uploadMsgField.find('.alert-danger').hide();
                                                            $('#buy-form').find('.upload-error').removeClass('upload-error');

                                                        }).on('fileuploaderror', function () {
                                                            $('#upload-{$oUploadSchema@index}{$oUpload@index} .fileinput-upload').addClass('disabled');
                                                            clientUploadErrorIsActive = true;
                                                            let msgField = $('#queue{$oUploadSchema@index}{$oUpload@index} .current-upload');
                                                            msgField.html(msg);
                                                            msgField.removeClass('text-success').addClass('text-danger');
                                                            $el.fileinput('clear');
                                                            $('#upload-{$oUploadSchema@index}{$oUpload@index} .fileinput-upload').addClass('disabled');

                                                        }).on('filebatchuploaderror', function(event, data, msg) {
                                                            if(clientUploadErrorIsActive === false){
                                                                let msgField = $('#queue{$oUploadSchema@index}{$oUpload@index} .current-upload');;
                                                                let message  = '{lang key='uploadError'}';
                                                                let status;
                                                                try{
                                                                    let response =JSON.parse(msg);
                                                                    status = response.status;
                                                                }catch(e){
                                                                    status = 'response_error';
                                                                }

                                                                switch(status){
                                                                    case 'reached_limit_per_hour':
                                                                        message = '{lang key='uploadErrorReachedLimitPerHour'}';
                                                                        break;
                                                                    case 'filetype_forbidden':
                                                                        message = '{lang key='uploadErrorFiletypeForbidden'}';
                                                                        break;
                                                                    case 'extension_not_listed':
                                                                        message = '{lang key='uploadErrorExtensionNotListed'}';
                                                                        break;
                                                                }
                                                                msgField.html(message);
                                                                msgField.removeClass('text-success').addClass('text-danger');
                                                                $el.fileinput('clear');
                                                            }
                                                        }).on('fileloaded', function () {
                                                            $('#upload-{$oUploadSchema@index}{$oUpload@index} .fileinput-upload').removeClass('disabled');
                                                        });
                                                    });
                                                </script>{/inline_script}
                                            {/block}
                                        {/col}
                                    {/block}
                                {/row}
                            {/foreach}
                        {/block}
                    </div>
                {/foreach}
            {/block}
        {/if}
    {/if}
{/block}
