function addFeaturesFromFiles(files, lonlat, layer, scale) {
    if (layer.name) layer = layer.name;
    layer = ImageMap.map.makeLayer((layer || "New Layer"), null, null, null, true, true);
    for (var i = 0; i < files.length; i++) {

        var immLoad = function (opt) {
            if (opt) that = opt;
            else that = this;
            var s = (scale || ImageMap.map.scale * ImageMap.map.map.getResolution() / 7);
            var whs = that.height / that.width * s;

            var feature3 = ImageMap.MakeFeature((that.name || that.id || that.value),
                that.src,
                lonlat.lon,
                lonlat.lat,
                s,
                whs);
            feature3.mp_id = that.checksum || that.id;
            ImageMap.map.addFeatureToLayer(feature3, layer);
            ImageMap.map.layerSwitcher.redraw(true);

        }
        console.log(files[i])
        if (!files[i].name) {
            if (files[i].src) {
                immLoad(files[i]);
            } else {
                var imm = new Image();
                imm.name = (files[i].value || files[i]);
                imm.mp_id = files[i].cs;
                imm.fsrc = (files[i].getAttribute) ? files[i].getAttribute('data-full-img-src') : null;
                imm.onload = function () {
                    immLoad(this);
                    if (this.fsrc) {
                        var imm2 = new Image();
                        imm2.name = this.name;
                        imm2.src = this.fsrc;
                        imm2.onload = function () {};
                    }
                };
                var sr = (files[i].value) ? files[i].getAttribute('data-half-img-src') : files[i];
                if (files[i].value) {
                    files[i].onclick = function () {
                        return false;
                    }
                }
                imm.checksum = (files[i].getAttribute) ? files[i].getAttribute('checksum') : null;
                imm.src = sr;
                if (files[i].parentNode)
                    files[i].parentNode.removeChild(files[i]);
            }
        } else {
            /*var fs = FileAPI.getFiles(files);
			        var imageList = FileAPI.filter(fs, function (file){ return /image/.test(file.type); });
        FileAPI.each(imageList, function (imageFile){
            FileAPI.Image(imageFile)
                .preview(100, 120)
                .get(function (err, image){
                    if( err ){
                        // ...
                    }
                    else {
				var text = FileAPI.readAsDataURL(image);
				console.log(text);
				var imm = new Image(); 
				imm.name = 	(files[i].name || "New Feature");
				imm.onload = function () { immLoad(imm); } ;
				imm.src = text;

                    }
                })
            ;
        });*/
            var reader = new FileReader();
            reader.imageName = files[i].name;
            reader.onload = function (imageLoadedEvent) {
                var text = imageLoadedEvent.target.result;
                var imm = new Image();
                imm.name = (this.imageName || "New Feature");
                imm.onload = function () {
                    immLoad(imm);
                };
                imm.src = text;
            }
            reader.readAsDataURL(files[i]);

        }

    }

}

function popupLibrary(elem) {
    try {
        $(library).lightbox_me({
            onClose: function () {
                elem.value = '(Pick From Library' + document.getElementById('library_s').selectedOptions.length + ')';
            }
        });
    } catch (e) {}

}

data_popup_func = function (e, xy) {
    var opx;
    if (e) opx = map.map.getLonLatFromViewPortPx(e.xy).clone();
    else opx = xy

}

function sortByKey(array, key) {
    return array.sort(function (a, b) {
        var x = a[key];
        var y = b[key];
        return ((x < y) ? -1 : ((x > y) ? 1 : 0));
    });
}

var csv_sort = function (key) {
    return function (a, b) {
        return (a[key] > b[key]) ? 1 : ((b[key] > a[key]) ? -1 : 0);
    }
}

var fixHelper = function (e, ui) {
    ui.children().each(function () {
        $(this).width($(this).width());
    });
    return ui;
};

function exchange_rows(oRowI, oRowJ, oTable) {
    if (oRowI.rowIndex == oRowJ.rowIndex + 1) {
        oTable.insertBefore(oRowI, oRowJ);
    } else if (oRowJ.rowIndex == oRowI.rowIndex + 1) {
        oTable.insertBefore(oRowJ, oRowI);
    } else {
        var tmpNode = oTable.replaceChild(oRowI, oRowJ);
        if (typeof (oRowI) != "undefined") {
            oTable.insertBefore(tmpNode, oRowI);
        } else {
            oTable.appendChild(tmpNode);
        }
    }
}

