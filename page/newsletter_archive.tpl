{block name='page-newsletter-archive'}
    {opcMountPoint id='opc_before_newsletter' inContainer=false}
    {container fluid=$Link->getIsFluid() class="page-newsletter-archive {if $Einstellungen.template.theme.left_sidebar === 'Y' && $boxesLeftActive}container-plus-sidebar{/if}"}
        {block name='page-newsletter-archive-toptags'}
            <div id="toptags" class="h2">{lang key='newsletterhistory'}</div>
        {/block}
        {block name='page-newsletter-archive-content'}
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>{lang key='newsletterhistorysubject'}</th>
                        <th>{lang key='newsletterhistorydate'}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $oNewsletterHistory_arr as $oNewsletterHistory}
                        <tr>
                            <td>{link href="{$oNewsletterHistory->cURLFull}"}{$oNewsletterHistory->cBetreff}{/link}</td>
                            <td>{$oNewsletterHistory->Datum}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        {/block}
    {/container}
{/block}
