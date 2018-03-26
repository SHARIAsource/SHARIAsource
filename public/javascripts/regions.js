var map = L.map("map").setView([0,0],2);
var Esri_WorldTopoMap = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
  attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ, TomTom, Intermap, iPC, USGS, FAO, NPS, NRCAN, GeoBase, Kadaster NL, Ordnance Survey, Esri Japan, METI, Esri China (Hong Kong), and the GIS User Community'
});

Esri_WorldTopoMap.addTo(map);
var regions = [];
var counts = [];
var scaleMax = 100;
var scaleMin = 3;
function scaleRangeValue(value,min,max) {
  scaledValue = ((scaleMax-scaleMin)*(value-min))/(max-min)+scaleMin;
  return scaledValue;
}
function illustrateMap(regions) {
  var countMax = counts.reduce(function(a,b){return Math.max(a,b);},1);
  var countMin = counts.reduce(function(a,b){return Math.min(a,b);},1)
  for (var i = 0; i < regions.length; i++) {
    var rgn = regions[i]
    var circle = L.circleMarker([rgn['lat'],rgn['lon']], {
      color: '#b30024',
      fillColor: '#b30024',
      fillOpacity: 0.3,
      radius: scaleRangeValue(rgn['count'],countMin,countMax),
      weight: 2
    });
    circle.bindPopup(rgn['nameLink']+': '+rgn['count']+" documents");
    circle.addTo(map);
  }
}

function addToRegions(regions,name,lat,long,count,searchLink) {
  if (count > 0) {
    regions.push({
      'lat':lat,
      'lon':long,
      'name':name,
      'count':count,
      'nameLink':searchLink,
    });
  }
}
