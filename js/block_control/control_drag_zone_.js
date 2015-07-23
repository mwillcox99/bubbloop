// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.control_drag_zone_ = (function() {
  function control_drag_zone_(left, top, diameter, bubble_type) {
    this.run = bind(this.run, this);
    var append_to_this, css, inValid_bubbles, items, onScroll;
    this.counter_id = window.counter;
    window.counter = this.counter_id + 1;
    this.left = left;
    this.top = top;
    this.diameter = diameter;
    this.bubble_type = bubble_type;
    css = ".droppable-" + this.counter_id + " {\n	position: absolute;\n	top: " + top + "px;\n	left: " + left + "px;\n	width: " + diameter + "px;\n	height: " + diameter + "px;\n	border: 1px black solid;\n	background: rgba(255, 255, 255, 0.8);\n	font-size: 20px;\n}";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("." + this.bubble_type).css({
      opacity: '1'
    });
    inValid_bubbles = $(".draggable:not(." + this.bubble_type + ")");
    inValid_bubbles.css({
      'opacity': '0.6'
    });
    append_to_this = null;
    if (typeof $target !== "undefined" && $target !== null) {
      append_to_this = $target;
    } else {
      append_to_this = '.drop-zone';
    }
    $("<div id='celeb-drop-zone' class='droppable steps droppable-" + this.counter_id + "' role='condition'><br>\n	STEP 1:<br>\n	DROP CELEB HERE!\n</div>").appendTo(".drop-zone");
    items = $(".drag-wrap");
    onScroll = (function(_this) {
      return function() {
        var i, pos, s2;
        i = 0;
        while (i < items.length) {
          pos = items[i].getBoundingClientRect();
          s2 = (pos.left + pos.width / 2 - (window.innerWidth / 2)) / (window.innerWidth / 1.2);
          s2 = 1 - Math.abs(s2);
          $(items[i]).css({
            '-webkit-transform': "scale(" + s2 + ")"
          });
          ++i;
        }
      };
    })(this);
    interact(".droppable-" + this.counter_id).dropzone({
      accept: '.draggable',
      overlap: .1,
      ondropactivate: function(event) {
        var $target;
        $target = $(event.target);
        return $target.addClass('can--drop');
      },
      ondragenter: function(event) {
        var $draggableElement, dropCenter, dropRect, dropzoneElement;
        $draggableElement = $(event.relatedTarget);
        dropzoneElement = event.target;
        dropRect = interact.getElementRect(dropzoneElement);
        dropCenter = {
          x: dropRect.left + dropRect.width / 2,
          y: dropRect.top + dropRect.height / 2
        };
        event.draggable.draggable({
          snap: {
            targets: [dropCenter]
          }
        });
        dropzoneElement.classList.add('can--catch');
        return $draggableElement.addClass('drop--me');
      },
      ondragleave: function(event) {
        var $relatedTarget, $target;
        $target = $(event.target);
        $relatedTarget = $(event.relatedTarget);
        $target.removeClass('can--catch');
        $relatedTarget.removeClass('caught--it');
        return $relatedTarget.removeClass('drop--me');
      },
      ondrop: (function(_this) {
        return function(event) {
          var $clone, $related_target, $target, block_name, x, y;
          $target = $(event.target);
          $related_target = $(event.relatedTarget);
          block_name = $related_target.attr("name");
          _this.block = window["block_" + block_name];
          if ($related_target.hasClass('drag-wrap')) {
            $clone = $related_target.detach();
            $clone.removeClass('drag-wrap');
            $clone.removeClass('getting--dragged');
            $clone.appendTo('.drop-zone');
            $clone.removeClass("" + _this.bubble_type);
            x = $target.position().left + 10;
            y = $target.position().top + 10;
            $clone.css({
              '-webkit-transform': "translate(" + x + "px, " + y + "px)",
              position: 'absolute',
              opacity: 0.4,
              width: "" + diameter,
              height: "" + diameter
            });
            $clone.attr('data-x', x);
            $clone.attr('data-y', y);
            $target.css({
              'opacity': '0'
            });
            $("." + _this.bubble_type).remove();
            items = $(".drag-wrap");
            onScroll();
            return window.control.expand();
          }
        };
      })(this),
      ondropdeactivate: function(event) {
        var $target;
        $target = $(event.target);
        return $target.removeClass('can--drop', 'can--catch');
      }
    });
  }

  control_drag_zone_.prototype.run = function(name, cb) {
    return this.block.run(name, cb);
  };

  return control_drag_zone_;

})();
