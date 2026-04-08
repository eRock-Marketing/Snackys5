{block name="brutto-netto-switcher"}
    {assign var="isNetto" value=$NettoPreise|default:0}
    {assign var="cleanUrl" value=$smarty.server.REQUEST_URI|regex_replace:"/[?&]snackysNettoPreise=[01]/":""}
    {assign var="separator" value=($cleanUrl|strpos:'?' !== false) ? '&' : '?'}
    <a href="{$ShopURL}{$cleanUrl}{$separator}snackysNettoPreise={if $isNetto}0{else}1{/if}" class="b2b-tgl-wp no-tdc" aria-label="{if $isNetto}{lang key='b2b-switch-to-brutto' section='custom'}{else}{lang key='b2b-switch-to-netto' section='custom'}{/if}"
    title="{if $isNetto}{lang key='b2b-switch-to-brutto' section='custom'}{else}{lang key='b2b-switch-to-netto' section='custom'}{/if}">
        {lang key='b2b' section='custom'}
        <span class="b2b-tgl" role="switch" aria-checked="{if $isNetto}true{else}false{/if}">
            <span class="b2b-tgl-btn{if $isNetto} active{/if}">
                <span class="b2b-tgl-knob"></span>
            </span>
        </span>
    </span>
{/block}
