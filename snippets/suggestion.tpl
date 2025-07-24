{block name='snippets-suggestion'}
<a href="{get_static_route id='index.php'}?qs={$result->keyword}" class="block">{$result->keyword} <span class="badge pull-right">{$result->quantity}</span></a>
{/block}