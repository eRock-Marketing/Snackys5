{block name='productdetails-index'}
{if !isset($viewportImages)}{assign var="viewportImages" value=0}{/if}
{block name="header"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/header.tpl'}
    {elseif isset($smarty.get.quickView) && $smarty.get.quickView == 1}
        {include file='layout/modal_header.tpl'}
    {/if}
{/block}

{block name="content"}
    {if isset($bAjaxRequest) && $bAjaxRequest && isset($listStyle) && ($listStyle === 'list' || $listStyle === 'gallery')}
        {if $listStyle === 'list'}
            {assign var="tplscope" value="list"}
            {include file='productlist/item_list.tpl'}
        {elseif $listStyle === 'gallery'}
            {assign var="tplscope" value="gallery"}
            {assign var="class" value="thumbnail"}
            {include file='productlist/item_box.tpl'}
        {/if}
    {else}
        <div id="result-wrapper" data-wrapper="true" variations-type="{if isset($varKombiArr) && $varKombiArr|@count > 0}varkombi{else if $Artikel->Variationen}simple{else}none{/if}">
        {include file="snippets/extension.tpl"}
        {include file='productdetails/details.tpl'}
        </div>
    {/if}
{/block}

{block name="footer"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/footer.tpl'}
    {elseif isset($smarty.get.quickView) && $smarty.get.quickView == 1}
        {include file='layout/modal_footer.tpl'}
    {/if}
{/block}
{/block}