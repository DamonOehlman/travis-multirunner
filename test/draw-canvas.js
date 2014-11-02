var test = require('tape');
var canvas;
var context;

test('create a canvas', function(t) {
  t.plan(1);
  canvas = document.createElement('canvas');
  t.ok(canvas instanceof HTMLCanvasElement);
});

test('get the rendering context', function(t) {
  t.plan(1);
  t.ok(context = canvas.getContext('2d'));
});