popup_func = function (e, xy) {
    var opx;
    if (e) opx = map.map.getLonLatFromViewPortPx(e.xy).clone();
    else opx = xy

        var popup_content =
            "<div id='addimageform_div'>\
<h4 style='margin-bottom:5px;margin-top:5px;'>Add Image <a href='javascript:closePopup(null);$(\"#addimageform_div\").trigger(\"close\")'>x</a></h4>\
           <form id='addimageform' name='addimageform' onsubmit=' return false;''>\
           		<input type='file' style=' ;' id='iimage' name='iimage' multiple /><br />\
           		<input type='button'  style='display:none;'  id='ilibrary' value='Pick From Library ' onclick='popupLibrary(this);' style='margin-bottom:7px;margin-top:3px;'  /><br />\
           		<input type='url' style='width:175px;' placeholder='Optionally enter the URL of the Base Image' name='featureurl' /><br />\
           		<input type='text' name='iscale' style='width:175px'  id='iscale' placeholder='Scale (width in mm)' /><br />\
           		<input type='text' name='iname' style='width:175px' id='iname' placeholder='Optional Name' /><br />\
           		<select name='ilayer' id='ilayer'  style='width:190px' onchange='name_for_new_layer(this);'><br />\
           			<option value='New Layer'>Add Feature to Layer:</option><br />";

    for (var l in map.layers) {
        if (map.layers[l].name == "Vector Layer" || map.layers[l].name == "Resizable layer") continue;
        popup_content += "<option value='" + map.layers[l].name + "'>" + map.layers[l].name + "</option>\n";
    }

    popup_content += "<option value='New Layer' >New Layer</option>\
    			</select>\
           		<input type='hidden' id='x' name='x' value='" + opx.lon +
        "' /> \
           		<input type='hidden' id='y' name='y' value='" + opx.lat +
        "' />\
           <input type='button' onclick=' closePopup(this); return false;' value='Add Image' />\
           </form></div>";

    var currentSize = ImageMap.map.map.getSize();
    var perc = 200 / currentSize.w * 1.2;
    var widthOfBox = perc * ImageMap.map.map.calculateBounds().getWidth();
    if (widthOfBox + (opx.lon || opx.x) > (ImageMap.map.map.calculateBounds().right)) {
        opx.lon = ImageMap.map.map.calculateBounds().right - widthOfBox;
    }
    perc = 300 / currentSize.h * 1.1;
    var heightOfBox = perc * ImageMap.map.map.calculateBounds().getHeight();
    if ((opx.lat || opx.y) - heightOfBox < (ImageMap.map.map.calculateBounds().bottom)) {
        opx.lat = ImageMap.map.map.calculateBounds().bottom + heightOfBox;
    }

    popup = new OpenLayers.Popup("Insert Image",
        opx,
        new OpenLayers.Size(0,0),
        popup_content,
        true);
    popup.keepInMap = true;
    popup.closeOnMove = true;
    map.map.addPopup(popup);

/*
    map.map.addPopup(popup);
    map.map.events.register("click", popup, function (evt) {
        map.map.removePopup(popup);
    });
    */
	
    map.map.events.unregister("click", map.map, popup_function)
	
    add_button.deactivate();
}

draw_func = function (f) {

    var geo = f.feature.geometry.getBounds().clone();
    //if (popup) map.map.removePopup(popup);
    var popup_content =
        "<h4 style='margin-bottom:5px;margin-top:5px;'>Add Image by Draw</h4>\
                   <form id='addimageform' name='addimageform' onsubmit=' return false;''>\
                   		<input type='file' id='iimage' name='iimage' /><br />\
                   		<select name='ilayer' id='ilayer' onchange='name_for_new_layer(this);'>\
                   			<option value='New Layer'>Add Feature to Layer:</option>";
    for (var l in map.layers) {
        popup_content += "<option value='" + map.layers[l].name + "'>" + map.layers[l].name + "</option>\n";
    }
    popup_content +=
        "<option value='New Layer' >New Layer</option>\
            			</select>\
                   		<input type='hidden' id='fea' name='fea' value='" + JSON
        .stringify(geo) +
        "' /> \
                   <input type='button' onclick='addFeatureWithBounds(this); return false;' value='Add Image' />\
                   </form>";

    var currentSize = ImageMap.map.map.getSize();
    var perc = 200 / currentSize.w * 1.2;
    var widthOfBox = perc * ImageMap.map.map.calculateBounds().getWidth();
    if (widthOfBox + (opx.lon || opx.x) > (ImageMap.map.map.calculateBounds().right)) {
        geo.left = ImageMap.map.map.calculateBounds().right - widthOfBox;
    }
    perc = 300 / currentSize.h * 1.1;
    var heightOfBox = perc * ImageMap.map.map.calculateBounds().getHeight();
    if ((opx.lat || opx.y) - heightOfBox < (ImageMap.map.map.calculateBounds().bottom)) {
        geo.top = ImageMap.map.map.calculateBounds().bottom + heightOfBox;
    }

    popup = new OpenLayers.Popup("Insert Image", {
            'lon': geo.left,
            'lat': geo.top
        },
        new OpenLayers.Size(200, 200),
        popup_content,
        true);

    popup.keepInMap = true;
    popup.closeOnMove = true;

    ImageMap.map.map.addPopup(popup);

}

