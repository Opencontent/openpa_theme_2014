<div class="row event-item">
    <div class="col-xs-4 calendar-date">
        <span class="month">{$item.from|datetime( 'custom', '%M' )}</span>
        <span class="day">{$item.from|datetime( 'custom', '%j' )}</span>
    </div>
    <div class="col-xs-8">
        {node_view_gui content_node=$item.node view=text_linked shorten=80}
    </div>
</div>