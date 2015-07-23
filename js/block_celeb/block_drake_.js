// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_drake_ = (function() {
  function block_drake_() {
    this.run = bind(this.run, this);
    var css;
    this.drake = {
      name: "drake",
      instagram_id: 14455831
    };
    css = "#instafeed {\n	display: none;\n}\n\n#drake-image {\n	height:100%;\n	position: relative;\n	left: -50px;\n	top: 0px;\n}";
    $('<style type="text/css"></style>').html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable celeb\" name=\"drake\">\n	<img id=\"drake-image\" src=\"img/drake.jpg\">\n	<div id=\"instafeed\"></div>\n</div>").appendTo(".drag-zone");
  }

  block_drake_.prototype.run = function() {
    return this.drake;
  };

  return block_drake_;

})();