vectorCounter = 1;
featureCounter = 1;
var QueryString = function () {
    // This function is anonymous, is executed immediately and 
    // the return value is assigned to QueryString!
    var query_string = {};
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        // If first entry with this name
        if (typeof query_string[pair[0]] === "undefined") {
            query_string[pair[0]] = pair[1];
            // If second entry with this name
        } else if (typeof query_string[pair[0]] === "string") {
            var arr = [query_string[pair[0]], pair[1]];
            query_string[pair[0]] = arr;
            // If third or later entry with this name
        } else {
            query_string[pair[0]].push(pair[1]);
        }
    }
    return query_string;
}();

function doDrag(feature, pixel) {
    /*
	for (f in map.selectedFeatures) {
	    if (feature != map.selectedFeatures[f]) {
	        var res = map.map.getResolution();
	        feature.geometry.move(res * (pixel.x - map.lastPixel.x), res * (map.lastPixel.y - pixel.y));
	        feature.layer.drawFeature(map.selectedFeatures[f]);
	        feature.layer.redraw();
	        feature.y =  res * (map.lastPixel.y - pixel.y);
	        feature.x = res * (pixel.x - map.lastPixel.x);
	        
	        break;
	    }
	}
*/
    alert("Duh?")
    map.lastPixel = pixel;

}

function closePopup(form) {
    if (!form) {
        map.map.removePopup(popup);
        return
    }

    form = form.parentNode;
    var x = parseInt(form.x.value);
    var y = parseInt(form.y.value)
    
    var latlon = map.map.getExtent();
    x = latlon.left + (latlon.left * 0.2) ;
    y = latlon.top - (latlon.top * 0.2);
    
    var iscale = parseInt(form.iscale.value)
    if (!isNumber(iscale)) {

        iscale = map.map.calculateBounds().getWidth() / 3;

    } else {

    }

    var lay;
    var name = form.ilayer.value;
    if (name == "New Layer" || !name) name = form.iname.value;
    var lib
    if ($('library_s').data())
        lib = $('library_s').data().picker.selected_values();
    else lib = null;

    if (lib && lib.length) {
        var opts = new Array();
        for (var i in lib) {
            opts.push(document.getElementById(lib[i]));
        }
        addFeaturesFromFiles(opts, new OpenLayers.LonLat(x, y), name, iscale);
    } else if (form.featureurl.value != "") {
        var url = form.featureurl.value;
        addFeaturesFromFiles([url], new OpenLayers.LonLat(x, y), name, iscale);
    } else {
        addFeaturesFromFiles(form.iimage.files, new OpenLayers.LonLat(x, y), name, iscale);
/*
        if (!ImageMap.map.setScale && iscale) {
            ImageMap.map.setScale = true;
            ImageMap.map.map.zoomToExtent(new OpenLayers.Bounds(x - iscale * 1.5, y + iscale * 1.5, x + iscale * 1.5, y - iscale * 1.5));
*/

      //  }

    }
	$("#addimageform_div").trigger("close");

    map.map.removePopup(popup);


}

function addFeatureWithBounds(form) {
    form = form.parentNode;
    var iurl = form.iimage.value.replace('C:\\\\fakepath\\\\', "").replace('C:\\fakepath\\', "").replace("C:/fakepath/", "").replace("C://fakepath//", "");
    iurl = "img/" + iurl.split("\\").slice(-1)[0];
    if (iurl == "") {
        iurl = "img/" + form.iimage.value.split("/").slice(-1)[0];
    }
    if (iurl == "") {
        iurl = "img/" + form.iimage.value;
    }

    //iurl = iurl.split("\\").slice(-1)[0];

    var bounds = JSON.parse(form.fea.value);
    var ilayer = form.ilayer.value;
    var lay;
    var fea = ImageMap.MakeFeature2(iurl.replace("img/"), iurl, bounds);
    if (!(lay = map.hasLayerNamed(ilayer))) {
        lay = map.makeLayer(ilayer);
        map.addLayer(lay);
    }
    map.addFeatureToLayer(fea, lay);

    map.map.removePopup(popup);

}

