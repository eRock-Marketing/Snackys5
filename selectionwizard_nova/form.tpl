{block name='selectionwizard-form'}
    {if isset($AWA)}
        {block name='selectionwizard-form-heading'}
            <div class="h3 selection-wizard-desc">
                {$AWA->getDescription()}
            </div>
        {/block}
        {block name='selectionwizard-form-list'}
            {listgroup class="selection-wizard list-group-flush"}
                {foreach $AWA->getQuestions() as $nQuestion => $oFrage}
                    {if $AWA->getConf('auswahlassistent_allefragen') === 'Y' || $nQuestion <= $AWA->getCurQuestion()}
                        {block name='selectionwizard-form-include-question'}
                            {include file='selectionwizard/question.tpl' AWA=$AWA nQuestion=$nQuestion oFrage=$oFrage}
                        {/block}
                    {/if}
                {/foreach}
            {/listgroup}
        {/block}
    {/if}
{/block}
