{if $active_worker->hasPriv('timetracking.actions.create')}
<button type="button" onclick="timeTrackingTimer.play('cerberusweb.contexts.opportunity','{$opp->id}');" title="{$translate->_('timetracking.ui.button.track')|capitalize}"><span class="cerb-sprite sprite-stopwatch"></span></button>
{/if}