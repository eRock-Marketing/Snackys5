<style>
    div.qrcode {
        margin: 5px;
        display: inline-block;
        border: 5px solid white;
    }
    div.qrcode > p {
        margin: 0;
        padding: 0;
        height: 5px;
        display: flex;
    }
    div.qrcode > p > b,
    div.qrcode > p > i {
        display: inline-block;
        width: 5px;
        height: 5px;
    }
    div.qrcode > p > b {
        background-color: #000;
    }
    div.qrcode > p > i {
        background-color: #fff;
    }
</style>

{block name='account-change-password'}
    {block name='account-change-password-heading'}
        <h1>{lang key='manageTwoFA' section='account data'}</h1>
    {/block}
    {block name='account-manage-two-fa-manage-two-fa-form'}
        {block name='account--manage-two-fa-alert'}
            {alert variant="info"}{lang key='manageTwoFADesc' section='account data'}{/alert}
        {/block}
        <div id="er_twofa">
            <svg width="1600" height="1600" viewBox="0 0 1200 1200" xmlns="http://www.w3.org/2000/svg"><path d="M1012.1 251.5a966.185 966.185 0 0 1-347.05-165L629.948 60c-8.656-6.492-19.18-10-30-10s-21.344 3.508-30 10l-35 26.352a966.156 966.156 0 0 1-347.05 165A49.993 49.993 0 0 0 149.949 300v231a590.765 590.765 0 0 0 62.387 262.82 590.748 590.748 0 0 0 172.86 207.57l184.75 138.6c8.656 6.492 19.18 10 30 10s21.344-3.508 30-10l185-138.6a590.746 590.746 0 0 0 172.72-207.61 590.713 590.713 0 0 0 62.277-262.79v-231a50.023 50.023 0 0 0-10.582-30.762 50.01 50.01 0 0 0-27.27-17.738zM949.952 531a490.275 490.275 0 0 1-51.66 218.12 490.263 490.263 0 0 1-143.34 172.33l-155 116.05-155-116.05a490.303 490.303 0 0 1-143.34-172.33A490.271 490.271 0 0 1 249.952 531V338.3a1063.664 1063.664 0 0 0 345-172l5-3.8 5 3.8a1063.585 1063.585 0 0 0 345 172z"/><path d="M485.35 564.65a50.002 50.002 0 0 0-70.703 70.703l100 100c9.379 9.371 22.094 14.637 35.352 14.637s25.973-5.266 35.352-14.637l200-200a50.002 50.002 0 0 0-70.703-70.703L549.998 629.3z"/></svg>
            {block name='account-change-password-form-password'}
                {form id="manage-two-fa"
                action="{get_static_route id='jtl.php'}"
                method="post"
                class="jtl-validate mt-sm"
                slide=true}
                <input type="hidden" name="twoFACustomerID" id="twoFACustomerID" value="{$Kunde->getID()}">
                {block name='account-manage-two-fa-form-content'}
                    {lang key='enableTwoFA' section='account data' assign=lbl}
                    <h2 class="h4 text-center">{$lbl}</h2>
                    <div class="form-group">
                        <label for="b2FAauth">
                            {$lbl}
                        </label>
                        <select id="b2FAauth" name="b2FAauth">
                            <option value="0"{if $Kunde->has2FA() === false} selected="selected"{/if}>{lang key='no'}</option>
                            <option value="1"{if $Kunde->has2FA() === true} selected="selected"{/if}>{lang key='yes'}</option>                    
                        </select>
                    </div>
                    <div id="TwoFAwrapper"
                        class="mt-sm collapse form-group{if isset($cError_arr.c2FAsecret)} error{/if}{if $Kunde->has2FA() === true} show{/if}">
                        <div class="panel mt-sm mb-xs">
                            <div id="QRcodeCanvas" style="display:{if $QRcodeString !== ''}block{else}none{/if}">
                                <div class="alert alert-danger" role="alert">
                                    {lang key='enableTwoFAwarning' section='account data'}
                                </div>
                                {lang key='infoScanQR' section='account data'}
                                <div id="QRcode" class="qrcode">{$QRcodeString}</div>
                                <br>
                                <input type="hidden" id="c2FAsecret" name="c2FAsecret" value="{$cKnownSecret}">
                                <br>
                            </div>
                            <div class="modal" id="EmergencyCodeModal" tabindex="-1" >
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <div class="modal-title block h5">{lang key='emergencyCodes' section='account data'}</div>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="{lang key='close' section='account data'}">
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <div id="EmergencyCodes">
                                                <div class="iframewrapper">
                                                    <iframe src="" id="printframe" name="printframe" frameborder="0"
                                                            width="100%" height="300" align="middle"></iframe>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <div class="row">
                                                <div class="col-12 col-sm-6">
                                                    <button class="btn btn-outline-primary btn-block" type="button"
                                                            onclick="printframe.print();">
                                                        {lang key='print' section='account data'}
                                                    </button>
                                                </div>
                                                <div class="col-12 col-sm-6">
                                                    <button class="btn btn-danger btn-block" type="button"
                                                            onclick="showEmergencyCodes('forceReload');">
                                                        {lang key='codeCreateAgain' section='account data'}
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="h5 text-center">
                                {lang key='clickHereToCreateQR' section='account data'}
                            </div>
                            <div class="row">
                                <div class="col-12 col-sm-6">
                                    <button class="btn btn-warning btn-block" type="button" onclick="showEmergencyCodes();">
                                        {lang key='emergencyCodeCreate' section='account data'}
                                    </button>
                                </div>
                                <div class="col-12 col-sm-6">
                                    <button class="btn btn-primary btn-block" type="button" onclick="createNewSecret();">
                                        {lang key='codeCreate' section='account data'}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    {block name='account-manage-two-fa-form-submit'}
                        <hr class="hr-sm invisible">
                        <div class="row">
                            <div class="col-12 col-sm-6">
                                {link class='btn btn-outline-primary btn-back btn-block' href="{get_static_route id='jtl.php'}"}
                                    {lang key='back'}
                                {/link}
                            </div>
                            <div class="col-12 col-sm-6">
                                <div class="visible-xs mb-xxs">
                                    <span></span>
                                </div>
                                {input type='hidden' name='manage_two_fa' value='1'}
                                {button type='submit' value='1' block=true variant='primary'}
                                {lang key='save' section='account data'}
                                {/button}
                            </div>
                        </div>
                    {/block}
                {/block}
                {/form}
            {/block}
        </div>
    {/block}
{/block}

