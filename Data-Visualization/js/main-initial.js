function type(d) {
  var format = d3.time.format("%Y");
  return {
    'Year': format.parse(d.year),
    'Carrier Name': d.carrier_name,
    'On Time': +d.timely_rate,
    'Arrivals': +d.arrivals
  };
} 

function draw(data) {
  
  'use strict';

  // add title
  d3.select('body')
    .append('center')
    .append('h2')
    .text('Timeliness of Most Operating Airlines in US (June 2003 to August 2016)');

  // append svg

  var width = 900,
      height = 500,
      margin = 60;

  
  var svg = d3.select("body")
            .append('center')
            .append("svg")
            .attr("width", width + margin)
            .attr("height", height + margin)
            .append('g')
            .attr('class','chart');

  // new chart

  var myChart = new dimple.chart(svg, data);

  // setup y axis
  var minY = 70,
      maxY = 90;
  var y = myChart.addMeasureAxis('y', 'On Time');
  y.overrideMin = minY;
  y.overrideMax = maxY;
  y.title = 'Percentage of On Time Arrivals';

  // setup x axis
  var x = myChart.addTimeAxis('x', 'Year');
  x.tickFormat = '%Y';
  x.title = 'Year';

  // setup series and legend
  var s = myChart.addSeries('Carrier Name', dimple.plot.scatter);
  var p = myChart.addSeries('Carrier Name', dimple.plot.line);
  var legend = myChart.addLegend(width*0.65, 60, width*0.25, 60, 'right');

  // draw the chart
  myChart.draw(1000);


}

d3.csv("data/summarized_data.csv", type, draw);
