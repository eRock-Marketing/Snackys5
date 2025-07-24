{if $params.webp->getValue() !== true && $params.src->getValue()|webpExists}
	{$params.webp->setValue(true)}
{/if}
{assign var=rounded value=''}
{assign var=useWebP value=$params.webp->getValue() === true && \JTL\Media\Image::hasWebPSupport()}
{if $params.rounded->getValue() !== false}
    {if $params.rounded->getValue() === true}
        {assign var=rounded value=' rounded'}
    {else}
        {assign var=rounded value=' rounded-'|cat:$params.rounded->getValue()}
    {/if}
{/if}

{if $params.src->hasValue() && strpos($params.src->getValue(), 'keinBild.gif') !== false}
<img class="{$params.class->getValue()} {$rounded} img-fluid{if $params['fluid-grow']->getValue() === true} w-100{/if}"
     height="{if $params.height->hasValue() && !empty($params.height->getValue())}{$params.height->getValue()}{else}130{/if}"
     width="{if $params.width->hasValue() && !empty($params.width->getValue())}{$params.width->getValue()}{else}130{/if}"
     {if $params.alt->hasValue()}alt="{$params.alt->getValue()}" title="{$params.alt->getValue()}"{/if}
     src="{$params.src->getValue()}">
{else}
    {if $useWebP}
    <picture>
        <source
            {if $params.srcset->hasValue()}
                {if $params.lazy->getValue() === true}data-{/if}srcset="{$params.srcset->getValue()|regex_replace:"/\.(?i)(jpg|jpeg|png)/":".webp"}"
            {elseif $params.src->hasValue()}
                {if $params.lazy->getValue() === true}data-{/if}srcset="{$params.src->getValue()|regex_replace:"/\.(?i)(jpg|png)/":".webp"}"
            {else}
                srcset=""
            {/if}
            {if $params.sizes->hasValue()}sizes="{$params.sizes->getValue()}"{/if}
            {if $params.width->hasValue() && !empty($params.width->getValue())}width="{$params.width->getValue()}"{/if}
            {if $params.height->hasValue() && !empty($params.height->getValue())}height="{$params.height->getValue()}"{/if}
            type="image/webp">
    {/if}
        <img
            src="{$params.src->getValue()}"
            {if $params.lazy->getValue() === true}
                srcset="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiBzdHlsZT0ibWFyZ2luOiBhdXRvOyBiYWNrZ3JvdW5kOiBub25lOyBkaXNwbGF5OiBibG9jazsgc2hhcGUtcmVuZGVyaW5nOiBhdXRvOyIgdmlld0JveD0iMCAwIDEwMCAxMDAiIHByZXNlcnZlQXNwZWN0UmF0aW89InhNaWRZTWlkIj4KPHJlY3QgeD0iMTkiIHk9IjI4IiB3aWR0aD0iMTIiIGhlaWdodD0iNDQiIGZpbGw9IiNjN2M3YzciPgogIDxhbmltYXRlIGF0dHJpYnV0ZU5hbWU9InkiIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIiBkdXI9IjJzIiBjYWxjTW9kZT0ic3BsaW5lIiBrZXlUaW1lcz0iMDswLjU7MSIgdmFsdWVzPSIxNzsyODsyOCIga2V5U3BsaW5lcz0iMCAwLjUgMC41IDE7MCAwLjUgMC41IDEiIGJlZ2luPSItMC40cyI+PC9hbmltYXRlPgogIDxhbmltYXRlIGF0dHJpYnV0ZU5hbWU9ImhlaWdodCIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIGR1cj0iMnMiIGNhbGNNb2RlPSJzcGxpbmUiIGtleVRpbWVzPSIwOzAuNTsxIiB2YWx1ZXM9IjY2OzQ0OzQ0IiBrZXlTcGxpbmVzPSIwIDAuNSAwLjUgMTswIDAuNSAwLjUgMSIgYmVnaW49Ii0wLjRzIj48L2FuaW1hdGU+CjwvcmVjdD4KPHJlY3QgeD0iNDQiIHk9IjI4IiB3aWR0aD0iMTIiIGhlaWdodD0iNDQiIGZpbGw9IiNlZGVkZWQiPgogIDxhbmltYXRlIGF0dHJpYnV0ZU5hbWU9InkiIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIiBkdXI9IjJzIiBjYWxjTW9kZT0ic3BsaW5lIiBrZXlUaW1lcz0iMDswLjU7MSIgdmFsdWVzPSIxOS43NTsyODsyOCIga2V5U3BsaW5lcz0iMCAwLjUgMC41IDE7MCAwLjUgMC41IDEiIGJlZ2luPSItMC4ycyI+PC9hbmltYXRlPgogIDxhbmltYXRlIGF0dHJpYnV0ZU5hbWU9ImhlaWdodCIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIGR1cj0iMnMiIGNhbGNNb2RlPSJzcGxpbmUiIGtleVRpbWVzPSIwOzAuNTsxIiB2YWx1ZXM9IjYwLjU7NDQ7NDQiIGtleVNwbGluZXM9IjAgMC41IDAuNSAxOzAgMC41IDAuNSAxIiBiZWdpbj0iLTAuMnMiPjwvYW5pbWF0ZT4KPC9yZWN0Pgo8cmVjdCB4PSI2OSIgeT0iMjgiIHdpZHRoPSIxMiIgaGVpZ2h0PSI0NCIgZmlsbD0iI2M3YzdjNyI+CiAgPGFuaW1hdGUgYXR0cmlidXRlTmFtZT0ieSIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIGR1cj0iMnMiIGNhbGNNb2RlPSJzcGxpbmUiIGtleVRpbWVzPSIwOzAuNTsxIiB2YWx1ZXM9IjE5Ljc1OzI4OzI4IiBrZXlTcGxpbmVzPSIwIDAuNSAwLjUgMTswIDAuNSAwLjUgMSI+PC9hbmltYXRlPgogIDxhbmltYXRlIGF0dHJpYnV0ZU5hbWU9ImhlaWdodCIgcmVwZWF0Q291bnQ9ImluZGVmaW5pdGUiIGR1cj0iMnMiIGNhbGNNb2RlPSJzcGxpbmUiIGtleVRpbWVzPSIwOzAuNTsxIiB2YWx1ZXM9IjYwLjU7NDQ7NDQiIGtleVNwbGluZXM9IjAgMC41IDAuNSAxOzAgMC41IDAuNSAxIj48L2FuaW1hdGU+CjwvcmVjdD4KPCEtLSBbbGRpb10gZ2VuZXJhdGVkIGJ5IGh0dHBzOi8vbG9hZGluZy5pby8gLS0+PC9zdmc+"
                {if $params.srcset->hasValue()}
                    data-srcset="{$params.srcset->getValue()}"
                {else}
                    data-srcset="{$params.src->getValue()}"
                {/if}
            {else}
                srcset="{$params.srcset->getValue()}"
            {/if}
            {if $params.sizes->hasValue()}sizes="{$params.sizes->getValue()}"{/if}
            class="{strip}{$params.class->getValue()}{$rounded}
			{if $params.lazy->getValue() === true} lazyload{/if}
            {if $params.fluid->getValue() === true} img-fluid{/if}
            {if $params['fluid-grow']->getValue() === true} img-fluid w-100{/if}
            {if $params.thumbnail->getValue() === true} img-thumbnail{/if}
            {if $params.left->getValue() === true} float-left{/if}
            {if $params.right->getValue() === true} float-right{/if}
            {if $params.center->getValue() === true} mx-auto d-block{/if}{/strip}"
            {if $params.id->hasValue()}id="{$params.id->getValue()}"{/if}
            {if $params.title->hasValue()}title="{$params.title->getValue()}"{/if}
            {if $params.alt->hasValue()}alt="{$params.alt->getValue()}" title="{$params.alt->getValue()}"{/if}
            {if $params.width->hasValue() && !empty($params.width->getValue())}width="{$params.width->getValue()}"{/if}
            {if $params.height->hasValue() && !empty($params.height->getValue())}height="{$params.height->getValue()}"{/if}
            {if $params.style->hasValue()}style="{$params.style->getValue()}"{/if}
            {if $params.itemprop->hasValue()}itemprop="{$params.itemprop->getValue()}"{/if}
            {if $params.itemscope->getValue() === true}itemscope {/if}
            {if $params.itemtype->hasValue()}itemtype="{$params.itemtype->getValue()}"{/if}
            {if $params.itemid->hasValue()}itemid="{$params.itemid->getValue()}"{/if}
            {if $params.role->hasValue()}role="{$params.role->getValue()}"{/if}
            {if $params.aria->hasValue()}
                {foreach $params.aria->getValue() as $ariaKey => $ariaVal} aria-{$ariaKey}="{$ariaVal}" {/foreach}
            {/if}
            {if $params.data->hasValue()}
                {foreach $params.data->getValue() as $dataKey => $dataVal} data-{$dataKey}="{$dataVal}" {/foreach}
            {/if}
            {if $params.attribs->hasValue()}
                {foreach $params.attribs->getValue() as $key => $val} {$key}="{$val}" {/foreach}
            {/if}
        >
    {if $useWebP}
    </picture>
    {/if}
{/if}