function toggleControl(element) {
    if (element.value == "transform") {
        /*
         */
        map.mode = "transform";
        return;

    } else {
        map.removeTransformBoxFromFeature();
    }
    for (key in drawControls) {
        var control = drawControls[key];
        if (element.value == key && element.checked) {
            control.activate();
        } else {
            control.deactivate();
        }
    }
}

function update() {
    var clickout = document.getElementById("clickout").checked;
    if (clickout != drawControls.select.clickout) {
        drawControls.select.clickout = clickout;
    }

    var box = document.getElementById("box").checked;
    if (box != drawControls.select.box) {
        drawControls.select.box = box;
        if (drawControls.select.active) {
            drawControls.select.deactivate();
            drawControls.select.activate();
        }
    }

}

function updateToolTipFun(e) {
    var ll = ImageMap.map.map.getLonLatFromPixel(e.xy);
    var cand = new Array();
    for (var l in ImageMap.map.layers) {
        var fs = ImageMap.map.layers[l].features;
        for (var f in fs) {
            if (fs[f].type != "Feature") continue;

            if (fs[f].geometry.bounds.left < ll.lon &&
                fs[f].geometry.bounds.left + fs[f].attributes.graphicWidth > ll.lon &&
                fs[f].geometry.bounds.top > ll.lat &&
                fs[f].geometry.bounds.top - fs[f].attributes.graphicHeight < ll.lat) {
                cand.push(fs[f]);

            }
        }
    }
}

function uploadDone() { //Function will be called when iframe is loaded
    var ret = frames['upload_target'].document.getElementsByTagName("body")[0].innerHTML;
    delete map;
    document.getElementById("map").innerHTML = "";
    document.getElementById("layerswitcher").innerHTML = "";
    document.getElementById("scaleline-id").innerHTML = "";

    map = null;
    map = ImageMap.load(ret);

}
//save

function toJSON(imageLayer, type, s_inline) {
    if (type == undefined || !type) {
        type = imageLayer.type || "Feature";
    }

    var obj = new Object();
    obj.type = type;
    obj.metaData = imageLayer.metaData;
    obj.data = imageLayer.data;
    obj.mb_id = imageLayer.mb_id;
    if (imageLayer.locked)
        obj.locked = imageLayer.locked;

    if (!imageLayer.getVisibility())
        obj.visibility = imageLayer.getVisibility();

    obj.name = imageLayer.name;
    if (obj.name == "") obj.name = createUUID();

    if (type == "Feature" || type == "Data Point") {
        if (!imageLayer.geometry) {

            imageLayer.geometry.calculateBounds();
            imageLayer.geometry.calculateBounds();

        }

        obj.x = imageLayer.geometry.getBounds().left;
        obj.y = imageLayer.geometry.getBounds().bottom;

        obj.opacity = imageLayer.attributes.opacity;
        obj.graphicXOffset = imageLayer.attributes.graphicXOffset;
        obj.graphicYOffset = imageLayer.attributes.graphicYOffset;
        obj.graphicWidth = imageLayer.attributes.graphicWidth;
        obj.rotation = imageLayer.attributes.rotation;
        obj.graphicHeight = imageLayer.attributes.graphicHeight;
        obj.graphicZIndex = imageLayer.attributes.graphicZIndex;
        obj.externalGraphic = imageLayer.attributes.externalGraphic;
        obj.mp_id = imageLayer.mp_id;
        obj.shape = imageLayer.shape;
        obj.locked = imageLayer.locked;
        obj.size = imageLayer.size;
        obj.points = new Array();
        //  obj.renderIntent = imageLayer.renderIntent;
        if (type == "Data Point") {
            obj.parentFeature = imageLayer.parentFeature;
            obj.xp = imageLayer.xp;
            obj.yp = imageLayer.yp;
        } else {
            for (var po in imageLayer.points) {
                obj.points.push(toJSON(imageLayer.points[po], "Data Point", s_inline));
            }

        }

    } else if (obj.name == "Vector Layer") {
        obj.features = new Array();
        for (var fe in imageLayer.features) {
            obj.features.push(toJSON(imageLayer.features[fe], "Feature", s_inline));
        }
    } else {
        obj.zIndex = ImageMap.map.map.getLayerIndex(imageLayer)

        if (imageLayer.isBaseLayer) {
            obj.url = (s_inline) ? imageLayer.durl : "img/" + ((imageLayer.furl.name) ? imageLayer.furl.name : imageLayer.furl);
            obj.numZoomLevels = imageLayer.numZoomLevels;
            obj.scale = imageLayer.scale;

            obj.width = imageLayer.getExtent().getWidth();
            obj.height = imageLayer.getExtent().getHeight();
        }
        console.log(imageLayer.opacity + "op");
        obj.opacity = imageLayer.opacity;

        obj.features = new Array();
        /* 		        obj.style = imageLayer.style; */
        for (var fe in imageLayer.features) {
            if (imageLayer.features[fe].type != "Data Point")
                obj.features.push(toJSON(imageLayer.features[fe], undefined, s_inline));
        }

    }
    obj.id = imageLayer.id;
    if (imageLayer.metadata == {})
        obj.metadata = imageLayer.metadata;

    return obj;
}

