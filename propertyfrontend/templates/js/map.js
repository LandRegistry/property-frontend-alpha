var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
	osmAttrib = '&copy; <a href="http://openstreetmap.org/copyright">OpenStreetMap</a> contributors',
	osm = L.tileLayer(osmUrl, {maxZoom: 18, attribution: osmAttrib});

var map = L.map('map').setView([51.505, -0.159], 15).addLayer(osm);

L.marker([51.504, -0.159])
	.addTo(map)
	.bindPopup('A pretty CSS3 popup.<br />Easily customizable.')
	.openPopup();
