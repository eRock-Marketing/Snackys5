{block name='selectionwizard-index'}
{if isset($AWA)}
    <script>
        var nSelection_arr = [{implode(',', $AWA->getSelections())}];

        function setSelectionWizardAnswerJS(kMerkmalWert)
        {
            kMerkmalWert = parseInt(kMerkmalWert);
            nSelection_arr.push(kMerkmalWert);
            $.evo.io().call('setSelectionWizardAnswers', ['{$AWA->getLocationKeyName()}', {$AWA->getLocationKeyId()},
                {$smarty.session.kSprache}, nSelection_arr], {}, function (error, data) { });

            return false;
        }

        function resetSelectionWizardAnswerJS(nFrage)
        {
            nFrage = parseInt(nFrage);
            nSelection_arr.splice(nFrage);
            $.evo.io().call('setSelectionWizardAnswers', ['{$AWA->getLocationKeyName()}', {$AWA->getLocationKeyId()},
                {$smarty.session.kSprache}, nSelection_arr], { }, function (error, data) { });

            return false;
        }
    </script>
    <div id="selectionwizard" class="mb-md">
        {include file="selectionwizard/form.tpl" AWA=$AWA}
    </div>
{/if}
{/block}