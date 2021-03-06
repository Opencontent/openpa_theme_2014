{if and( is_set($block.custom_attributes.node_id), $block.custom_attributes.node_id|gt(0) )}    
    {def $subtreearray = array( $block.custom_attributes.node_id )}
{else}    
    {def $subtreearray = array( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
{/if}

{if $block.custom_attributes.class|ne('')}
    {def $class_filters = $block.custom_attributes.class|explode(',')}
{/if}

{def $class = fetch( 'content', 'class', hash( 'class_id', $class_filters[0] ) )}
{if $class}
  {if is_set($block.custom_attributes.color_style)}<div class="color color-{$block.custom_attributes.color_style}">{/if}
  {if $block.name|ne('')}
  <div class="widget_title">
      <h2>{$block.name|wash()}</h2>
  </div>
  {/if}
  <div class="widget {$block.view} search_box">  
    <div class="widget_content">
      <form id="search-form-box" action="{'content/advancedsearch'|ezurl('no')}" method="get">
        {include name = searchform
           uri = 'design:parts/class_search_form.tpl'
           class = $class			   			   
           subtree = $subtreearray
           open_advanced = false()
           exclude_attributes = openpaini( 'GestioneAttributi', 'attributi_da_escludere_dalla_ricerca', array() )}
      </form>
    </div>  
  </div>
  {if is_set($block.custom_attributes.color_style)}</div>{/if}
{/if}