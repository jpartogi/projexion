(function($) {

    jQuery.fn.slugify = function(options) {
        jQuery.fn.slugify.prototype.options = options;

        this.each(onBind);

        return this;
    }

    var slugify = function(s, maxChars) {
        if(maxChars === undefined) maxChars = 100;

        removelist = ["a", "an", "as", "at", "before", "but", "by", "for", "from",
                      "is", "in", "into", "like", "of", "off", "on", "onto", "per",
                      "since", "than", "the", "this", "that", "to", "up", "via",
                      "with"];

        r = new RegExp('\\b(' + removelist.join('|') + ')\\b', 'gi');
        s = s.replace(r, '');

        s = s.replace(/[^-\w\s]/g, '');  // remove unneeded chars
        s = s.replace(/^\s+|\s+$/g, ''); // trim leading/trailing spaces
        s = s.replace(/[-\s]+/g, '-');   // convert spaces to hyphens
        s = s.toLowerCase();             // convert to lowercase

        return s.substring(0, maxChars);// trim to first num_chars chars
    }

    function onBind(){
        var options = jQuery.fn.slugify.prototype.options;
        var target = '#' + options.target;

        jQuery(this).bind('keyup', function(){
            jQuery(target).val(slugify(jQuery(this).val()));
        });
    }

})(jQuery);