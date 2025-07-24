{block name='page-manufacturers'}
	{include file="snippets/zonen.tpl" id="opc_before_manufacturers"}
	<div class="row row-multi" id="manu-row">
		{foreach $oHersteller_arr as $Hersteller}
			{block name='manufacturers-item'}
				<div class="col-6 col-sm-4 col-md-3 col-lg-2">
					{block name='manufacturers-item-image'}
						<div class="img-w mb-xs">
							<a href="{$Hersteller->getURL()}" class="img-ct contain" title="{$Hersteller->getMetaTitle()|escape:'html'}">
								{assign var="stopLazy" value=false}
								{if $snackyConfig.nolazyloadProductlist >= $smarty.foreach.Hersteller.iteration}
									{assign var="stopLazy" value=true}
								{/if}
								{image fluid=true lazy=$stopLazy webp=true
								src=$Hersteller->getImage(\JTL\Media\Image::SIZE_MD)
								alt=$Hersteller->getName()|escape:'html'}
							</a>
						</div>
					{/block}
					{block name='manufacturers-item-caption'}
						<div class="caption">
							<a href="{$Hersteller->getURL()}" class="text-center im-w" title="{$Hersteller->getMetaTitle()|escape:'html'}">
								<span class="title h4 m0">
									{$Hersteller->getName()}
								</span>
							</a>
						</div>
					{/block}
				</div>
			{/block}
		{/foreach}
	</div>
{/block}