// Generated by CoffeeScript 1.9.3
var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

this.block_source_ = (function() {
  function block_source_() {
    this.run = bind(this.run, this);
    var css;
    css = "		";
    $("<style type='text/css'></style>").html(css).appendTo("head");
    $("<div class=\"drag-wrap draggable source\" name=\"source\">\n</div>").appendTo(".drag-zone");
  }

  block_source_.prototype.run = function() {
    return "SOURCE IS HERE";
  };

  return block_source_;

})();
