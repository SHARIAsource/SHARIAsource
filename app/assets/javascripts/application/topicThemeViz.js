var root = {};
function CreateViz(dataset,selector) {
  var svg = d3.select(selector),
      margin = 30,
      diameter = +svg.attr("height"),
      g = svg.append("g").attr("transform","translate(" + diameter / 2 + "," + diameter / 2 + ")");

  var color = d3.scaleLinear()
      .domain([-1, 5])
      .range(["hsl(0,0%,100%)", "hsl(0,0%,50%)"])
      .interpolate(d3.interpolateHcl);

  var pack = d3.pack()
      .size([diameter - margin, diameter - margin])
      .padding(2);

  root[selector] = d3.hierarchy(dataset)
      .sum(function(d) { return d.size; })
      .sort(function(a, b) { return b.value - a.value; });

  var focus = root[selector],
      nodes = pack(root[selector]).descendants(),
      view;

  var circle = g.selectAll(selector + " circle")
    .data(nodes)
    .enter().append("circle")
      .attr("class", function(d) {
        nameClass = d.data.name.toLowerCase().replace(/\s/g,"-");
        return d.parent ? d.children ? "node "+nameClass : "node node--leaf "+nameClass : "node node--root "+nameClass;
      })
      .style("fill", function(d) { return d.children ? color(d.depth) : null; })
      .on("click", function(d) { if (focus !== d) zoom(d), d3.event.stopPropagation(); });

  var text = g.selectAll(selector + " text")
    .data(nodes)
    .enter().append("text")
      .attr("class", "label")
      .style("fill-opacity", function(d) { return d.parent === root[selector] ? 1 : 0; })
      .style("display", function(d) { return d.parent === root[selector] ? "inline" : "none"; })
      .on("click",function(d) { console.log(d.data.searchLink); d3.event.stopPropagation(); })
      .append("a")
        .text(function(d) { return d.data.name; })
        .attr("href",function(d) { return d.data.searchLink; });

  // console.log(text);

  legendData = [];
  for (var i = 0; i < dataset.children.length; i++) {
    var datum = dataset.children[i]
    for (var j = 0; j < datum.children.length; j++) {
      var subdatum = datum.children[j]
      if (legendData.indexOf(subdatum.name)==-1) {
        legendData.push(subdatum.name);
      }
    }
  }
  legendData = legendData.sort();

  var legendRectSize = 18;
  var legendSpacing = 4;
  var legendColors = [
    "008856", "F38400", "A1CAF1", "875692", "F3C300",
    "BE0032", "848482", "C2B280", "E68FAC", "0067A5",
    "F99379", "604E97", "F6A600", "B3446C", "DCD300",
    "882D17", "8DB600", "654522", "E25822", "2B3D26"
  ];

  for (var i = 0; i < legendData.length; i++) {
    datum = legendData[i];
    nameClass = datum.toLowerCase().replace(/\s/g,"-");
    $("#dynamic-style").append(".node--leaf."+nameClass+" { fill: #"+legendColors[i]+"; }")
  }
  var legend = svg.selectAll(".legend")
    .data(legendData)
    .enter()
    .append('g')
    .attr('class','label')
    .attr('transform', function(d,i) {
      var height = legendRectSize + legendSpacing;
      var offset = height * legendData.length / 2;
      var horz = legendSpacing;
      var vert = i * height + legendSpacing;
      return 'translate(' + horz + ',' + vert + ')';
    })
  legend.append('rect')
    .attr('width', legendRectSize)
    .attr('height', legendRectSize)
    .style('fill', function(d,i) { return "#"+legendColors[i]; })
    .style('stroke', function(d,i) { return "#"+legendColors[i]; })
  legend.append('text')
    .attr('x', legendRectSize + legendSpacing)
    .attr('y', legendRectSize - legendSpacing)
    .attr('text-anchor','start')
    .text(function(d) { return d; });

    var node = g.selectAll("circle,text");

    svg
        .style("background", color(-1))
        .on("click", function() { zoom(root[selector]); });

    zoomTo([root[selector].x, root[selector].y, root[selector].r * 2 + margin]);

    function zoom(d) {
      var focus0 = focus; focus = d;

      var transition = d3.transition()
          .duration(750)
          .tween("zoom", function(d) {
            var i = d3.interpolateZoom(view, [focus.x, focus.y, focus.r * 2 + margin]);
            return function(t) { zoomTo(i(t)); };
          });

      transition.selectAll(selector+" text")
        .filter(function(d) { return d.parent === focus || this.style.display === "inline"; })
          .style("fill-opacity", function(d) { return d.parent === focus ? 1 : 0; })
          .on("start", function(d) { if (d.parent === focus) this.style.display = "inline"; })
          .on("end", function(d) { if (d.parent !== focus) this.style.display = "none"; });

      d3.selectAll(selector+" .node")
        .classed("parent-is-focus",function(d) {
          return d.parent === focus && focus != root[selector];
        })
        .classed("is-focus",function(d) {
          return d === focus && focus != root[selector];
        });
    }

    function zoomTo(v) {
      var k = diameter / v[2]; view = v;
      node.attr("transform", function(d) { return "translate(" + (d.x - v[0]) * k + "," + (d.y - v[1]) * k + ")"; });
      circle.attr("r", function(d) { return d.r * k; });
    }
}

