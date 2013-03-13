(function() {
  var Box, Row, cheight, colors, drawy, heights, paper, width;

  colors = ['#D3402E', '#282826', '#EDD53F', '#E4F7F7', '#194F99'];

  width = $(window).width();

  Array.prototype.shuffle = function() {
    return this.sort(function() {
      return 0.5 - Math.random();
    });
  };

  paper = Raphael(0, 0, width, 960);

  Box = (function() {

    function Box(height, width, startX, startY, parent) {
      this.height = height;
      this.width = width;
      this.startX = startX;
      this.startY = startY;
      this.parent = parent;
      this.draw();
    }

    Box.prototype.draw = function() {
      var rect;
      rect = paper.rect(this.startX, this.startY, this.width, this.height);
      rect.attr('stroke-width', 0);
      return rect.attr('fill', colors.shuffle()[0]);
    };

    return Box;

  })();

  Row = (function() {

    function Row(height, start) {
      this.height = height;
      this.start = start;
      this.draw();
    }

    Row.prototype.debug = function() {
      var rect;
      rect = paper.rect(0, this.start, paper.width, this.height);
      rect.attr('fill', colors.shuffle()[0]);
      rect.attr('opacity', 0.5);
      return rect.attr('stroke-width', 1);
    };

    Row.prototype.draw = function() {
      var i, _i, _ref, _ref1, _results;
      _results = [];
      for (i = _i = 0, _ref = paper.width, _ref1 = this.height; 0 <= _ref ? _i <= _ref : _i >= _ref; i = _i += _ref1) {
        _results.push(new Box(this.height, this.height, i, this.start, this));
      }
      return _results;
    };

    return Row;

  })();

  heights = [40, 10, 20];

  cheight = paper.height;

  drawy = function() {
    var height, i, rows, start, _i, _results;
    paper.clear();
    rows = [];
    start = 0;
    _results = [];
    for (i = _i = 1; _i <= 20; i = ++_i) {
      height = heights.shuffle()[0];
      rows.push(new Row(height, start));
      _results.push(start += height);
    }
    return _results;
  };

  drawy();

  $('body').mousemove(function() {
    return drawy();
  });

}).call(this);
