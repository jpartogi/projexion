(function($) {

    jQuery.fn.inlineEdit = function(options) {
        jQuery.fn.inlineEdit.prototype.options = options;

        this.each(onBind);

        return this;
    }

    function onBind(){
        jQuery(this).bind("click", {el: this}, onClick);
    }

    function onClick(e){
        var element = jQuery(e.data.el);
        var clone = element.clone();

        var replacement = "<input class='inline' type='text' width='100%' value=\""+element.text()+"\" />";
        
        clone = clone.empty().append(replacement);
        element.replaceWith(clone);

        jQuery(".inline").bind("keypress", onKeyPress);
    }

    function onKeyPress(e){
        var newValue = jQuery(this).focus().val();
        
        var options = jQuery.fn.inlineEdit.prototype.options;
        var name = options.name;
        var url =  options.url;
        
        var id = $(this).focus().parent().parent().find("input[name='"+name+"']").val();

        if(e.which === 13){
            jQuery.ajax({
                type: "get",
                url: url,
                data: ({value: newValue, id : id}),
                success: callback
            });
        }
    }
    
    function callback(data){
        var input  = jQuery('.inline:focus'); // Get it from the focused input only

        var element = input.parent();
        var updatedValue = input.val();
        var clone = element.clone();
        clone = clone.empty().append(updatedValue);
        element.replaceWith(clone);

        var options = jQuery.fn.inlineEdit.prototype.options;
        clone.inlineEdit(options);
    }

})(jQuery);