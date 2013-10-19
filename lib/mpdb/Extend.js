    	OpenLayers.Feature.prototype.addMetaData = function (data) {
    	    this.metaData = data; //fix
    	};
    	OpenLayers.Layer.Vector.prototype.addMetaData = function (data) {
    	    this.metaData = data; //fix
    	};

    	OpenLayers.Renderer.SVG.prototype.MAX_PIXEL = Number.MAX_VALUE;

    	OpenLayers.Feature.prototype.currentBounds = function () {
    	    var v = this.geometry.getBounds();
    	    var sf = this.scale;
    	    var h = (this.attributes.graphicHeight / this.attributes.graphicWidth) * sf;

    	    var b = ImageMap.MakeBounds(v.left, v.bottom, v.left + sf, v.bottom + h);
    	    return b;
    	    /* 	    	return ImageMap.MakeBounds( v.left, v.bottom  ,  v.left + this.attributes.graphicWidth*sf, v.top - this.attributes.graphicHeight*sf  ); */
    	};

    	function createUUID() {
    	    // http://www.ietf.org/rfc/rfc4122.txt
    	    var s = [];
    	    var hexDigits = "0123456789abcdef";
    	    for (var i = 0; i < 36; i++) {
    	        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    	    }
    	    s[14] = "4"; // bits 12-15 of the time_hi_and_version field to 0010
    	    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
    	    s[8] = s[13] = s[18] = s[23] = "-";

    	    var uuid = s.join("");
    	    return uuid;
    	}

    	var g = OpenLayers.Layer.Vector.prototype.setOpacity;

    	OpenLayers.Layer.Vector.prototype.changeOpacity = function (op) {
    	    if (ImageMap.map.busy) {
    	        ImageMap.map.queue.push({
    	            self: this,
    	            fn: this.setOpacity,
    	            args: [op]
    	        });
    	        return;
    	    }
    	    ImageMap.map.layerSwitcher.changeLayerOpacity(op);
    	}

    	OpenLayers.Util.extend(OpenLayers.Layer.prototype, {
    	    dataPoints: Array(),
    	    addDataPoint: function (point) {
    	        this.dataPoints.push(point);
    	        ImageMap.map.addFeatureToLayer(point, this)
    	    },
    	    locked: false,
    	    lockLayer: function () {
    	        ImageMap.map.toggleLockLayer(this);
    	    },
    	    setIndex: function (zi) {
    	        ImageMap.map.map.setLayerIndex(this, zi);
    	    },
    	    changeZIndex: function (d) {
    	        ImageMap.map.map.setLayerIndex(this, ImageMap.map.map.getLayerIndex(this) + d);
    	    },
    	    changeScale: function (sca) {
    	        if (!sca || sca == 0) return;
    	        for (var f in this.features) {
    	            var fe = this.features[f];
    	            if (!fe.attributes.graphicHeight) continue;

    	            var scalingFactor = sca / fe.attributes.graphicWidth;
    	            fe.attributes.graphicWidth *= scalingFactor;
    	            fe.attributes.graphicHeight *= scalingFactor;

    	            continue;

    	        }
    	        this.redraw({
    	            force: true
    	        });

    	    }

    	});

    	OpenLayers.Util.extend(OpenLayers.Feature.Vector.prototype, {

    	    displayPopup: function (temp, lonlat) {
    	        if (!lonlat) lonlat = new OpenLayers.LonLat(this.geometry.getBounds().left, this.geometry.getBounds().top);
    	        if (!temp) temp = ImageMap.Templates.Feature.Popup(this, lonlat)

    	        if (this.popup) {
    	            this.popup.destroy();
    	            this.popup = null;
    	        }
    	        /*var currentSize = ImageMap.map.map.getSize();
			var perc = 200/currentSize.w * 1.2;
			var widthOfBox = perc * ImageMap.map.map.calculateBounds().getWidth();
			if (widthOfBox + lonlat.lon > (ImageMap.map.map.calculateBounds().right)){
				lonlat.lon = ImageMap.map.map.calculateBounds().right - widthOfBox;
			}	    
			perc = 300/currentSize.h * 1.1;
			var heightOfBox = perc * ImageMap.map.map.calculateBounds().getHeight();
			if (lonlat.lat - heightOfBox < (ImageMap.map.map.calculateBounds().bottom)){
				lonlat.lat = ImageMap.map.map.calculateBounds().bottom + heightOfBox;
			}	    
*/
    	        this.popup = new OpenLayers.Popup(this.id + "pop",
    	            null,
    	            new OpenLayers.Size(0,0),
    	            temp,
    	            true,
    	            null);
    	        this.popup.keepInMap = true;
    	        this.popup.closeOnMove = true;
    	        this.popup.panMapIfOutOfView = true;
    	        ImageMap.map.map.addPopup(this.popup);
    	        this.popup.show();
    	        $('#datapopupform_div').lightbox_me();
    	    },

    	    updateFromPopup: function () {
  //  	    console.log(this.popup);
    	      //  var fo = this.popup.contentHTML.childNodes[0];
				var fo = $('#datapopupform')[0];
				console.log(fo);

    	        var hs = fo.fscale.value / this.attributes.graphicWidth;
    	        var old = this.attributes.graphicWidth.toFixed(2);
    	        this.attributes.graphicWidth = parseInt(fo.fscale.value);
    	        this.attributes.graphicHeight *= hs;
    	        if (fo.fopacity)
    	            this.attributes.opacity = fo.fopacity.value;
    	        this.attributes.graphicZIndex = fo.fzindex.value;
    	        this.id = fo.fname.value;

    	        var elems = document.forms["datapopupform"].getElementsByTagName("input");
    	        console.log(elems);

    	        for (var key in elems) {
    	            var name = elems[key].name;
    	            if (!name || name[0] != 'd' || name[1] != 'p') continue;
    	            this.data[name.substring(3)] = elems[key].value;
    	            console.log(elems[key].value);
    	        }

    	        if (!ImageMap.map.setScale && old != parseFloat(fo.fscale.value).toFixed(2)) {
    	            ImageMap.map.setScale = true;
    	            ImageMap.map.map.zoomToExtent(new OpenLayers.Bounds(this.geometry.x - this.attributes.graphicWidth * 1.5, this.geometry.y + this.attributes
    	                .graphicHeight * 1.5, this.geometry.x + this.attributes.graphicWidth * 1.5, this.geometry.y - this.attributes.graphicHeight * 1.5));

    	        }
    	        for (var f in this.points) {
    	            var pointt = this.points[f];
    	            pointt.attributes.graphicWidth *= this.attributes.graphicWidth / old;
    	            pointt.attributes.graphicHeight *= this.attributes.graphicWidth / old;
    	            pointt.geometry.calculateBounds();
    	            pointt.move(new OpenLayers.LonLat(this.geometry.x + pointt.xp * this.attributes.graphicWidth, this.geometry.y - pointt.yp * this.attributes
    	                .graphicHeight));

    	        }

    	        if (fo.fdata) this.data = fo.fdata.value;
    	        $('#datapopupform_div').trigger('close');
    	        $('#datapopupform_div').empty();
    	        ImageMap.map.map.removePopup(this.popup);
    	        


    	        //if (this.popup)
	    	      //  this.popup.destroy();
    	        this.layer.redraw({
    	            force: true
    	        });
    	        ImageMap.map.layerSwitcher.redraw(true);
				//this.popup.destroy();
    	    },

    	    isVisible: function () {
    	        if (!this.style) return this.attributes.visible;
    	        return (this.style.visibility != "hidden");
    	    },

    	    loadData: function (url) {
    	        this.db_data = new Array();
    	        var that = this;
    	        $.getJSON(url, function (data) {

    	            var d = data[that.mp_id];
    	            that.db_data = d;
    	            if (!ImageMap.Data.bank)
    	                ImageMap.Data.bank = data["*"];
    	            else {
    	                for (var i in data["*"]) {
    	                    var passed = true;
    	                    for (var j in ImageMap.map.data_bank) {
    	                        if (ImageMap.Data.bank[j].pointnumber == data['*'][i].pointnumber) {
    	                            passed = false;
    	                            break;
    	                        }
    	                    }
    	                    if (passed)
    	                        ImageMap.Data.bank.push(data["*"][i]);
    	                }
    	            }

    	            //ImageMap.map.layerSwitcher.redraw(true);

    	        });

    	    },

    	    addDataPoint: function (point) {
    	        if (!this.points) this.points = new Array();
    	        this.points.push(point);
    	    },

    	    addDataPopup: function (lonlat) {
    	        if (!lonlat) lonlat = new OpenLayers.LonLat(this.geometry.getBounds().left, this.geometry.getBounds().top);
    	        this.displayPopup(ImageMap.Templates.Feature.DataPopup(this, lonlat));
    	    },

    	    addMovePopup: function () {
    	        this.displayPopup(ImageMap.Templates.Feature.MovePopup(this));
    	    },

    	    changeScale: function (scale) {
    	        var fe = this;;
    	        var scalingFactor = scale / this.attributes.graphicWidth;
    	        fe.attributes.graphicWidth *= scalingFactor;
    	        fe.attributes.graphicHeight *= scalingFactor;
/*
    	        var c = fe.geometry.bounds.clone();
    	        fe.geometry.move(0, 0);
    	        fe.geometry.move(c.left * scalingFactor - c.left, c.top * scalingFactor - c.top);
*/
    	        fe.geometry.calculateBounds();
    	        /*
			 	fe.geometry = new OpenLayers.Geometry.Point((fe.geometry.bounds.left || fe.geometry.x) * (scalingFactor),
									 						(fe.geometry.bounds.top || fe.geometry.y) * (scalingFactor));

*/

    	    },

    	    dataToCSV: function (includeSelf) {
    	        var csv = "";
    	        var set = {}
    	        for (var p in this.points) {
    	            for (var a in this.points[p].data) {
    	                set[a] = true;
    	            }
    	        }
    	        includeSelf = true;
    	        if (includeSelf) {
    	            csv += "Reference Image,";
    	        }
    	        csv += "X reference, Y reference, ";

    	        for (var a in set) {
    	            csv += a + ",";
    	        }
    	        csv += "\n";
    	        for (var p in this.points) {
    	            var i = 0;
    	            csv += this.id + ",";
    	            var x = this.points[p].geometry.x - this.geometry.bounds.left;
    	            console.log(x)
    	            var y = this.geometry.bounds.top - this.points[p].geometry.y;
    	            x *= 100 / this.attributes.graphicWidth;
    	            y *= 100 / this.attributes.graphicHeight;
    	            x = x.toFixed(2);
    	            y = y.toFixed(2);
    	            csv += x + "%," + y + "%,";

    	            for (var a in set) {
    	                if (this.points[p].data[a]) {
    	                    csv += this.points[p].data[a] + ",";
    	                } else {
    	                    csv += ",";
    	                }
    	            }
    	            csv = csv.slice(0, -1);
    	            csv += "\n";
    	        }
    	        return csv;

    	    }
    	});

    	OpenLayers.Feature.prototype.addLayer = function (layer) {
    	    if (this.attributes.sublayers == undefined) {
    	        this.attributes.sublayers = new Array();
    	    }
    	    this.attributes.sublayers.push(layer.name);
    	    layer.visibility = false;
    	}

    	f = OpenLayers.Control.LayerSwitcher.prototype.onRemoveClick
    	 OpenLayers.Control.LayerSwitcher.prototype.onRemoveClick = function (e) {
    	    f.apply(this, e)
    	    if (this.layer) {
    	        // this.layer.removeAllFeatures();
    	        this.layer.refresh({
    	            force: true
    	        });;
    	    }
    	}

    	OpenLayers.Feature.Vector.prototype.getVisibility = function (e) {
    	    return true;
    	}

    	String.prototype.trunc =
    	    function (n) {
    	        return this.substr(0, n - 1) + (this.length > n ? '...' : '');
    	};

    	OpenLayers.Control.Click = OpenLayers.Class(OpenLayers.Control, {
    	    defaultHandlerOptions: {
    	        'single': true,
    	        'double': false,
    	        'pixelTolerance': 0,
    	        'stopSingle': false,
    	        'stopDouble': false
    	    },

    	    initialize: function (options) {
    	        this.handlerOptions = OpenLayers.Util.extend({}, this.defaultHandlerOptions);
    	        OpenLayers.Control.prototype.initialize.apply(
    	            this, arguments
    	        );
    	        this.handler = new OpenLayers.Handler.Click(
    	            this, {
    	                'click': this.trigger
    	            }, this.handlerOptions
    	        );
    	    },

    	    trigger: function (e) {

    	        console.log('click' + ImageMap.map.selectControl.clickedYet);
    	        if (ImageMap.map) {
    	            if (ImageMap.map.mode == "transform") {
    	                if (!ImageMap.map.selectControl.clickedYet) {
    	                    ImageMap.map.selectControl.unselectAll();
    	                    ImageMap.map.selectControl.clickedYet = true;
    	                } else {
    	                    ImageMap.map.selectControl.unselectAll();
    	                    ImageMap.map.selectControl.clickedYet = undefined;
    	                }

    	            }
    	        }

    	    }

    	});

    	String.prototype.hashCode = function () {
    	    var hash = 0,
    	        i, char;
    	    if (this.length == 0) return hash;
    	    for (i = 0, l = this.length; i < l; i++) {
    	        char = this.charCodeAt(i);
    	        hash = ((hash << 5) - hash) + char;
    	        hash |= 0; // Convert to 32bit integer
    	    }
    	    return hash;
    	};