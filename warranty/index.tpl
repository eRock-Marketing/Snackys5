{block name='warranty-index'}
    {block name='warranty-index-include-header'}
        {include file='layout/header.tpl'}
    {/block}

    {block name='warranty-index-content'}
        {if !empty($Link->getTitle())}
            {block name='warranty-index-heading'}
                {opcMountPoint id='opc_before_heading' inContainer=false}
                {container fluid=$Link->getIsFluid()}
                    <div class="title h1">
                        {$Link->getTitle()}
                    </div>
                {/container}
            {/block}
        {/if}

        {block name='warranty-index-include-extension'}
            {include file='snippets/extension.tpl'}
        {/block}
        {block name='warranty-index-content'}
            {container fluid=$Link->getIsFluid()}
                {opcMountPoint id='opc_before_content'}
                {block name='warranty-index-warranty-image'}
                    {image src="{getWarrantyImagePath}" block=true fluid=true width=665 alt={lang key="warrantyImageAlt"} }
                {/block}
                {if !empty($Link->getContent())}
                    {block name='warranty-index-custom-content'}
                        <div class="custom_content mb-8">
                            {$Link->getContent()}
                        </div>
                    {/block}
                {/if}
            {/container}
        {/block}
    {/block}

    {block name='warranty-index-footer'}
        {include file='layout/footer.tpl'}
    {/block}
{/block}
