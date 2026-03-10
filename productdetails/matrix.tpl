{block name='productdetails-matrix'}
	{if $showMatrix}
		<div class="product-matrix mt-xs{if isset($matrixType) && $matrixType == 'classic'} mtrx-clsc{elseif isset($matrixType) && $matrixType == 'list'} card{/if}">
			{if isset($matrixType) && $matrixType == 'list'}
				{block name='productdetails-matrix-list'}
					{include file="productdetails/matrix_list.tpl"}
				{/block}
			{else}
				{block name='productdetails-matrix-classic'}
					<h2 class="mt-lg">{lang key='productMatrixTitle' section='productDetails'}</h2>
					{include file="productdetails/matrix_classic.tpl"}
				{/block}
			{/if}
		 </div>
	{/if}
{/block}