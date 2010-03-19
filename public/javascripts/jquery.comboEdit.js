(function($) {

    jQuery.fn.comboEdit = function(options){
        options.selector = jQuery(this).selector;

        var onClick = function(e){

            var toBeReplaced = jQuery(this);

            var data = {};

            var parent_id = jQuery(this).parent().parent().find("."+options.parentIdClass).val();
            data.parent_id = parent_id;

            jQuery.get(options.getComboBoxURL, data, function(response){
                toBeReplaced.replaceWith(response);

                jQuery('option').click(function(){
                    var theValue = jQuery(this).val();
                    var toBeReplaced = jQuery(this).parent().parent();

                    data.id = theValue;

                    jQuery.post(options.submitURL, data, function(response){

                        toBeReplaced.replaceWith(response);

                        jQuery(options.selector).click(onClick);

                    }, 'html');

                });

            }, 'html');

        }

        return this.each(function(){
            jQuery(this).click(onClick);            
        });
    }

})(jQuery);