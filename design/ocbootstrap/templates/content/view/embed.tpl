{* DO NOT EDIT THIS FILE! Use an override template instead. *}
{default attribute_parameters=array() show_link=true()}
{if and( $object.main_node_id|null|not, $show_link )}
    {def $openpa = object_handler($object.main_node)}
    <a href="{$openpa.content_link.full_link}">{$object.name|wash}</a>
    {undef $openpa}
{else}
    {$object.name|wash}
{/if}
{/default}