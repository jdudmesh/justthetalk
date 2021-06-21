$.fn.worldViewMap = function(socket, options) {
	if(this.length == 0) { return; }

	this.each(function() {
		new WorldView.Map($(this), socket, options);
	});

	return this;
  
};


if(!WorldView) { var WorldView = {}; }

WorldView.Map = function(element, socket, options) {
	this.element = element;
	this.socket = socket;
	this.po = org.polymaps;
	this.defaultZoom = $(window).height() > 760 ? 3 : 2;

	var zoomFactor = Math.round(Math.log(window.devicePixelRatio || 1) / Math.LN2);
	if(zoomFactor > 0) {
		var doubleSize = "-2x";
	} 
	else {
		var doubleSize = "";
	}
	
	this.map = this.po.map()
		.container(this.element.get(0).appendChild(this.po.svg("svg")))
		.center({lat: 31, lon: 10})
		.zoom(this.defaultZoom)
		.zoomRange([1, 7 - zoomFactor])
		.add(this.po.interact());

	this.map.add(this.po.image()
		    .url(this.po.url("http://{S}tile.cloudmade.com"
		    + "/1a1b06b230af4efdbb989ea99e9841af" // http://cloudmade.com/register
		    + "/20760/256/{Z}/{X}/{Y}.png")
		    .hosts(["a.", "b.", "c.", ""])));
	this.map.add(this.po.compass().pan("none"));

	this.map.size({x: 640, y: 480});
  
  
}