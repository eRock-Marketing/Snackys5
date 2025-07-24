{block name='layout-index'}
	{block name='index-viewportimages'}
		{if !isset($viewportImages)}{assign var="viewportImages" value=0}{/if}
	{/block}
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
				{block name="content-headline"}
					{if !empty($Link->getTitle()) && $Link->getLinkType() != $smarty.const.LINKTYP_404}
						{include file="snippets/zonen.tpl" id="opc_before_heading"}
						<h1>{$Link->getTitle()}</h1>
						{include file="snippets/zonen.tpl" id="opc_after_heading"}
					{elseif isset($bAjaxRequest) && $bAjaxRequest}
						{include file="snippets/zonen.tpl" id="opc_before_heading"}
						<h1>{if !empty($Link->getMetaTitle())}{$Link->getMetaTitle()}{else}{$Link->getName()}{/if}</h1>
						{include file="snippets/zonen.tpl" id="opc_after_heading"}
					{/if}
				{/block}
				{block name="content-extension"}
					{if $nSeitenTyp !== 18 && $nSeitenTyp !== 1 && $nSeitenTyp !== 2}
						{include file="snippets/extension.tpl"}
					{/if}
				{/block}
				{block name="content-content"}
					{if !empty($Link->getContent()) && $Link->getLinkType() != $smarty.const.LINKTYP_STARTSEITE && $Link->getLinkType() != $smarty.const.LINKTYP_404}
						{if $snackyConfig.optimize_content == "Y"}{$Link->getContent()|optimize}{else}{$Link->getContent()}{/if}
					{/if}
				{/block}
				{if $Link->getLinkType() == $smarty.const.LINKTYP_AGB}
					{block name="content-agb"}
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
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_WRB}
					{block name="content-wrb"}
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
					{/block}
				{elseif $Link->getLinkType() === $smarty.const.LINKTYP_WRB_FORMULAR}
					{block name="content-wrb-form"}
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
					{/block}
				{elseif $Link->getLinkType() === $smarty.const.LINKTYP_DATENSCHUTZ}
					{block name="content-privacy"}
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
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_STARTSEITE}
					{block name="content-homepage"}
						{include file='page/index.tpl'}
						{if !empty($Link->getContent())}
							<div class="custom-content">{if $snackyConfig.optimize_content == "Y"}{$Link->getContent()|optimize}{else}{$Link->getContent()}{/if}</div>
						{/if}
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_VERSAND}
					{block name="content-shipping"}
						{include file='page/shipping.tpl'}
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_LIVESUCHE}
					{block name="content-livesearch"}
						{include file='page/livesearch.tpl'}
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_HERSTELLER}
					{block name="content-manufacturer"}
						{include file='page/manufacturers.tpl'}
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_NEWSLETTERARCHIV}
					{block name="content-newsarchive"}
						{include file='page/newsletter_archive.tpl'}
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_SITEMAP}
					{block name="content-sitemap"}
						{include file='page/sitemap.tpl'}
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_GRATISGESCHENK}
					{block name="content-freegift"}
						{include file='page/free_gift.tpl'}
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_PLUGIN && empty($nFullscreenTemplate)}
					{block name="content-plugin"}
						{include file="$cPluginTemplate"}
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_AUSWAHLASSISTENT}
					{block name="content-wizard"}
						{include file='productwizard/index.tpl'}
					{/block}
				{elseif $Link->getLinkType() == $smarty.const.LINKTYP_404}
					{block name="content-404"}
						{include file='page/404.tpl'}
					{/block}
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