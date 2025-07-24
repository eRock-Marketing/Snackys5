{block name='account-uploads'}
{if !empty($Bestellung->oUpload_arr)}
    {assign var=nNameLength value=50}
    {assign var=nImageMaxWidth value=480}
    {assign var=nImageMaxHeight value=320}
    {assign var=nImagePreviewWidth value=35}
    <div id="uploads">
        <h3>{lang key="yourUploads"}</h3>
        <div class="table-responsive">
            <table class="table table-striped m0" id="customerupload">
                <thead>
                <tr>
                    <th>{lang key='name' section='global'}</th>
                    <th class="text-center">{lang key='uploadFilesize' section='global'}</th>
                    <th class="text-center">{lang key='uploadAdded' section='global'}</th>
                    <th class="text-center">{lang key='uploadFile' section='global'}</th>
                </tr>
                </thead>
                <tbody>
                {foreach $Bestellung->oUpload_arr as $oUpload}
                    <tr>
                        <td class="vcenter">{$oUpload->cName}</td>
                        <td class="text-center vcenter">{$oUpload->cGroesse}</td>
                        <td class="text-center vcenter">
                            <span class="infocur" title="{$oUpload->dErstellt|date_format:"%d.%m.%Y - %H:%M:%S"}">
                                {$oUpload->dErstellt|date_format:"%d.%m.%Y"}
                            </span>
                        </td>
                        <td class="text-center">
                            <form method="post" action="{get_static_route id='jtl.php'}">
                                {$jtl_token}
                                <input name="kUpload" type="hidden" value="{$oUpload->kUpload}" />
                                <button class="btn btn-blank btn-xs" name="{$oUpload->cName}">
                                    <span class="img-ct icon">
                                        <svg>
                                          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-show"></use>
                                        </svg>
                                    </span>
                                </button>
                            </form>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
{/if}
{/block}