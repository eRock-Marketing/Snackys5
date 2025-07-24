{block name='snippets-maintenance'}
{block name="header"}
    {include file='layout/header.tpl' maintenance=true}
{/block}

{assign var="tDir" value=$currentTemplateDir}
{if isset($parentTemplateDir)}
	{if !file_exists('{$currentTemplateDir}/layout/header.tpl')}
		{assign var="tDir" value=$parentTemplateDir}
	{/if}
{/if}

{block name="content"}
    <div id="maintenance-notice" class="panel panel-info">
		<span class="topbar flx-ac flx-jc">{lang key="maintainance" section="global"}</span>
		<div class="row flx-ac">
			<div class="col-3 col-sm-5 hidden-xs">
				<div class="icon-container">
					<span class="img-ct icon icon-xl">
                        <img src="{$ShopURL}/{$tDir}img/icons/icon-wartung.svg" alt="{lang key="maintainance" section="global"}">
					</span>
				</div>
			</div>
			<div class="col-12 col-sm-7 text-col">
				<div id="logo-wrapper">
					<div id="logo">
						{include file="layout/shoplogo.tpl"}
					</div>
				</div>
				<h1 class="h3">{lang key="beBackSoon" section="custom"}</h1>
				<p>{lang key="maintenanceModeActive" section="global"}</p>
				{getLink nLinkart=27 cAssign="linkimpressum"}
				{if $linkimpressum}
					<hr class="invisible hr-sm">
					<button type="button" class="btn-link" data-toggle="modal" data-target="#impressumModal">
						{if !empty($linkimpressum->getTitle())}
							{$linkimpressum->getTitle()}
						{else}
							{$linkimpressum->getName()}
						{/if}
					</button>
					<div class="modal fade" id="impressumModal" tabindex="-1" role="dialog" aria-labelledby="impressumModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="impressumModalLabel">{$linkimpressum->getTitle()}</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">{$linkimpressum->getContent()}</div>
					</div>
					</div>
					</div>
				{/if}
			</div>	
		</div>
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl' maintenance=true}
{/block}
{/block}