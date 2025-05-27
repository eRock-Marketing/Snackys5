{block name='selectionwizard-index'}
    {if isset($AWA)}
        {opcMountPoint id='opc_before_selection_wizard' inContainer=false}
        {block name='selectionwizard-index-script'}
            {inline_script}<script>
                var nSelection_arr = [{implode(',', $AWA->getSelections())}];

                function setSelectionWizardAnswerJS(kMerkmalWert)
                {
                    kMerkmalWert = parseInt(kMerkmalWert);
                    nSelection_arr.push(kMerkmalWert);

                    $.evo.io().call(
                        'setSelectionWizardAnswers',
                        [
                            '{$AWA->getLocationKeyName()}',
                            {$AWA->getLocationKeyId()},
                            {$smarty.session.kSprache},
                            nSelection_arr
                        ],
                        { },
                        function (error, data) {
                            resetSelectionWizardListeners();
                        }
                    );

                    return false;
                }

                function resetSelectionWizardAnswerJS(nFrage)
                {
                    nFrage = parseInt(nFrage);
                    nSelection_arr.splice(nFrage);

                    $.evo.io().call(
                        'setSelectionWizardAnswers',
                        [
                            '{$AWA->getLocationKeyName()}',
                            {$AWA->getLocationKeyId()},
                            {$smarty.session.kSprache},
                            nSelection_arr
                        ],
                        { },
                        function (error, data) {
                            resetSelectionWizardListeners();
                        }
                    );

                    return false;
                }

                function resetSelectionWizardListeners()
                {
                    $("[id^=kMerkmalWert]").on('change', function() {
                        return setSelectionWizardAnswerJS($(this).val());
                    } );
                    $(".question-edit").on('click', function() {
                        return resetSelectionWizardAnswerJS($(this).data('value'));
                    } );
                    $(".selection-wizard-answer").on('click', function() {
                        return setSelectionWizardAnswerJS($(this).data('value'));
                    } );
                }

                $(window).on("load", function() {
                    resetSelectionWizardListeners();
                } );
            </script>{/inline_script}
        {/block}
        {block name='selectionwizard-index-include-form'}
            {if isset($AWA) && !empty($AWA->getQuestions())}
                <div id="selectionwizard" class="selection-wizard-wrapper {if $container|default:true}container {/if}">
                    {include file='selectionwizard/form.tpl' AWA=$AWA}
                </div>
            {/if}
        {/block}
    {/if}
{/block}
