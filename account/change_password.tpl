{block name='account-change-password'}
<h1 class="h2">{lang key="changePassword" section="login"}</h1>

{block name="change-password-form"}
<div class="panel-wrap">
    <p>{lang key='changePasswordDesc' section='login'}</p>
    <form id="password" action="{get_static_route id='jtl.php'}" method="post" class="evo-validate">
        {$jtl_token}
        <div class="form-group required">
            <label for="currentPassword" class="control-label">{lang key="currentPassword" section="login"}</label>
            <input type="password" name="altesPasswort" id="currentPassword" class="form-control" required>
        </div>

        <div class="form-group required">
            <label for="newPassword" class="control-label">{lang key="newPassword" section="login"}</label>
            <input type="password" name="neuesPasswort1" id="newPassword" class="form-control" required>
        </div>

        <div class="form-group required">
            <label for="newPasswordRpt" class="control-label">{lang key="newPasswordRpt" section="login"}</label>
            <input type="password" name="neuesPasswort2" id="newPasswordRpt" class="form-control" required>
        </div>

        <div class="form-group">
            <hr class="invisible hr-sm">
            <input type="hidden" name="pass_aendern" value="1">
            <input type="submit" value="{lang key="changePassword" section="login"}" class="submit btn btn-primary btn-block btn-lg">
        </div>
    </form>
</div>
{/block}
{/block}