function getTransformation(transform) {
  // Create a dummy g for calculation purposes only. This will never
  // be appended to the DOM and will be discarded once this function
  // returns.
  var g = document.createElementNS("http://www.w3.org/2000/svg", "g");

  // Set the transform attribute to the provided string value.
  g.setAttributeNS(null, "transform", transform);

  // consolidate the SVGTransformList containing all transformations
  // to a single SVGTransform of type SVG_TRANSFORM_MATRIX and get
  // its SVGMatrix.
  var matrix = g.transform.baseVal.consolidate().matrix;

  // Below calculations are taken and adapted from the private function
  // transform/decompose.js of D3's module d3-interpolate.
  var {a, b, c, d, e, f} = matrix; // ES6, if this doesn't work, use below assignment
  // var a=matrix.a, b=matrix.b, c=matrix.c, d=matrix.d, e=matrix.e, f=matrix.f; // ES5
  var scaleX, scaleY, skewX;
  if (scaleX = Math.sqrt(a * a + b * b)) a /= scaleX, b /= scaleX;
  if (skewX = a * c + b * d) c -= a * skewX, d -= b * skewX;
  if (scaleY = Math.sqrt(c * c + d * d)) c /= scaleY, d /= scaleY, skewX /= scaleY;
  if (a * d < b * c) a = -a, b = -b, skewX = -skewX, scaleX = -scaleX;
  return {
    translateX: e,
    translateY: f,
    rotate: Math.atan2(b, a) * 180 / Math.PI,
    skewX: Math.atan(skewX) * 180 / Math.PI,
    scaleX: scaleX,
    scaleY: scaleY
  };
}

function arrangeLabels() {
  var move = 1;
  while(move > 0) {
    move = 0;
    svg.selectAll(".label")
       .each(function() {
         var that = this,
             a = this.getBoundingClientRect();
         svg.selectAll(".label")
            .each(function() {
              if(this != that) {
                var b = this.getBoundingClientRect();
                if((Math.abs(a.left - b.left) * 2 < (a.width + b.width)) &&
                   (Math.abs(a.top - b.top) * 2 < (a.height + b.height))) {
                  // overlap, move labels
                  console.log(this);
                  console.log(that);
                  var dx = (Math.max(0, a.right - b.left) +
                           Math.min(0, a.left - b.right)) * 0.01,
                      dy = (Math.max(0, a.bottom - b.top) +
                           Math.min(0, a.top - b.bottom)) * 0.02,
                      tt = getTransformation(d3.select(this).attr("transform")),
                      to = getTransformation(d3.select(that).attr("transform"));
                  move += Math.abs(dx) + Math.abs(dy);

                  to.translate = [ to.translateX + dx, to.translateY + dy ];
                  tt.translate = [ tt.translateX - dx, tt.translateY - dy ];
                  d3.select(this).attr("transform", "translate(" + tt.translate + ")");
                  d3.select(that).attr("transform", "translate(" + to.translate + ")");
                  a = this.getBoundingClientRect();
                }
              }
            });
       });
     }
   }
