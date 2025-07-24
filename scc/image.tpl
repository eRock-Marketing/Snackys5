{if $params.webp->getValue() !== true && $params.src->getValue()|webpExists}
	{$params.webp->setValue(true)}
{/if}
{include file="{$sccDir}image.tpl"}