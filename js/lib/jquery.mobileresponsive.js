//PLUGIN MOBILE RESPONSIVE BY DEVELPIXEL 2014.
(function($) {
    $.fn.mobileResponsive = function() {
        var target = $(this);
        var resXsmall = 600; // Extra small screen / phone
        var resSmall = 600; // Small screen / tablet
        var resMedium = 1263; // Medium screen / desktop
        var resLarge = 1600; // Large screen / wide desktop
        var width = $(window).width();

        function checkRes(width) {
            if (width <= resSmall) {
                target.addClass('dpXsmall');    
                target.removeClass('dpSmall');
                target.removeClass('dpMedium');
                target.removeClass('dpLarge');
            } else if (width >= resSmall && width < resMedium) {
                target.addClass('dpSmall');
                target.removeClass('dpMedium');
                target.removeClass('dpLarge');
                target.removeClass('dpXsmall');

            } else if (width >= resMedium && width < resLarge) {
                target.addClass('dpMedium');
                target.removeClass('dpSmall');
                target.removeClass('dpLarge');
                target.removeClass('dpXsmall');
            } else if (width >= resLarge) {
                target.addClass('dpLarge');
                target.removeClass('dpSmall');
                target.removeClass('dpMedium');
                target.removeClass('dpXsmall');
            }
        }
        //Begin Check Resolution
        checkRes(width, target);
        //Begin Responsive
        $(window).resize(function() {
            width = $(this).width();
            checkRes(width);
            //console.log(width);
        });
    };
}(jQuery));
