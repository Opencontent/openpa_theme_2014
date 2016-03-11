{set_defaults(hash('image_class', 'small'))}
<div class="class-{$node.class_identifier} media">

    {if $node|has_attribute( 'image' )}
        <a class="pull-left hidden-xs" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">
            {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class=$image_class css_class="media-object"}
        </a>
    {/if}
    <div class="media-body">
        <h3 class="media-heading">
            <a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>
        </h3>

        {if $openpa.content_line.has_content}
          <dl>
            {foreach $openpa.content_line.attributes as $openpa_attribute}
              <dt>
              {if $openpa_attribute.line.show_label}
                 <strong>{$openpa_attribute.label}</strong>
              {/if}
              </dt>
              <dd>
                {attribute_view_gui attribute=$openpa_attribute.contentobject_attribute href=cond($openpa_attribute.line.show_link|not, 'no-link', '')}
              </dd>
            {/foreach}
          </dl>

        {/if}

    </div>
</div>