{literal}
<script>
    $(document).ready(function () {
        $('#b2FAauth').on('change', function (e) {
            e.stopImmediatePropagation(); // stop this event during page-load
            let $wrapper = $('#TwoFAwrapper');
            if ('none' === $wrapper.css('display')) {
                $wrapper.slideDown();
            } else {
                $wrapper.slideUp();
            }
        });
    });

    function createNewSecret() {
        let currentSecret = $('#c2FAsecret').val();
        if (
            currentSecret === ''
            || confirm('{/literal}{lang key='warningAuthSecretOverwrite' section='account data'}{literal}')
        ) {
            let userID = parseInt($('#twoFACustomerID').val());
            let that = this;
            $.evo.io().call('getNewTwoFA', [userID], that, function (error, data) {
                $.evo.io().call('genTwoFAEmergencyCodes', [userID], that, function (error, data) {
                    showEmergencyCodes();
                });
                $('#QRcode').html(data.response.szQRcode);
                $('#c2FAsecret').val(data.response.szSecret);
                if ($('#QRcodeCanvas').css('display') === 'none') {
                    $('#QRcodeCanvas').css('display', 'block');
                }
            });
        }
    }

    function showEmergencyCodes(action) {
        let userID = parseInt($('#twoFACustomerID').val());
        let that = this;
        $.evo.io().call('genTwoFAEmergencyCodes', [userID], that, function (error, data) {
            var iframeHtml = '';

            iframeHtml += '<h4>{/literal}{lang key='shopEmergencyCodes' section='account data'}{literal}</h4>';
            iframeHtml += '{/literal}{lang key='account' section='account data'}{literal}: <b>'
                + data.response.loginName
                + '</b><br>';
            iframeHtml += '{/literal}{lang key='shop' section='account data'}{literal}: <b>'
                + data.response.shopName
                + '</b><br><br>';
            iframeHtml += '<pre>';

            data.response.vCodes.forEach(function (code, i) {
                iframeHtml += code + ' ';
                if (i % 2 === 1) {
                    iframeHtml += '\n';
                }
            });

            iframeHtml += '</pre>';
            $('#printframe').contents().find('body')[0].innerHTML = iframeHtml;
            $('#EmergencyCodeModal').modal('show');
        });
    }
</script>
{/literal}
