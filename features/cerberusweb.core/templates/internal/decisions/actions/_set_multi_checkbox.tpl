{foreach from=$options item=option}
<label><input type="checkbox" name="{$namePrefix}[values][]" {if is_array($params.values) && in_array($option, $params.values)}checked="checked"{/if} value="{$option}"> {$option}</label><br>
{/foreach}
