{block name='page-manufacturers'}
	{block name='page-manufacturers-heading'}
		{assign var='linkKeyHersteller' value=\JTL\Shop::Container()->getLinkService()->getSpecialPageID(LINKTYP_HERSTELLER, false)|default:0}
		{assign var='linkSEOHersteller' value=\JTL\Shop::Container()->getLinkService()->getLinkByID($linkKeyHersteller)|default:null}
		{if $linkSEOHersteller !== null && !empty($linkSEOHersteller->getTitle())}
		{else}
			<h1>{lang key="manufacturers"}</h1>
		{/if}
	{/block}
	{include file="snippets/zonen.tpl" id="opc_before_manufacturers"}
	<div class="row row-multi" id="manu-row">
		{foreach $oHersteller_arr as $Hersteller}
			{block name='manufacturers-item'}
				<div class="col-6 col-sm-4 col-md-3 col-lg-2">
					<a href="{$Hersteller->getURL()}" class="block">
						{block name='manufacturers-item-image'}
							<div class="img-w">
								<div class="img-ct contain" title="{$Hersteller->getMetaTitle()|escape:'html'}">
									{assign var="stopLazy" value=false}
									{if $snackyConfig.nolazyloadProductlist >= $smarty.foreach.Hersteller.iteration}
										{assign var="stopLazy" value=true}
									{/if}
									{image fluid=true lazy=$stopLazy webp=true
									src=$Hersteller->getImage(\JTL\Media\Image::SIZE_MD)
									alt="{lang section='productOverview' key='manufacturerSingle'}: {$Hersteller->getName()|escape:'html'}"}
									</div>
							</div>
						{/block}
						{block name='manufacturers-item-caption'}
							<div class="caption">
								<span class="text-center title h4 m0">
									{$Hersteller->getName()}
								</span>
							</div>
						{/block}
					</a>
				</div>
			{/block}
		{/foreach}
	</div>
{/block}