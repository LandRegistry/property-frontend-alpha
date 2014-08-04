var osgb = new L.Proj.CRS('EPSG:27700',
  '+proj=tmerc +lat_0=49 +lon_0=-2 +k=0.9996012717 +x_0=400000 +y_0=-100000' +
  '+ellps=airy +datum=OSGB36 +units=m +no_defs',
  {
    resolutions: [2500, 1000, 500, 200, 100, 50, 25, 10, 5, 2.5],
    bounds: L.bounds([1300000,0],[700000,0])
  }
);

/* L.Map with OS options */
var map = new L.Map('map', {
  crs: osgb,
  continuousWorld: true,
  worldCopyJump: false,
  minZoom: 2,
  maxZoom: L.OSOpenSpace.RESOLUTIONS.length - 1,
});

/* New L.TileLayer.OSOpenSpace with API Key */
openspaceLayer = L.tileLayer.osopenspace("FFB702322FDF714DE0430B6CA40A06C6", {debug: true});

map.addLayer(openspaceLayer);
map.setView([51.504, -0.159], 9);

/* add some ui elems to the map */

L.control.scale().addTo(map);
