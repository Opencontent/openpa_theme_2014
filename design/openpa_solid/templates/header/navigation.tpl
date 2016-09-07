<div class="navbar yamm">
    <div class="container">
        <div class="row">
        <div class="navbar-header col-md-4">
            {if $pagedata.is_login_page|not()}
            <button type="button" data-toggle="collapse" data-target="#main-menu" class="navbar-toggle"><span class="glyphicon glyphicon-menu-hamburger"></span></button>
            {/if}
            {if and( $pagedata.homepage|has_attribute('only_logo'), $pagedata.homepage|attribute('only_logo').data_int|eq(1) )}
                <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}" class="navbar-brand" style="height: 80px;">
                    <img src={$pagedata.homepage|attribute('logo').content['header_only_logo'].url|ezroot()} alt="{ezini('SiteSettings','SiteName')}" />
                </a>
            {else}
                <a href={"/"|ezurl} title="{ezini('SiteSettings','SiteName')}" class="navbar-brand">
                    {if and( is_set($pagedata.header.logo.url), $pagedata.header.logo.url)}
                        <img class="hidden-xs navbar-logo" src={$pagedata.header.logo.url|ezroot()} alt="{ezini('SiteSettings','SiteName')}" />
                    {/if}
                    <span class="navbar-title">
                        {ezini('SiteSettings','SiteName')}
                    </span>
                </a>
            {/if}
        </div>
        {if $pagedata.is_login_page|not()}
        <div class="menu-container col-md-8">
            <div id="main-menu" class="navbar-collapse collapse">
                {include uri='design:menu/top_menu.tpl'}
            </div>
        </div>
        {/if}
        </div>
    </div>
</div>
