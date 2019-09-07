function type(d) {
  var format = d3.time.format("%Y");
  
  return {
    'Year': format.parse(d.year),
    'Carrier Name': d.carrier_name,
    'On Time Percentage': +d.timely_rate/100,
    'Total Arrivals for the Year' : d.arrivals
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

  var width = 1200,
      height = 500,
      margin = 20;

  
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
  var minY = 0.70,
      maxY = 0.92;
  var y = myChart.addMeasureAxis('y', 'On Time Percentage');
  y.overrideMin = minY;
  y.overrideMax = maxY;
  y.tickFormat = '%';
  y.title = 'Percentage of On Time Arrivals';

  // setup x axis
  var x = myChart.addTimeAxis('x', 'Year');
  x.tickFormat = '%Y';
  x.title = 'Year';

  // setup series and legend
  var s = myChart.addSeries('Carrier Name', dimple.plot.scatter);
  var p = myChart.addSeries('Carrier Name', dimple.plot.line);
  var legend = myChart.addLegend(0, 70, width*0.9, 70,  'right');

  // draw the chart
  myChart.draw(3000);

  svg.selectAll("circle")
        .attr("opacity", 0.6);

  // Explainations on calculations
  svg.selectAll("title_text")
          .data(["**Percentage of On Time Arrivals for a year = (Number of Flights arrived on time) / (Total flights arrived that year)"])
          .enter()
          .append("text")
          .attr("x", width*0.1)
          .attr("y", height*0.05)
          .style("font-family", "sans-serif")
          .style("font-size", "12px")
          .style("color", "Black")
          .text(function (d) { return d; });

  // Add Instructions to click on legends 
  svg.selectAll("title_text")
          .data(["Click on the legend to show/hide Airline Carriers:"])
          .enter()
          .append("text")
          .attr("x", width*0.7)
          .attr("y", height*0.1)
          .attr("id", "blink_text")
          .style("font-family", "sans-serif")
          .style("font-size", "10px")
          .style("color", "Black")
          .text(function (d) { return d; });

  // Orphan the Legend (Legend will not respond to graph updates)
  myChart.legends = [];

  // Get a list of all carriers
  var filter_values = dimple.getUniqueValues(data, "Carrier Name");

  // Adding a mousclick event to legend items

  legend.shapes.selectAll("rect")
          .attr("cursor" , "pointer")
          .on("click", function (ele) {

            // Stop blinking the instruction title
            svg.select("#blink_text")
              .attr("id", "");

            // This indicates whether the item is already visible or not
            var hide = false;
            var new_filters = [];

            // If the filters contain the clicked shape hide it
            filter_values.forEach(function (val) {
              
              if (val === ele.aggField.slice(-1)[0]) {
                
                hide = true;

              } else {

                new_filters.push(val);

              }
            });

            // Hide the shape or show it
            if (hide) {
              
              d3.select(this).style("opacity", 0.2);

            } else {
              
              new_filters.push(ele.aggField.slice(-1)[0]);
              d3.select(this).style("opacity", 0.8);

            }

            // Update the filters
            filter_values = new_filters;

            // Filter the data
            myChart.data = dimple.filterData(data, "Carrier Name", filter_values);

            //draw the chart (exit is quicker than entry)

            if (hide){

              myChart.draw(800);

            }else{

              myChart.draw(3000);

            }

            // Re-Highlight line on mouse-hover

            d3.selectAll('path')
                .style('opacity', 0.8)
                .attr("cursor", "pointer")
                .on('mouseover', function(e) {
                  d3.select(this)
                    .style('stroke-width', '6px')
                    .style('opacity', 1)
                    .attr('z-index', '1');
              }).on('mouseleave', function(e) {
                  d3.select(this)
                    .style('stroke-width', '2px')
                    .style('opacity', 0.8)
                    .attr('z-index', '0');

                });



          });

// Highlight line on mouse-hover

d3.selectAll('path')
    .style('opacity', 0.8)
    .attr("cursor", "pointer")
    .on('mouseover', function(e) {
      d3.select(this)
        .style('stroke-width', '6px')
        .style('opacity', 1)
        .attr('z-index', '1');
  }).on('mouseleave', function(e) {
      d3.select(this)
        .style('stroke-width', '2px')
        .style('opacity', 0.8)
        .attr('z-index', '0');

    });





}

d3.csv("data/summarized_data.csv", type, draw);