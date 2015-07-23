// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_beyonce_ = (function() {
  function block_beyonce_() {
    this.run = bind(this.run, this);
    var css;
    this.beyonce = {
      name: "beyonce",
      instagram_id: 247944034
    };
    css = "#instafeed {\n	display: none;\n}\n\n#beyonce-image {\n	height:100%;\n	position: relative;\n	left: -40px;\n	bottom:0;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable celeb\" name=\"beyonce\">\n	<img id=\"beyonce-image\" src=\"img/beyonce.jpg\">\n<div id=\"instafeed\"></div>\n</div>").appendTo(".drag-zone");
  }

  block_beyonce_.prototype.run = function() {
    return this.beyonce;
  };

  return block_beyonce_;

})();
