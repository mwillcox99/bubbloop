// Generated by CoffeeScript 1.9.3
this.control_drop_area_ = (function() {
  function control_drop_area_() {
    var css;
    css = ".drop_area {\n	position: relative;\n}\n\n#new-button {\n\n}";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div id='current-step' class='text'></div>\n<div class='drop_area' role='drop_area'></div>").appendTo($("body"));
    this.zones = 1;
    this.celebrity = new control_drag_zone_(5, 50, 365, 'celeb');
  }

  control_drop_area_.prototype.expand = function() {
    var current_counter;
    current_counter = window.counter;
    switch (current_counter) {
      case 1:
        return this.source = new control_drag_zone_(50, 70, 180, 'source');
      case 2:
        return this.filter = new control_drag_zone_(120, 70, 180, 'filter');
      case 3:
        return this.action = new control_drag_zone_(85, 162, 180, 'action');
      case 4:
        return this.create_button();
    }
  };

  control_drop_area_.prototype.create_button = function() {
    var $blacken, $new_div;
    $blacken = $("<div></div>").css({
      'z-index': '500',
      'opacity': '0.5',
      'background-color': 'black',
      width: '100%',
      height: '100%',
      position: 'absolute',
      left: '0px',
      top: '0px'
    });
    $("body").prepend($blacken);
    $new_div = $("<div id=\"new-button\">\n	<p style='position:absolute;left: 28px;top:22px;' >RUN!</p>\n</div>");
    $new_div.css({
      'border-radius': '100px',
      width: '90px',
      height: '90px',
      position: 'absolute',
      top: '153px',
      left: '130px',
      'z-index': '10000',
      'background-color': 'white'
    });
    $("body").prepend($new_div);
    $new_div.addClass('can--drop');
    return $new_div.bind('tap click', (function(_this) {
      return function() {
        return _this.run();
      };
    })(this));
  };

  control_drop_area_.prototype.run = function(outer_cb) {
    var celeb;
    celeb = this.celebrity.run();
    return this.source.run(celeb, (function(_this) {
      return function(list) {
        return async.forEachOfSeries(list, function(element, i, cb) {
          if (_this.filter.run(element)) {
            _this.action.run(element, cb);
          } else {
            console.log("Element does not pass filter");
            cb();
          }
        }, function(err) {
          if (outer_cb != null) {
            return outer_cb();
          }
        });
      };
    })(this));
  };

  return control_drop_area_;

})();
