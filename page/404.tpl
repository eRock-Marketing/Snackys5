{block name='page-404'}
	<div id="pnf" class="flx-ac flx-jc text-center" 
		 style="background: url('{if !empty($snackyConfig.error404BG)}{$snackyConfig.error404BG}{else}/templates/Snackys/img/background/bg-404.jpg{/if}')no-repeat center center/cover">
		<div class="content">
			{block name='page-404-headline'}
				{include file="snippets/zonen.tpl" id="opc_before_heading"}
				{if !empty($Link->getTitle())}
					<h1 class="lg">{$Link->getTitle()}</h1>
				{else}
					<h1 class="xl m0">404</h1>
				{/if}
				{include file="snippets/zonen.tpl" id="opc_after_heading"}
			{/block}
			{block name='page-404-conent'}
				{if !empty($Link->getContent()) && $Link->getLinkType() != $smarty.const.LINKTYP_STARTSEITE}
					{if $snackyConfig.optimize_content == "Y"}{$Link->getContent()|optimize}{else}{$Link->getContent()}{/if}
				{else}
					<h2>{lang key="pagenotfound" section="breadcrumb"}</h2>
				{/if}
			{/block}
			{block name='page-404-backlink'}
				<a href="{$ShopURL}" class="btn btn-primary btn-lg">{lang key="goToStartpage" section="checkout"}</a>
			{/block}
		</div>
	</div>
{/block}