function errorHandler(e) {
    var msg = '';

    switch (e.code) {
    case FileError.QUOTA_EXCEEDED_ERR:
        msg = 'QUOTA_EXCEEDED_ERR';
        break;
    case FileError.NOT_FOUND_ERR:
        msg = 'NOT_FOUND_ERR';
        break;
    case FileError.SECURITY_ERR:
        msg = 'SECURITY_ERR';
        break;
    case FileError.INVALID_MODIFICATION_ERR:
        msg = 'INVALID_MODIFICATION_ERR';
        break;
    case FileError.INVALID_STATE_ERR:
        msg = 'INVALID_STATE_ERR';
        break;
    default:
        msg = 'Unknown Error';
        break;
    };

    console.log('Error: ' + msg);
}

function name_for_new_layer(selec) {
    if (selec.options[selec.selectedIndex].value == "New Layer") {
        var name = (selec.form && selec.form.iname) ? selec.form.iname.value : "";
        var a = prompt("Enter name of new Layer", name);
        if (!a || a == "") return;
        selec.options[selec.selectedIndex].value = a;
        selec.options[selec.selectedIndex].innerHTML = a;
    }

}
var userAgent = navigator.userAgent.toLowerCase();

var UserBrowser = {
    userAgent: navigator.userAgent.toLowerCase(),
    version: (userAgent.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/) || [])[1],
    safari: /webkit/.test(userAgent) && !/chrome/.test(userAgent),
    opera: /opera/.test(userAgent),
    msie: /msie/.test(userAgent) && !/opera/.test(userAgent),
    mozilla: /mozilla/.test(userAgent) && !/(compatible|webkit)/.test(userAgent),
    chrome: /chrome/.test(userAgent)
}

    function isNumber(n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    }

    function merge_options(obj1, obj2) {
        var obj3 = {};
        for (var attrname in obj1) {
            obj3[attrname] = obj1[attrname];
        }
        for (var attrname in obj2) {
            obj3[attrname] = obj2[attrname];
        }
        return obj3;
    }

    function updateModifyControl(mc) {

    }

    function readSelected(sb, fid, bank) {
        var feat = ImageMap.map.getFeature(fid);
        var data;
        if (sb == -1) sb = 0;

        if (bank) {
            data = ImageMap.Data.bank[sb];
            ImageMap.Data.bank.splice(sb, 1);
            /*
		console.log(data);
		var s = document.getElementById('points');
		for (var r = 0; r < s.rows.length; r++){
			var match = true;
			for (var d in data){
				console.log(data[d] + " " + s.rows[r].children[d].innerHTML);
				if (data[d] && data[d] != s.rows[r].children[d].innerHTML){
					match = false;
					break;
				}
			}
			if (match){
				s.removeChild(s.rows[r]);
				break;
			}
		}
*/
        } else {
            data = feat.db_data[sb];
            feat.db_data.splice(sb, 1);
        }

        return data;
    }

    function clone(obj) {
        if (obj == null || typeof (obj) != 'object')
            return obj;

        var temp = obj.constructor(); // changed

        for (var key in obj)
            temp[key] = clone(obj[key]);
        return temp;
    }

    function htmlEncode(value) {
        if (!value) return "";
        //create a in-memory div, set it's inner text(which jQuery automatically encodes)
        //then grab the encoded contents back out.  The div never exists on the page.
        return $('<div/>').text(value).html();
    }

    function htmlDecode(value) {
        if (!value) return "";

        return $('<div/>').html(value).text();
    }
    
    var downloadFile = function(filename, content) {
  var blob = new Blob([content]);
  var evt = document.createEvent("HTMLEvents");
  evt.initEvent("click");
  $("<a>", {
    download: filename,
    href: webkitURL.createObjectURL(blob)
  }).get(0).dispatchEvent(evt);
};
