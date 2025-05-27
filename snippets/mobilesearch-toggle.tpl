
<div id="sr-tg-m" class="pr visible-xs">
    <button class="img-ct icon" aria-label="{lang key='find'}">
        <svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
          <use xlink:href="{$ShopURL}/{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg?v={$nTemplateVersion}#icon-search"></use>
        </svg>
    </button>
    <button class="close close-btn" aria-label="{lang key='rmaClose' section='rma'}: {lang key='searchLabel'}"></button>
</div>