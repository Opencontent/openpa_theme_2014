{if $node|has_attribute( 'struttura_di_riferimento' )}
  {attribute_view_gui attribute=$node.data_map.titolo} {attribute_view_gui attribute=$node.data_map.struttura_di_riferimento}
{/if}