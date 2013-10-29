(function($) {
  return $.extend($.fn, {
    backboneLink: function(model) {
      return $(this).find(":input").each(function() {
        var el, name;
        el = $(this);
        name = el.attr("name");

        if(typeof name !== "undefined" && name !== null) {
          model.bind("change:" + name, function() {
            var newVal = model.get(name);

            if(el.is(":checkbox")) {
              el.prop({checked: !!newVal});
            } else {
              return el.val(newVal);
            }

          });

          return $(this).bind("change", function() {
            var attrs;
            el = $(this);
            attrs = {};

            if(el.is(":checkbox")) {
              attrs[el.attr("name")] = el.prop("checked");
            } else {
              attrs[el.attr("name")] = el.val();
            }

            return model.set(attrs);
          });
        }

      });
    }
  });
})(jQuery);
