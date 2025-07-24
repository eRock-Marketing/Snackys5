{block name='layout-index'}
{if isset($nFullscreenTemplate) && $nFullscreenTemplate == 1}
    {include file=$cPluginTemplate}
{else}
    {block name="header"}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/header.tpl'}
        {else}
            {include file='layout/modal_header.tpl'}
        {/if}
    {/block}

	{if !isset($smarty.get.sidebar)}
		{block name="content"}
			{if !empty($Link->getTitle()) && $Link->getLinkType() != $smarty.const.LINKTYP_404}
				{include file="snippets/zonen.tpl" id="opc_before_heading"}
				<h1>{$Link->getTitle()}</h1>
			{elseif isset($bAjaxRequest) && $bAjaxRequest}
				{include file="snippets/zonen.tpl" id="opc_before_heading"}
				<h1>{if !empty($Link->getMetaTitle())}{$Link->getMetaTitle()}{else}{$Link->getName()}{/if}</h1>
			{/if}

			{if $nSeitenTyp !== 18 && $nSeitenTyp !== 1 && $nSeitenTyp !== 2}
				{include file="snippets/extension.tpl"}
			{/if}

			{if !empty($Link->getContent()) && $Link->getLinkType() != $smarty.const.LINKTYP_STARTSEITE && $Link->getLinkType() != $smarty.const.LINKTYP_404}
				{if $snackyConfig.optimize_content == "Y"}{$Link->getContent()|optimize}{else}{$Link->getContent()}{/if}
			{/if}

			{if $Link->getLinkType() == $smarty.const.LINKTYP_AGB}
				<div id="tos" class="well well-sm">
					{include file="snippets/zonen.tpl" id="opc_before_tos"}
					{if $AGB !== false}
						{if $AGB->cAGBContentHtml}
							{$AGB->cAGBContentHtml}
						{elseif $AGB->cAGBContentText}
							{$AGB->cAGBContentText|nl2br}
						{/if}	
					{/if}
					{include file="snippets/zonen.tpl" id="opc_after_tos"}
				</div>
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_WRB}
				<div id="revocation-instruction" class="well well-sm">
					{include file="snippets/zonen.tpl" id="opc_before_revocation"}
					{if $WRB !== false}
						{if $WRB->cWRBContentHtml}
							{$WRB->cWRBContentHtml}
						{elseif $WRB->cWRBContentText}
							{$WRB->cWRBContentText|nl2br}
						{/if}
					{/if}
					{include file="snippets/zonen.tpl" id="opc_after_revocation"}
				</div>
			{elseif $Link->getLinkType() === $smarty.const.LINKTYP_WRB_FORMULAR}
				<div id="revocation-form" class="well well-sm">
					{opcMountPoint id='opc_before_revocation_form'}
					{if $WRB !== false}
						{if $WRB->cWRBFormContentHtml}
							{$WRB->cWRBFormContentHtml}
						{elseif $WRB->cWRBFormContentText}
							{$WRB->cWRBFormContentText|nl2br}
						{/if}
					{/if}
					{opcMountPoint id='opc_after_revocation_form'}
				</div>
			{elseif $Link->getLinkType() === $smarty.const.LINKTYP_DATENSCHUTZ}
				<div id="data-privacy" class="well well-sm">
					{opcMountPoint id='opc_before_data_privacy'}
					{if $WRB !== false}
						{if $WRB->cDSEContentHtml}
							{$WRB->cDSEContentHtml}
						{elseif $WRB->cDSEContentText}
							{$WRB->cDSEContentText|nl2br}
						{/if}
					{/if}
					{opcMountPoint id='opc_after_data_privacy'}
				</div>
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_STARTSEITE}
				{include file='page/index.tpl'}
				{if !empty($Link->getContent())}
					<div class="custom-content">{if $snackyConfig.optimize_content == "Y"}{$Link->getContent()|optimize}{else}{$Link->getContent()}{/if}</div>
				{/if}
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_VERSAND}
				{include file='page/shipping.tpl'}
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_LIVESUCHE}
				{include file='page/livesearch.tpl'}
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_HERSTELLER}
				{include file='page/manufacturers.tpl'}
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_NEWSLETTERARCHIV}
				{include file='page/newsletter_archive.tpl'}
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_SITEMAP}
				{include file='page/sitemap.tpl'}
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_GRATISGESCHENK}
				{include file='page/free_gift.tpl'}
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_PLUGIN && empty($nFullscreenTemplate)}
				{include file="$cPluginTemplate"}
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_AUSWAHLASSISTENT}
				{include file='productwizard/index.tpl'}
			{elseif $Link->getLinkType() == $smarty.const.LINKTYP_404}
				{include file='page/404.tpl'}
			{/if}
		{/block}
    {/if}
	
    {block name="footer"}
        {if !isset($bAjaxRequest) || !$bAjaxRequest}
            {include file='layout/footer.tpl'}
        {else}
            {include file='layout/modal_footer.tpl'}
        {/if}
    {/block}
{/if}
{/block}