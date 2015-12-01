{$div_id = "peek{uniqid()}"}

{$org = $model->getOrg()}
{$addy = $model->getEmail()}

<div id="{$div_id}">
	<div style="float:left;margin-right:10px;">
		<img src="{devblocks_url}c=avatars&context=contact&context_id={$model->id}{/devblocks_url}?v={$model->updated_at}" style="height:75px;width:75px;border-radius:5px;border:1px solid rgb(235,235,235);vertical-align:middle;">
	</div>
	
	<div style="float:left;">
		<h1 style="color:inherit;">
			{$model->getName()}
			{if $model->gender == 'M'}
			<span class="glyphicons glyphicons-male" style="color:rgb(2,139,212);vertical-align:middle;"></span>
			{elseif $model->gender == 'F'}
			<span class="glyphicons glyphicons-female" style="color:rgb(243,80,157);vertical-align:middle;"></span>
			{/if}
		</h1>
		
		<div>
			{$model->title}{if $model->title && $org} at {/if}
			<a href="javascript:;" style="font-weight:bold;" class="cerb-peek-trigger no-underline" data-context="{CerberusContexts::CONTEXT_ORG}" data-context-id="{$org->id}">{$org->name}</a>
		</div>
		
		<div style="margin-top:5px;">
			{if !empty($model->id)}
				{$object_watchers = DAO_ContextLink::getContextLinks('cerberusweb.contexts.contact', array($model->id), CerberusContexts::CONTEXT_WORKER)}
				{include file="devblocks:cerberusweb.core::internal/watchers/context_follow_button.tpl" context='cerberusweb.contexts.contact' context_id=$model->id full=true}
			{/if}
			
			<button type="button" class="cerb-peek-edit" data-context="{CerberusContexts::CONTEXT_CONTACT}" data-context-id="{$model->id}" data-edit="true"><span class="glyphicons glyphicons-cogwheel"></span> {'common.edit'|devblocks_translate|capitalize}</button>
			{if $model}<button type="button" class="cerb-peek-profile"><span class="glyphicons glyphicons-nameplate"></span> {'common.profile'|devblocks_translate|capitalize}</button>{/if}
		</div>
	</div>
</div>

<div style="clear:both;padding-top:10px;"></div>

{if $addy || $model->phone || $model->mobile || $model->location}
<fieldset class="peek">
	<legend>Contact Info</legend>
	{if $addy}
	<div style="float:left;width:200px;margin:0px 5px 5px 0px;">
		<b>Email:</b><br>
		<ul class="bubbles">
			<li class="bubble-gray"><img src="{devblocks_url}c=avatars&context=contact&context_id={$model->id}{/devblocks_url}?v={$model->updated_at}" style="height:16px;width:16px;vertical-align:middle;border-radius:16px;"> <a href="javascript:;" class="cerb-peek-trigger" data-context="{CerberusContexts::CONTEXT_ADDRESS}" data-context-id="{$addy->id}">{$addy->email}</a></li>
		</ul>
	</div>
	{/if}
	
	{if $model->phone}
	<div style="float:left;width:200px;margin:0px 5px 5px 0px;">
		<b>Phone:</b><br>
		<a href="tel:{$model->phone}" class="no-underline">{$model->phone}</a>
	</div>
	{/if}
	
	{if $model->mobile}
	<div style="float:left;width:200px;margin:0px 5px 5px 0px;">
		<b>Mobile:</b><br>
		<a href="tel:{$model->mobile}" class="no-underline">{$model->mobile}</a>
	</div>
	{/if}
	
	{if $model->location}
	<div style="float:left;width:200px;margin:0px 5px 5px 0px;">
		<b>Location:</b><br>
		{$model->location}
	</div>
	{/if}
	
	<br clear="all">
	
	<div style="margin-top:5px;">
		<button type="button" class="cerb-search-trigger" data-context="{CerberusContexts::CONTEXT_ADDRESS}" data-query="contact.id:{$model->id}"><div class="badge-count">{$activity_counts.emails|default:0}</div> {if $activity_counts.emails == 1}{'common.email_address'|devblocks_translate|capitalize}{else}{'common.email_addresses'|devblocks_translate|capitalize}{/if}</button>
	</div>
