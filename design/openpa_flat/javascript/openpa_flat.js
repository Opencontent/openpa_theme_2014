(function($){
    "use strict";

    var globalDeferred = $.Deferred();
    $(window).bind('load',function(){
        // after loading all the scripts
        globalDeferred.resolve();
    });

    // waypoints helper functions
    $.fn.waypointInit = function(classN,offset,delay,inv){
        return $(this).waypoint(function(direction){
            var current = $(this);
            if(direction === 'down'){
                if(delay){
                    setTimeout(function(){
                        current.addClass(classN);
                    },delay);
                }
                else{
                    current.addClass(classN);
                }
            }else{
                if(inv == true){
                    current.removeClass(classN);
                }
            }
        },{ offset : offset })
    };

    // synchronise
    $.fn.waypointSynchronise = function (config) {
        var element = $(this);

        function addClassToElem(el, eq) {
            el.eq(eq).addClass(config.classN);
        }

        element.closest(config.container).waypoint(function (direction) {
            element.each(function (i) {
                if (direction === 'down') {

                    if (config.globalDelay != undefined) {
                        setTimeout(function () {
                            setTimeout(function () {
                                addClassToElem(element, i);
                            }, i * config.delay);
                        }, config.globalDelay);
                    } else {
                        setTimeout(function () {
                            addClassToElem(element, i)
                        }, i * config.delay);
                    }

                } else {

                    if (config.inv) {
                        setTimeout(function () {
                            element.eq(i).removeClass(config.classN);
                        }, i * config.delay);
                    }

                }
            });
        }, { offset: config.offset });
        return element;
    };

    globalDeferred.done(function () {

        // go to top button
        (function () {
            $('#go_to_top').waypointInit('animate_horizontal_finished', '0px', 0, true);
            $('#go_to_top').on('click', function () {
                $('html,body').animate({
                    scrollTop: 0
                }, 500);
            });
        })();

        // ie9 placeholder
        (function () {
            if ($('html').hasClass('ie9')) {
                $('input[placeholder]').each(function () {
                    $(this).val($(this).attr('placeholder'));
                    var v = $(this).val();
                    $(this).on('focus',function () {
                        if ($(this).val() === v) {
                            $(this).val("");
                        }
                    }).on("blur", function () {
                            if ($(this).val() == "") {
                                $(this).val(v);
                            }
                        });
                });

            }
        })();

        (function(){
            // sticky menu
            window.sticky = function () {
                var container = $('[role=banner] .header-bottom'),
                    offset = -container.outerHeight(),
                    menu = $('.menu_wrap'),
                    mHeight = menu.outerHeight();
                container.waypoint(function (direction) {
                    var _this = $(this);
                    if (direction == "down") {
                        menu.addClass('sticky').css('top',$('#ezwt').outerHeight());
                    } else if (direction == "up") {
                        menu.removeClass('sticky').css('top',0);
                    }
                }, {offset: offset});

                function getMenuWidth() {
                    menu.css('width', menu.parent().width());
                }

                getMenuWidth();
                $(window).on('resize', getMenuWidth);
            };
            sticky();

            // current menu
            $('.main-nav a[data-node]').each(function () {
                if ($.inArray($(this).data('node'), PathArray) > -1){
                    $(this).parents('li.menu-item').addClass('current');
                }
                if ( UiContext == 'browse' ) {
                    href = '/content/browse/' + $(this).data('node');
                }
            });
            if (window.location.pathname == UriPrefix){
                $('.main-nav a.home').parent().addClass('current');
            }

            // tooltip
            $('.has_tooltip').tooltip();

            //preview
            $('[data-load-remote]').on('click',function(e) {
                e.preventDefault();
                var $this = $(this);
                $($this.data('remote-target')).html('<em>Loading...</em>');
                var remote = $this.data('load-remote');
                if(remote) {
                    $($this.data('remote-target')).load(remote);
                }
            });


        })();

        // responsive menu
        window.rmenu = function () {

            var menuWrap = $('[role="navigation"]'),
                menu = $('.main_menu'),
                button = $('#menu_button');

            function isEndScroll( $submenu ){
                var submenuViewTop = $submenu.offset().top;
                var submenuViewBottom = submenuViewTop + $submenu.height();
                var $lastli = $( 'li', $submenu ).last();                
                var lastliTop = $lastli.offset().top;
                var lastliBottom = lastliTop + $lastli.height();                
                return (lastliTop <= submenuViewBottom); 
            }
            function menuScrollHelper() {
                $.each( $('.sub_menu_wrap > .sub_menu'), function(){                    
                    if ( $('li', $(this) ).length > 11 ){
                        if ($(this).parent().find('span.scroll-helper').length == 0) {
                            var $helper = $('<span class="scroll-helper">Altro</span>');
                            $helper.css({
                                'background': 'none repeat scroll 0 0 #eee',
                                'border-bottom-left-radius': '4px',
                                'border-bottom-right-radius': '4px',
                                'cursor': 'pointer',
                                'font-size': '0.8em',
                                'line-height': '30px',
                                'height': '30px',
                                'margin-top': '-30px',
                                'position': 'absolute',
                                'text-align': 'center',
                                'width': '100%',
                                'box-shadow': '0 1px 2px rgba(0, 0, 0, 0.15)'
                            });                            
                            $(this).parent().append( $helper );                            
                        }                        
                    }
                });                
            }
            
            function orientationChange() {
                if ($(window).width() < 767) {
                    button.off('click').on('click', function () {
                        menuWrap.stop().slideToggle();
                        $(this).toggleClass('active');
                    });
                    menu.children('li').children('a').off('click').on('click', function (e) {
                        var self = $(this);
                        self
                            .closest('li')
                            .toggleClass('current_click')
                            .find('.sub_menu_wrap')
                            .stop()
                            .slideToggle()
                            .end()
                            .closest('li')
                            .siblings('li')
                            .removeClass('current_click')
                            .children('a').removeClass('prevented').parent()
                            .find('.sub_menu_wrap')
                            .stop()
                            .slideUp();
                        if (!(self.hasClass('prevented'))) {
                            e.preventDefault();
                            self.addClass('prevented');
                        } else {
                            self.removeClass('prevented');
                        }
                    });
                } else if ($(window).width() > 767) {
                    menuWrap.removeAttr('style').find('.sub_menu_wrap').removeAttr('style');
                    menu.children('li').children('a').off('click');
                    menuScrollHelper();
                }
            }

            orientationChange();            

            $(window).on('resize', orientationChange);
            
            $(document).on( 'click', 'span.scroll-helper', function(){
                var $submenu = $(this).parent().find( '.sub_menu' );
                $submenu.stop().animate({
                    scrollTop: $submenu.scrollTop()+200
                });                
            });
            $('.sub_menu_wrap >.sub_menu').scroll( function(){
                var $helper = $(this).parent().find( 'span.scroll-helper' );                
                if (isEndScroll($(this))) {
                    $helper.hide();
                }else{
                    $helper.show();
                }
            });

        };
        rmenu();

        $('.side_menu').on('click', 'span', function (e) {
            if ($(this).closest('li').children('ul').length) {
                $(this).closest('li').toggleClass('active');
                //$(this).closest('li').next().slideToggle();
                e.preventDefault();
            }
        });

        (function () {
            $('#go_to_top').waypointInit('animate_horizontal_finished', '0px', 0, true);
            $('#go_to_top').on('click', function () {
                $('html,body').animate({
                    scrollTop: 0
                }, 500);
            });
        })();

        (function () {
            $('.sw_button').on('click', function () {
                $(this).parent().toggleClass('opened').siblings().removeClass('opened');
            });
        })();

    });
})(jQuery);