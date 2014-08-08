//Define coordinate system using PROJ4 standards
var osgb = new L.Proj.CRS('EPSG:27700',
  '+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000' +
  '+ellps=airy +datum=OSGB36 +units=m +no_defs',
  {
    resolutions: [2500, 1000, 500, 200, 100, 50, 25, 10, 5, 2.5, 1],
    bounds: L.bounds([1300000,0],[700000,0])
  }
);

//Leaflet map with OS options
var map = new L.Map('map', {
  crs: osgb,
  continuousWorld: true,
  worldCopyJump: false,
  minZoom: 1,
  maxZoom: 10,

  // controls
  dragging: false,
  touchZoom: false,
  doubleClickZoom: false,
  scrollWheelZoom: false,
  boxZoom: false,
  keyboard: false,
  tap: false,
  zoomControl: false,
  attributionControl: false
});

//New OSOpenSpace layer with API Key
var openspaceLayer = L.tileLayer.osopenspace("FFB702322FE0714DE0430B6CA40A06C6", {debug: true});
map.addLayer(openspaceLayer);

//Define name of CRS in GeoJSON using PROJ4
proj4.defs("urn:ogc:def:crs:EPSG:27700","+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000 +ellps=airy +datum=OSGB36 +units=m +no_defs");

//Add the GeoJSON to the map
var geoJson = L.Proj.geoJson(extentData, {
  color: 'red',
  fillColor: '#f03',
  fillOpacity: 0.5
})
geoJson.addTo(map);

//Add a scale control to the map
L.control.scale().addTo(map);

//Center map view on geojson polygon
var bounds = geoJson.getBounds();
var center = bounds.getCenter();
map.setView([center.lat, center.lng], 9)
map.fitBounds(bounds, {maxZoom: 9, animate: false});

