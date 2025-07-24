{block name='page-manufacturers'}
{include file="snippets/zonen.tpl" id="opc_before_manufacturers"}
<div class="row row-multi" id="manu-row">
    {foreach $oHersteller_arr as $Hersteller}
        <div class="col-6 col-sm-4 col-md-3 col-lg-2">
			<div class="img-w mb-spacer mb-xs">
				<a href="{$Hersteller->cURL}" class="img-ct contain" title="{$Hersteller->cMetaTitle|escape:'html'}">
                        {image fluid=true lazy=true webp=true
						src=$Hersteller->getImage(\JTL\Media\Image::SIZE_MD)
						alt=$Hersteller->getName()|escape:'html'}
				</a>
			</div>
			<div class="caption">
				<a href="{$Hersteller->cURL}" class="text-center im-w" title="{$Hersteller->cMetaTitle|escape:'html'}">
					<span class="title h4 m0">
						{$Hersteller->getName()}
					</span>
				</a>
			</div>
        </div>
    {/foreach}
</div>
{/block}
