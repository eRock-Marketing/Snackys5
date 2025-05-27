{block name='page-shipping'}
	{if isset($Einstellungen.global.global_versandermittlung_anzeigen) && $Einstellungen.global.global_versandermittlung_anzeigen === 'Y'}
		{include file="snippets/zonen.tpl" id="opc_before_shipping"}
		{if !isset($smarty.get.shipping_calculator) || (isset($smarty.get.shipping_calculator) && $smarty.get.shipping_calculator !== "0")}
			{if JTL\Session\Frontend::getCart()->PositionenArr|count > 0}	
				<form method="post" action="{if isset($oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND])}{$oSpezialseiten_arr[$smarty.const.LINKTYP_VERSAND]->getURL()}{else}{$ShopURL}/{/if}{if $bExclusive}?exclusive_content=1{/if}" 
				class="form form-inline jtl-validate mt-sm" id="shipping-calculator-form">
					{$jtl_token}
					<input type="hidden" name="s" value="{$Link->getID()}" />
					{include file='snippets/shipping_calculator.tpl' checkout=false}
				</form>
			{else}
				<div class="alert alert-info">{lang key="estimateShippingCostsNote" section="global"}</div>
			{/if}
		{/if}
		{include file="snippets/zonen.tpl" id="opc_after_shipping"}
	{/if}
{/block}