</fieldset>
{/if}

<fieldset class="peek">
	<legend>{'common.activity'|devblocks_translate|capitalize}</legend>
	
	<div>
		<div style="display:inline-block;border-radius:10px;width:10px;height:10px;background-color:rgb(230,230,230);margin-right:5px;line-height:10px;"></div><b>{$model->getName()}</b>{if $model->username} ({$model->username}){/if} {if $model->last_login_at}last logged in <abbr title="{$model->last_login_at|devblocks_date}">{$model->last_login_at|devblocks_prettytime}</abbr>{else}has never logged in{/if}
	</div>
</fieldset>

<fieldset class="peek">
	<legend>{'common.tickets'|devblocks_translate|capitalize}</legend>

	<div>
		<button type="button" class="cerb-search-trigger" data-context="{CerberusContexts::CONTEXT_TICKET}" data-query="contact.id:{$model->id} status:o,w,c"><div class="badge-count">{$activity_counts.tickets.total|default:0}</div> {'common.all'|devblocks_translate|capitalize}</button>
		<button type="button" class="cerb-search-trigger" data-context="{CerberusContexts::CONTEXT_TICKET}" data-query="contact.id:{$model->id} status:o"><div class="badge-count">{$activity_counts.tickets.open|default:0}</div> {'status.open'|devblocks_translate|capitalize}</button>
		<button type="button" class="cerb-search-trigger" data-context="{CerberusContexts::CONTEXT_TICKET}" data-query="contact.id:{$model->id} status:w"><div class="badge-count">{$activity_counts.tickets.waiting|default:0}</div> {'status.waiting'|devblocks_translate|capitalize}</button>
		<button type="button" class="cerb-search-trigger" data-context="{CerberusContexts::CONTEXT_TICKET}" data-query="contact.id:{$model->id} status:c"><div class="badge-count">{$activity_counts.tickets.closed|default:0}</div> {'status.closed'|devblocks_translate|capitalize}</button>
	</div>
</fieldset>

{include file="devblocks:cerberusweb.core::internal/peek/peek_links.tpl" links=$links}

</form>

<script type="text/javascript">
$(function() {
	var $popup = genericAjaxPopupFind('#{$div_id}');
	var $layer = $popup.attr('data-layer');
	
	$popup.one('popup_open', function(event,ui) {
		$popup.dialog('option','title',"{'Contact'|escape:'javascript' nofilter}");
		$popup.find('input:text:first').focus();
		
		// Peek edit

		$popup.find('button.cerb-peek-edit')
			.cerbPeekTrigger({ 'view_id': '{$view_id}' })
			.on('cerb-peek-saved', function(e) {
				genericAjaxPopup($layer,'c=internal&a=showPeekPopup&context={CerberusContexts::CONTEXT_CONTACT}&context_id={$model->id}&view_id={$view_id}','reuse',false,'50%');
			})
			.on('cerb-peek-deleted', function(e) {
				genericAjaxPopupClose($layer);
			})
			;
		
		// Peek triggers
		$popup.find('a.cerb-peek-trigger').cerbPeekTrigger();
		
		// Searches
		$popup.find('button.cerb-search-trigger')
			.cerbSearchTrigger()
			;
		
		// View profile
		$popup.find('.cerb-peek-profile').click(function(e) {
			if(e.metaKey) {
				window.open('{devblocks_url}c=profiles&type=contact&id={$model->id}-{$model->getName()|devblocks_permalink}{/devblocks_url}', '_blank');
				
			} else {
				document.location='{devblocks_url}c=profiles&type=contact&id={$model->id}-{$model->getName()|devblocks_permalink}{/devblocks_url}';
			}
		});
		
	});
});
</script>