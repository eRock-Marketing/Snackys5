{block name='selectionwizard-index'}
    {if isset($AWA)}
        {block name='selectionwizard-javascript'}
            <script>
                var nSelection_arr = [{implode(',', $AWA->getSelections())}];
                function setSelectionWizardAnswerJS(kMerkmalWert)
                {
                    kMerkmalWert = parseInt(kMerkmalWert);
                    nSelection_arr.push(kMerkmalWert);
                    $.evo.io().call('setSelectionWizardAnswers', ['{$AWA->getLocationKeyName()}', {$AWA->getLocationKeyId()},
                        {JTL\Shop::getLanguageID()}, nSelection_arr], {}, function (error, data) { });

                    return false;
                }
                function resetSelectionWizardAnswerJS(nFrage)
                {
                    nFrage = parseInt(nFrage);
                    nSelection_arr.splice(nFrage);
                    $.evo.io().call('setSelectionWizardAnswers', ['{$AWA->getLocationKeyName()}', {$AWA->getLocationKeyId()},
                        {JTL\Shop::getLanguageID()}, nSelection_arr], { }, function (error, data) { });

                    return false;
                }
            </script>
        {/block}
        {block name='selectionwizard-wizard'}
            <div id="selectionwizard" class="mb-md">
                {include file="selectionwizard/form.tpl" AWA=$AWA}
            </div>
        {/block}
    {/if}
{/block}