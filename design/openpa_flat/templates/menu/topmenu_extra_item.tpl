{if $extra_item}
<li class="menu-item extra-menu-item hidden-xs hidden-sm">
  <a href="area.html" data-toggle="modal" data-target="#extra_menu_box">
    <b>{$extra_item.data_map.name.content|wash()}</b>
  </a>
</li>
{/if}

