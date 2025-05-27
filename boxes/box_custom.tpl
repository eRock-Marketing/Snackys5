{block name='boxes-box-custom'}
	<section class="panel box box-custom box-normal" id="sidebox{$oBox->getID()}">
		{block name='boxes-box-custom-title'}
			<div class="h5 panel-heading flx-ac">
				{$oBox->getTitle()}
				{if ($snackyConfig.filterOpen == 1 && $oBox->getPosition() == 'left') || ($oBox->getPosition() == 'bottom' && $snackyConfig.footerBoxesOpen === '0')}<span class="caret"></span>{/if}
			</div>
		{/block}
		{block name='boxes-box-custom-content'}
			<div class="panel-body">
				{eval var=$oBox->getContent()}
			</div>
		{/block}
	</section>
{/block}