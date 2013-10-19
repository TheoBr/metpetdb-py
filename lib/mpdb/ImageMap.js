var popup = null;
var oStyleMap, context;
renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
renderer = (renderer) ? [renderer] : OpenLayers.Layer.Vector.prototype.renderers;

/**
 * @class: ImageMap
 * This class wraps the OpenLayers.Map class.
 * @namespace ImageMap
 */

/**
     * @constructor
     * @param {string} name Name of the Base Layer
     * @param {string} url URL of the baseLayer image
     * @param {int} [width] Width of the baseLayer
     * @param {int} [height] Height of the baseLayer
     * @param {int} [scale] instead of width and height an optional scale 
     					width can be specified instead. It is essentially 
     					the width other images will be relative to.
     * @param {Object} [Options]
     */

function ImageMap(div, name, url, scale, options) {

    /**
     * @property {Array}
     * @description layers Holds all the layers in the map
     */
    this.layers = new Array();

    /** @property {Array} 
     *  @description Holds all the features */
    this.features = new Array();

    /**
     * @description  Remove a layer
     * @param {OpenLayers.layer} layer Layer to remove
     */

    this.removeLayer = function (layer) {

        for (var f in layer.features) {
            layer.features[f].destroy();
        }

        for (var l in this.layers) {
            if (this.layers[l] == layer) {
                this.layers.splice(l, 1);
                break;
            }
        }

        this.map.removeLayer(layer, true);
        this.save(1, 1);
    }

    /**
     * @description Adds a literal data point to a layer. This is not the same as
     * adding data to a sublayer. This will make an actual point appear on the screen.
     */
    this.addDataPoint = function (point, feature) {

        this.addFeatureToLayer(point, feature.layer, "Data");
        feature.addDataPoint(point);
        point.parentFeature = feature.id;

        for (var p in ImageMap.Data.bank) {
            var dbpoint = ImageMap.Data.bank[p];
            if (dbpoint == point.data) {
                ImageMap.Data.bank.splice(p, 1);

            }
        }

        this.toggleVisibility(point.id)
        this.toggleVisibility(point.id)

    }

    if (!ImageMap.Saves) ImageMap.Saves = 0;

    /**
     * @description Saves the map for loading.
     *
     *
     * @param {bool} [s_inline] Should the file contain URLs or imbeded images?
     * @param {bool} [nozip] if set, returns the link and doesn't generate the zip
     * @returns {URL || null} Either the zip URL or null
     */
    this.save = function (s_inline, nozip) {
        if (!this.loaded) return;
        if (!s_inline) s_inline = false;
        if (ImageMap.NoSave) return;
        localStorage.data = JSON.stringify(ImageMap.Data.bank);

        var bl = new Object(); // baseLayer
        // furl is the full url, durl is the url as binary
        if (this.baseLayer.furl)
            bl.url = (this.baseLayer.furl.name) ? "img/" + this.baseLayer.furl.name : this.baseLayer.furl;
        else
            bl.url = this.baseLayer.durl;
        if (s_inline) bl.url = this.baseLayer.durl;
        bl.width = this.width;
        bl.setScale = this.setScale;
        bl.height = this.height;
        bl.setScale = this.setScale;
        bl.isBaseLayer = true;
        bl.scale = this.scale;
        bl.name = this.name;
        if (bl.name == "") bl.name = "Base Layer"

        //JSON.stringify turns the object to a JSON string
        content = "[" + JSON.stringify(bl) + ",";

        for (var i = 0; i < this.layers.length; i++) {
            if (this.layers[i]) {
                if (this.layers[i].name == "Resizable layer") continue;
                // convert the layer and all features to JSON
                var o = toJSON(this.layers[i], "Layer", s_inline);
                content += JSON.stringify(o) + ",";
            }
        }
        content = content.slice(0, -1);
        content += "]";
        content = JSON.stringify(content);

        if (nozip) {

            var db = openDatabase('Map', '1.0', 'Map', 100 * 1024 * 1024);

            if (!ImageMap.WasLoaded || ImageMap.CurrentDBOffsetIndex > 0) {
                db.transaction(function (tx) {
                    tx.executeSql('DROP TABLE save');
                });
                ImageMap.WasLoaded = true
                ImageMap.Saves = 0;
                localStorage.saves = 0;
                ImageMap.CurrentDBOffsetIndex = 0;
            }

            db.transaction(function (tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS save (id INTEGER NOT NULL PRIMARY KEY, json TEXT )');
            });

            db.transaction(function (tx) {
                ImageMap.Saves++;

                tx.executeSql('INSERT INTO save (id,json) VALUES (?,?)', [ImageMap.Saves, content], function (tx) {},
                    function (tx) {});
                localStorage.saves = ImageMap.Saves;

            });

        }
        
        var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;

        
        if (nozip) {
            ///localStorage.setItem("imap",content );
            return content;
        }
        if (is_chrome){
	        downloadFile("imagemap.txt", content);
        }
        else if (0 && navigator.mimeTypes["application/x-shockwave-flash"] != undefined) {
            return content;
        } else {
            var zip = new JSZip();
            zip.file("imagemap.txt", content);
            var content = zip.generate();
            location.href = "data:application/zip;base64," + content;
            return null;
        }

    }

    /**
     * @description Locks or unlocks a layer.
     *
     * @param {OpenLayers.Layer} lay The Layer to lock or unlock
     * @param {Bool} [notifyLayerSwitcher = false] if true, we don't inform the LayerSwitcher
     */

    this.toggleLockLayer = function (lay, notifyLayerSwitcher) {
        lay.locked = (lay.locked) ? !lay.locked : true;
        if (lay.locked) {

        }
        for (var f in lay.features) {
            lay.features[f].locked = (lay.features[f].locked) ? !lay.features[f].locked : true;
            if (lay.features[f].modify && lay.features[f].modify.active) lay.features[f].modify.destroy();
        }
        if (notifyLayerSwitcher == true) {
            this.layerSwitcher.lockLayer(lay, true);
        }
    }

    /**
     * @ignore @property {string} mode What's happening currently
     */

    this.mode = "drag";

    /** @description Changes the base image scale and applys to all layers
     *
     * @param: {int} scale The width in arbitrary units of the base.
     */

    this.changeScale = function (scale) {
        var ble = ImageMap.MakeBoundsFromWH(scale, this.height / this.width * scale);
		this.selectControl.unselectAll();

        this.scale = scale;

        for (var l in this.layers) {
            for (var f in this.layers[l].features) {
                var fe = this.layers[l].features[f];
                if (!fe.attributes.graphicHeight) continue;

                var s = fe.attributes.graphicHeight / this.layers[l].features[f].attributes.graphicWidth;
                var scalingFactor = scale / this.width;;
                fe.attributes.graphicWidth *= scalingFactor;
                fe.attributes.graphicHeight *= scalingFactor;
                var c = fe.geometry.getBounds().clone();
                fe.geometry.move(0, 0);
                fe.geometry.move(c.left * scalingFactor - c.left, c.top * scalingFactor - c.top);
                continue;

                fe.geometry = new OpenLayers.Geometry.Point(fe.geometry.bounds.left * (scalingFactor),
                    fe.geometry.bounds.top * (scalingFactor));

            }
        }

        this.height = scale * this.height / this.width;
        this.width = scale;

        for (var l in this.layers) {
            this.layers[l].refresh({
                force: true
            });
        }

        this.map.zoomToExtent(ble, true);
        this.scaleLine.update();

    }

    /**
     * @description Adds a feature... to a layer.
     *
     * @param {OpenLayers.Feature} feature The Feature that hasn't been added to the map yet (or an array of them)
     * @param {OpenLayers.Layer} layer The Layer that has or hasn't been added to the map yet
     */
    this.addFeatureToLayer = function (feature, layer, datap, nosave) {
        if (typeof layer == 'string' || layer instanceof String) {
            for (l in this.layers) {
                if (this.layers[l].name == layer) {
                    layer = this.layers[l];
                    break;
                }
            }
        }
        if (feature.length) {
            for (var f in feature) {
                layer.addFeatures([feature[f]]);
                layer.drawFeature(feature[f]);
                feature[f]._layer = layer;
                feature[f].layer = layer;

            }

        } else {
            layer.addFeatures([feature]);
            layer.drawFeature(feature);
            feature._layer = layer;
            feature.layer = layer;

        }

        if (layer.calculateBounds)
            layer.calculateBounds();
        if (feature.geometry && feature.geometry.calculateBounds) feature.geometry.calculateBounds()

        if (datap)
            this.data.push(feature);
        else
            this.addFeature(feature);

        layer.redraw({
            force: true
        });
        this.features.push(feature);

        this.addNewSelectControl();
        if (this.baseLayer && this.layers.length > 2 && !nosave)
            this.save(true, true);

        if (feature.type == "Data Point") {
            if (!this.points) this.points = new Array();
            this.points.push(feature);
        }

        document.getElementById(this.div + "map").className = "";
        if (document.getElementById("draghere"))
            document.getElementById("draghere").style.display = "none";

    }

    /***
     * @description Finds the layer in the layer array and returns it
     * @param {string} layer Name of the layer
     *
     * @returns {OpenLayers.layer} The matched layer or null if not found.
     */

    this.getLayer = function (layer) {
        if (!layer) return null;
        for (var l in this.layers) {
            if (this.layers[l].name == layer || this.layers[l].id == layer) {
                return this.layers[l];
            }
        }
        return null;
    }

    /**
     * @property scale
     * @description Represents the "width" of the baseLayer. 
      A scale of 100 means that the base is 100 arbitrary units long. 
      All other layers are relative to this scale.
      The height is defined as ImHeight/ImWidth * scale
     * @returns {int} The scale of the map. 
     */

    this.scale = 1;

    /** @property
     * @description The Base Layer of the Map
     */
    this.baseLayer = null;

    /**
     * @description Add a Layer to the map
     *
     * @param {OpenLayers.Layer} e Layer To add
     * @param {OpenLayers.Feature} [features] array of features to add to layer
     */

    this.addLayer = function (e, features, dontcheck, dontsave) {
        if (features != undefined) {
            this.addFeatureToLayer(features, e);
        }

        if (!dontcheck && this.getLayer(e)) {
            alert("Bye")
            return;
        }

        var immap = this;
        this.layers.push(e);
        e.description = "Work please";
        if (!this.map.size) {

        }
        this.map.addLayer(e);
        this.addNewSelectControl();
        e.redraw();
        for (var l in this.layers) {
            if (this.layers[l].locked) {
                /** 					this.layerSwitcher.lockLayer(this.layers[l],true); */
            }
        }

        if (!e.ImageMap) e.ImageMap = this;
        if (this.baseLayer && this.layers.length > 2 && !dontsave)
            this.save(1, 1);

    };

    this.addLayers = function (e) {
        this.layers.push(e);
        this.map.addLayers(e);
    };

    this.selectFeature = function (feat) {
        var f = this.getFeature(feat);

        if (f.transformControl) {
            this.selectControl.unselectAll();
            return;
        }
        this.selectControl.unselectAll();
        this.selectControl.select(f);
    }

    /**
     * @description add and remove a select control. Select Control controls... selecting layers.
     *
     */

    this.addNewSelectControl = function () {
        if (this.selectControl) this.removeSelectControl();

        var immap = this;
        var sc = new OpenLayers.Control.SelectFeature(this.layers, {
            clickout: true,
            toggle: false,
            multiple: false,
            hover: false,
            toggleKey: "ctrlKey", // ctrl key removes from selection
            multipleKey: "shiftKey", // shift key adds to selection

            clickoutFeature: function (feature) {
                //                    this.unselectAll();		                    
            },
            onSelect: function (feature) {

                if (ImageMap.map.click == "double") {}

                if ((feature.layer && feature.layer.locked) || feature.locked) {
                    ImageMap.map.passedSelect = true;
                    this.unselect(feature);
                    if (feature.type == "Data Point") {
                        feature.displayPopup();
                    }
                    return;
                };

                ImageMap.map.passedSelect = false;
                // When a feature is selected, add a modifyFeatureControl to it
                //if (feature.type == "Data Point") { this.unselect(feature); return;   }
                if (!feature.geometry) return;
                if (immap.mode == "Add Image") {
                    this.unselect(feature);
                    popup_func(null, {
                        'lon': feature.geometry.bounds.left,
                        'lat': feature.geometry.bounds.top
                    });
                    return;
                }

                if (immap.mode == "Add Data" && ImageMap.Data.bank.length == 0) {
                    this.unselect(feature);
                    ImageMap.map.data_button.deactivate();
                }

                if (immap.mode == "Add Data" && ImageMap.Data.queue.length == 0) {

                    feature.addDataPopup(immap.map.getLonLatFromViewPortPx(event.xy));
                    this.unselect(feature);

                    return;
                } else if (immap.mode == "Add Data") {
                    var d = ImageMap.Data.queue.shift();
                    var ll = immap.map.getLonLatFromViewPortPx(event.xy);

                    var size = $('#point_size').val();

                    size = parseFloat(size) / 100;

                    if (!d.data) {

                        return;
                    };
                    var shape = $('input[name="pshape"]:checked').val();

                    immap.addDataToFeature(feature, d.data, d.data.pointnumber, false, ll.lon, ll.lat, shape, size); {
                        ImageMap.map.selectControl.unselectAll();
                    }
                    //d.parentNode.removeChild(d);

                    if (ImageMap.Data.queue.length > 0) {
                        var d = ImageMap.Data.queue[0].cells[0].innerHTML + " , ";
                        if (ImageMap.Data.queue[0].cells[1])
                            d += ImageMap.Data.queue[0].cells[1].innerHTML;

                        ImageMap.Data.queue.lastTooltip = d;
                        var xp = (ll.lon - feature.geometry.bounds.left) / (feature.attributes.graphicWidth) * 100;
                        var yp = (feature.geometry.bounds.top - ll.lat) / feature.attributes.graphicHeight * 100;
                        d += "(" + xp.toFixed(1) + "%," + yp.toFixed(1) + "%)";

                        $("div#aToolTip")[0].childNodes[0].innerHTML = d;
                    } else {
                        $('#aToolTip').hide();
                        $('div').unbind();
                        ImageMap.map.data_button.deactivate();

                    }
                    return;
                } else if (immap.selectedFeatures.length == 0) {
                    immap.addTransformBoxToFeature(feature);
                    var f = document.getElementById(feature.id);
                    if (f) {
                        if (f.parentNode) {
                            f.parentNode.childNodes[2].style.backgroundColor = '#ffff00';
                        }
                    }

                } else if (immap.mode != "Add Data") this.highlight(feature)
                immap.selectedFeatures.push(feature);

            },
            onUnselect: function (feature) {

                var f = document.getElementById(feature.id)
                if (f && f.parentNode) {
                    f.parentNode.childNodes[2].style.backgroundColor = '';
                }

                if (feature.transformControl) {
                    immap.transformLayer.removeFeatures([feature.transformControl.feature]);
                    feature.transformControl.deactivate();
                    immap.map.removeControl(feature.transformControl)
                    feature.transformControl.destroy();
                    feature.transformControl = null;
                    /* 						  immap.dragPanControl.activate(); */

                } else this.unhighlight(feature);
                for (var i in immap.selectedFeatures) {
                    if (immap.selectedFeatures[i] == feature) {
                        immap.selectedFeatures.splice(i, 1);
                        break;
                    }
                }
                if (ImageMap.map.mode != "Add Data") {
                    ImageMap.map.mode = "";
                    ImageMap.map.save(1, 1);
                }
            }

        });
        this.selectControl = sc;
        sc.handlers['feature'].stopDown = false;
        sc.handlers['feature'].stopUp = false;

        this.map.addControl(sc);
        if (this.layers.length > 0)
            sc.activate();

    }

    this.addTransformBoxToFeature = function (fea) {
        var ex = fea.geometry.getBounds().clone();
        if (fea.type == "Data Point") {
            ex.left = fea.geometry.x + fea.attributes.graphicXOffset;
            ex.top = fea.geometry.y - fea.attributes.graphicYOffset;
        }
        ex.right = ex.left + fea.attributes.graphicWidth
        ex.bottom = ex.top - fea.attributes.graphicHeight;

        var pointList = [];
        this.mode = "transform";

        pointList.push(new OpenLayers.Geometry.Point(ex.left, ex.bottom));
        pointList.push(new OpenLayers.Geometry.Point(ex.left, ex.top));
        pointList.push(new OpenLayers.Geometry.Point(ex.right, ex.top));
        pointList.push(new OpenLayers.Geometry.Point(ex.right, ex.bottom));

        pointList.push(pointList[0]);

        for (var i in pointList) {
            //pointList[i].rotate( fea.attributes.rotation || 0, pointList[i].getCentroid() )
        }

        var linearRing = new OpenLayers.Geometry.LinearRing(pointList);
        linearRing.rotate(-fea.attributes.rotation || 0, pointList[1])
        var ob = linearRing.getBounds();
        //linearRing.rotate(-(fea.attributes.rotation || 0), linearRing.getCentroid())
        var nb = linearRing.getBounds();
        //			 linearRing.move(nb.left - ob.left, nb.top - ob.top);

        var polygonFeature = new OpenLayers.Feature.Vector(
            new OpenLayers.Geometry.Polygon([linearRing]));
        //             if (fea.attributes.rotation)
        //  polygonFeature.geometry.rotate(-fea.attributes.rotation, pointList[1]);

        this.addFeatureToLayer(polygonFeature, this.transformLayer);

        var tl = new OpenLayers.Control.TransformFeature(this.transformLayer, {
            renderIntent: "transform",
            rotationHandleSymbolizer: "rotate",
            preserveAspectRatio: true
        });

        if (fea.points && fea.points.length > 0) tl.rotate = false;

        fea.transformControl = tl;

        tl.realFeature = fea;

        this.transformLayer.changeZIndex(100);

        this.map.addControl(tl);
        if (!tl.feature) tl.feature = polygonFeature;
        tl.setFeature(polygonFeature);
        var upH = this;
        tl.activate();

        tl.events.register("transformcomplete", tl, function (evt) {

        });

        tl.events.register("transform", tl, function (evt) {

            if (fea.attributes.rotation == undefined) fea.attributes.rotation = 0;
            if (this.oldRotate == undefined) this.oldRotate = 0;
            if (!upH.testCount) upH.testCount = 0;
            if (this.oldRotate - evt.object.rotation != 0) {
                this.oldRotate = evt.object.rotation;
                fea.attributes.rotation = -evt.object.rotation;
                fea.move(new OpenLayers.LonLat(evt.object.rotationHandles[3].geometry.getBounds().left, evt.object.rotationHandles[
                    3].geometry.getBounds().top));

            } else {

                for (var i in upH.selectedFeatures) {
                    var curFeature = upH.selectedFeatures[i];

                    var verts = this.feature.geometry.getVertices();
                    var ow = upH.selectedFeatures[0].attributes.graphicWidth;
                    var oh = upH.selectedFeatures[0].attributes.graphicHeight;
                    upH.selectedFeatures[0].attributes.graphicWidth = verts[0].distanceTo(verts[3]);
                    upH.selectedFeatures[0].attributes.graphicHeight = verts[0].distanceTo(verts[1]);
                    var mult = upH.selectedFeatures[0].attributes.graphicWidth / ow;
                    var multy = upH.selectedFeatures[0].attributes.graphicHeight / oh;
                    var moveX = upH.selectedFeatures[0].geometry.getBounds().left - evt.object.rotationHandles[3].geometry
                        .getBounds().left;
                    var moveY = upH.selectedFeatures[0].geometry.getBounds().top - evt.object.rotationHandles[3].geometry
                        .getBounds().top;

                    if (!this.dispX || (mult < 0.9999 || mult > 1.0001)) this.dispX = -this.box.geometry.getBounds()
                        .left + this.realFeature.geometry.getBounds().left;
                    if (!this.dispY || (multy < 0.9999 || multy > 1.0001)) this.dispY = this.box.geometry.getBounds()
                        .top - this.realFeature.geometry.getBounds().top;

                    var dispX = this.dispX;
                    var dispY = this.dispY;
                    if (mult < 0.9999 || mult > 1.0001)
                        dispX = 0;
                    if (multy < 0.9999 || multy > 1.0001)
                        dispY = 0;

                    if (upH.selectedFeatures[0].attributes.rotation == 0 || 1)
                        curFeature.move(new OpenLayers.LonLat(evt.object.rotationHandles[3].geometry.getBounds().left +
                            dispX - (curFeature.attributes.graphicXOffset || 0), evt.object.rotationHandles[3].geometry
                            .getBounds().top - dispY + (curFeature.attributes.graphicYOffset || 0)));
                    else {
                        //curFeature.geometry.move(moveX, moveY);
                    }

                    for (var j in curFeature.points) {
                        if (curFeature.type == "Data Point") break;

                        curFeature.points[j].attributes.graphicWidth *= mult;
                        curFeature.points[j].attributes.graphicHeight *= multy;
                        if (mult > 0.9999 && mult < 1.0001 && multy > 0.9999 && multy < 1.0001) {

                            curFeature.points[j].geometry.move(-moveX + this.dispX, 0);
                            curFeature.points[j].geometry.move(0, -moveY - this.dispY);
                            //	curFeature.points[j].geometry.x -= moveX;
                            //	curFeature.points[j].geometry.y -= moveY;
                            //curFeature.points[j].geometry.x -= moveX;
                            //curFeature.points[j].geometry.y += moveY;

                        } else {
                            var point = curFeature.points[j];
                            //curFeature.points[j].attributes.graphicXOffset += (upH.selectedFeatures[0].attributes.graphicWidth - ow)/2;
                            //curFeature.points[j].attributes.graphicYOffset -= (upH.selectedFeatures[0].attributes.graphicHeight - oh)/2;

                            //point.attributes.graphicXOffset = 0;
                            //point.attributes.graphicYOffset = 0;
                            point.move(new OpenLayers.LonLat(curFeature.geometry.x + point.xp * curFeature.attributes
                                .graphicWidth, curFeature.geometry.y - point.yp * curFeature.attributes.graphicHeight
                            ));

                            //curFeature.points[j].geometry.x = curFeature.points[j].geometry.bounds.left;
                            //curFeature.points[j].geometry.y = curFeature.points[j].geometry.bounds.top;

                        }

                    }
                    curFeature.layer.redraw({
                        force: true
                    });

                }
            }
        });

    }

    /**
     * @description Destroys map's current selectControl
     */

    this.removeSelectControl = function () {
        if (!this.selectControl) return;
        this.selectControl.deactivate();
        this.selectControl.destroy();
        this.selectControl = null;
    }

    /**
     * @description Makes a new layer.
     * @param {string} name Name of the layer
     * @param {Array(OpenLayers.Feature)} [features] array of features to add to layer
     * @returns {OpenLayers.Layer} layer
     */

    this.makeLayer = function (name, features, extent, smap, check, add) {
        if (smap == undefined || smap == null) smap = oStyleMap;
        var layer;
        if (check || name.name) {
            var l = this.hasLayerNamed(name);
            if (l) return l;
        }

        layer = new OpenLayers.Layer.Vector(name, {
            styleMap: smap,
            renderers: renderer,
            rendererOptions: {
                transitionEffect: 'resize',
                displayOutsideMaxExtent: true,
                zIndexing: true
            },
            transitionEffect: 'resize',

            displayOutsideMaxExtent: true,
            zIndexing: true
        });

        layer.ImageMap = this;
        if (add) this.addLayer(layer, features, check, true);
        else if (features) layer.addFeatures(features);

        return layer;
    }

    /**
     * @description Checks if the map has a layer
     * @param {string} lname Name of the layer
     *
     * @returns {bool} true if map has layer, false otherwise
     */

    this.hasLayerNamed = function (lname) {
        for (var l in this.layers) {
            if (this.layers[l].name == lname || this.layers[l].id == lname) {
                return this.layers[l];
            }
        }
        return false;

    }

    this.downloadAllData = function () {
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

        for (var l in this.layers) {
            for (var f in this.layers[l].features) {
                var feat = this.layers[l].features[f];
                for (var p in feat.points) {
                    var point = feat.points[p];
                    var i = 0;
                    csv += feat.id + ",";

                    var x = point.geometry.x - feat.geometry.bounds.left;
                    var y = feat.geometry.bounds.top - point.geometry.y;
                    x *= 100 / feat.attributes.graphicWidth;
                    y *= 100 / feat.attributes.graphicHeight;
                    x = x.toFixed(2);
                    y = y.toFixed(2);
                    csv += x + "%," + y + "%,";

                    for (var a in set) {
                        if (point.data[a]) {
                            csv += point.data[a] + ",";
                        } else {
                            csv += ",";
                        }
                    }
                    csv = csv.slice(0, -1);
                    csv += "\n";

                }
            }
        }

        return ImageMap.downloadZip("alldata.csv", csv);
    }

    /* @ignore */
    this.addImage = function (image) {
        this.addLayer(image);
    }

    /**
     * @description Sets the baselayer of the map
     * @param {OpenLayers.Layer} bl Layer that is the baseImageLayer
     */
    this.setBaseLayer = function (bl) {
        this.baseLayer = bl;
        this.map.addLayer(bl);
        this.map.setBaseLayer(bl)
    }

    this.addOption = function (layer, key, value) {
        var index = this.layers.indexOf(layer);
        this.layers[index].key = value;
    }
    this.addOptions = function (layer, dict) {
        var index = this.layers.indexOf(layer);
        this.layers[index].addOptions(dict);
    }

    /**
     * @description Adds a feature to the ImageMap list of features
     * @param {OpenLayers.Feature} feature Feature to add
     */

    this.addFeature = function (feature) {
        if (feature.type == "Data Point") {
            this.data.push(feature);
            return;
        }
        if (feature.length)
            for (var f in feature) {
                this.features.push(feature[f]);
            } else this.features.push(feature);
    }

    this.data = new Array();

    /**
     * @description Adds data to the feature  features
     * @param {OpenLayers.Feature} feature Feature to data too
     * @param {string} data
     */

    this.addDataToFeature = function (feature, data, name, close, x, y, shape, size) {
        feature = this.getFeature(feature);
        if (!x) x = feature.geometry.x;
        if (!y) y = feature.geometry.y;

        if (!data || !data.pointnumber) {
            var first;
            for (first in data) break;
            data.pointnumber = data[first];
        }

        /* 	    	var f = ImageMap.MakeDataPointFromFeature(name || "Feature Data" , data, feature); */
        if (name == "2") {
            name = data.pointnumber.toString();
        }

        if (!shape && !size) {
            var size = $('#point_size').val();

            size = parseFloat(size) / 100;

            shape = $('input[name="pshape"]:checked').val();
        }

        var f = ImageMap.MakeDataPoint(name || JSON.stringify(data) || "Feature Data", x, y, data, feature.layer, shape,
            size);
        this.addDataPoint(f, feature);
        var off = f.attributes.graphicWidth;
        var offH = f.attributes.graphicWidth;

        f.xp = (f.geometry.x - feature.geometry.x) / feature.attributes.graphicWidth;
        f.yp = (feature.geometry.y - f.geometry.y) / feature.attributes.graphicHeight;


        if (close) ImageMap.map.map.removePopup(feature.popup);
        f.geometry.calculateBounds();

        var row = document.getElementById(JSON.stringify(data).hashCode());
        if (row && row.parentNode)
            row.parentNode.removeChild(row);

        feature.layer.redraw({
            force: true
        });
        this.layerSwitcher.redraw(true);
        for (var i in this.selectedFeatures) {
            if (this.selectedFeatures[i] == feature) {
                this.selectedFeatures.splice(i, 1);
                break;
            }
        }

    }

    /**
     * @description Gets a feature give the feature's id
     * @param {string} feature id
     */
    this.getFeature = function (feature) {

        if (feature && feature.attributes) return feature;
        for (var i in this.layers) {
            for (var j in this.layers[i].features) {
                if (feature == this.layers[i].features[j].id) return this.layers[i].features[j];
                for (var p in this.layers[i].features[j].points) {
                    if (feature == this.layers[i].features[j].points[p].id)
                        return this.layers[i].features[j].points[p];
                }
            }
        }
        for (var i in this.data) {
            if (feature == this.data[i].id) return this.data[i];
        }
        return null;
    }

    /** @description Moves Feature
     * @param {OpenLayers.Feature} feature feature to move
     * @param {num} x move x units left
     * @param {num} x move y units up
     */

    this.moveFeature = function (feature, x, y) {
        feature.geometry.move(x, y);
    }

    this.moveDataToFeature = function (data, feature) {

        var f = this.getFeature(data.parentFeature);
        for (var i in f.points) {
            if (f.points[i].id == data || f.points.id == data.id) {
                f.points.splice(i, 1);
                break;
            }
        }
        var fe = this.getFeature(feature);
        fe.addDataPoint(data);
        data.parentFeature = feature.id || feature;

    }

    this.moveFeatureToLayer = function (feature, layer) {
		if (ImageMap.map.selectControl) ImageMap.map.selectControl.unselectAll();
        var l = this.getLayer(layer);
        if (!l) {
            l = this.makeLayer(layer);
            this.addLayer(l);

        }
        
		
		
        
        var f = this.getFeature(feature);
        if (f.points)
            f.layer.removeFeatures(f.points);
        f.layer.removeFeatures([f]);
        this.addFeatureToLayer(f, l);
        if (f.points) {
            l.addFeatures(f.points);
        }

        this.layerSwitcher.redraw(true);
        if (f.popup)
            f.popup.toggle();
        


    }

    /** @description Zooms in
     * @param {int} times Number of times to zoom
     */

    this.zoomIn = function (times) {
        if (!times) times = 1;
        while (times-- > 0) {
            this.map.zoomIn();
        }
    }

    /** @Toggles Feature visibility
     * @param {int} times Number of times to zoom
     */

    this.toggleVisibility = function (featureID, arr) {
    	this.selectControl.unselectAll();
        for (var i in this.layers) {
            for (var j in this.layers[i].features)
                if (this.layers[i].features[j].id == featureID) {
                    if (this.layers[i].features[j].style && this.layers[i].features[j].style.visibility == 'hidden')
                        this.layers[i].features[j].style = null;
                    else
                        this.layers[i].features[j].style = {
                            visibility: 'hidden'
                        };
                    this.layers[i].features[j].layer.redraw();
                    this.layers[i].features[j].attributes.visible = !this.layers[i].features[j].attributes.visible;
                    break;
                }
        }
        if (this.layerSwitcher)
            this.layerSwitcher.redraw(true);
    }

    /**
     * @description Removes Feature from map
     * @param {OpenLayers.Feature} feature Feature to remove
     */

    this.removeFeature = function (feature, data) {
        var f = this.getFeature(feature);
        if (data) {
            var pf = this.getFeature(f.parentFeature);
            for (var p in pf.points) {
                if (pf.points[p] == f) {
                    pf.points.splice(p, 1);
                }
            }
            if (f.popup) f.popup.destroy();
            f.destroy();
            this.layerSwitcher.removeFeature(feature);

        } else {

            for (var d in f.points) {
                this.layerSwitcher.removeFeature(f.points[d].id);
                if (f.points[d].popup) f.points[d].popup.hide();
                f.points[d].destroy();

            }
            this.selectControl.unselectAll();
            if (f.popup) f.popup.destroy();
            this.layerSwitcher.redraw(true);
            this.layerSwitcher.removeFeature(f.id);
            f.destroy();
            this.save(1, 1);
            return;

            this.save(1, 1);
        }

    }

    /** @ignore */
    var _this = this;

    this.updateFeature = function (featureID) {
        this.getFeature(featureID).updateFromPopup();
    }

    /** @ignore */
    this.zoomToExtent = function () { /**this.map.zoomToExtent(this.extent()); */ }

    /** @ignore */
    this.setupBaseLayer = function (imm) {
        var bimage
        if (!imm) {
            baseLayer_extent = ImageMap.MakeBoundsFromWH(this.scale || this.width, this.height);
            var imm = {};
            imm.width = this.scale;
            imm.height = this.height || this.scale;

            imm = ImageMap.MakeImage(this.name, "img/blank.gif", baseLayer_extent, {
                isBaseLayer: true
            }, new OpenLayers.Size(imm.width, imm.height));
            imm.src = "img/blank.gif";
            imm.url = "img/blank.gif";
            imm.furl = "img/blank.gif";
            imm.durl = "img/blank.gif";
            imm.width = this.scale;
            imm.height = this.height || this.scale;
            bimage = imm;
            //bimage.url = "img/circle.png";
            //bimage.type = "Grid";
        }
        if (!this.width)
            this.width = this.scale;
        if (!this.height) this.height = imm.height / imm.width * this.scale;
        baseLayer_extent = ImageMap.MakeBoundsFromWH(this.width, this.height);
        this.baseLayerExtent = baseLayer_extent;
        if (!imm.id) {
            bimage = ImageMap.MakeImage(this.name, imm.src, baseLayer_extent, {
                isBaseLayer: true
            }, new OpenLayers.Size(imm.width, imm.height));
            bimage.furl = imm.src;
            bimage.url = imm.src;
        } else {

        }

        bimage.width = this.width;
        bimage.height = this.height;

        document.getElementById(div).style.height = this.height + "px";
        document.getElementById(div).style.width = this.width + "px";
        document.getElementById(div + "map").style.height = this.height * 0.85 + "px";
        document.getElementById(div + "map").style.width = this.width * 0.78 + "px";

        //this.timer = window.setInterval( function () { map.save(true,true); console.log("Saved") } ,10000);

        //    		   document.getElementById(div + "map").style.height = document.getElementById(div).style.height + "";
        // document.getElementById(div + "map").style.height = parseInt(document.getElementById(div).style.height.replace("px","")) - 200;
        // document.getElementById(div + "map").style.width  = document.getElementById(div).style.width - 250;;
        // 

        this.map.setOptions({
            minScale: 10,
            maxScale: 10000,
            projection: new OpenLayers.Projection("EPSG:3857"),
            fallThrough: true,
            units: 'm'
        });

        this.map.updateSize();
        this.setBaseLayer(bimage);
        this.baseLayer = bimage;

        this.baseLayer.durl = imm.src;
        this.baseLayer.furl = this.baseLayer.url;
        this.setupMap();
        var layer_ = ImageMap.MakeLayer("Resizable layer", null, tMap, {
            displayInLayerSwitcher: false
        });
        this.transformLayer = layer_;
        this.addLayer(layer_, undefined, undefined, true);
        this.layerSwitcher.redraw(true);
        this.map.zoomToScale(1000);

        //that.baseLayer.furl = form.g.files[0];

        this.loaded = true;

    }

    /** @ignore */
    this.setupMap = function () {
        var that = this;
        var vectors = new OpenLayers.Layer.Vector("Vector Layer", {
            renderers: renderer,
            displayInLayerSwitcher: false,
            zIndexing: true,
            zIndex: 1
        });

        vectors.events.on({
            'featureselected': function (feature) {
                document.getElementById('counter').innerHTML = this.selectedFeatures.length;
            },
            'featureunselected': function (feature) {
                document.getElementById('counter').innerHTML = this.selectedFeatures.length;
            }
        });

        if (window.console && window.console.log) {
            /**@ignore*/
            reportEvent = function (event) {
                console.log(event.type,
                    event.feature ? event.feature.id : event.components);
            };
        } else {
            /**@ignore*/
            reportEvent = function () {
                console.log(event.feature.id)
            };
        }

        vectors.events.on({
            'beforefeaturemodified': reportEvent,
            'featuremodified': reportEvent,
            'afterfeaturemodified': reportEvent,
            'beforefeatureremoved': reportEvent,
            'featureremoved': reportEvent,
            'vertexmodified': reportEvent,
            'sketchmodified': reportEvent,
            'sketchstarted': reportEvent,
            'sketchcomplete': reportEvent
        });

        controls = {
            point: new OpenLayers.Control.DrawFeature(vectors, OpenLayers.Handler.Point),
            line: new OpenLayers.Control.DrawFeature(vectors, OpenLayers.Handler.Path),
            polygon: new OpenLayers.Control.DrawFeature(vectors, OpenLayers.Handler.Polygon),
            dragpan: new OpenLayers.Control.DragPan(),
            nudger: new OpenLayers.Control.KeyboardNudge()
        };

        for (var f in that.map.controls) {
            if (that.map.controls[f].slideFactor) {
                that.map.controls[f].deactivate();
                that.map.controls[f].destroy();
                that.map.addControl(new OpenLayers.Control.PanZoom({
                    div: document.getElementById('map_nav')
                }));
                break;

            }
        }

        var d = new OpenLayers.Control.Navigation({
            documentDrag: true,
            zoomWheelEnabled: false
        });
        var toolbar = new OpenLayers.Control.Panel({
            displayClass: 'olControlEditingToolbar',
            defaultControl: d
        });

        that.map.addControl(new OpenLayers.Control.ArgParser())
        that.map.addControl(new OpenLayers.Control.Attribution())

        that.map.addControl(toolbar)
        that.map.addControl(d)

        that.map.addControl(controls.nudger);
        controls.nudger.activate();

        save_button = new OpenLayers.Control.Button({
            displayClass: 'saveMapButton',
            type: OpenLayers.Control.TYPE_BUTTON,
            title: "Download Saved Map",
            trigger: function () {
                if (ImageMap.map)
                    ImageMap.map.save();
            }
        });

        load_button = new OpenLayers.Control.Button({
            displayClass: 'loadMapButton',
            title: "Load Saved Map",
            type: OpenLayers.Control.TYPE_BUTTON,
            trigger: function () {
                if (localStorage.imap) {

                }
                //document.forms.userpic.photo.click()		        
                deleteAndLoad();
            }
        });

        undo_button = new OpenLayers.Control.Button({
            displayClass: 'undoMapButton',
            title: "Undo Last Change",
            type: OpenLayers.Control.TYPE_BUTTON,
            trigger: function () {
                if (ImageMap.map)
                    ImageMap.Undo();
            }
        });

        scale_button = new OpenLayers.Control.Button({
            displayClass: 'changeScaleButton',
            title: "Set the width of the current view",
            type: OpenLayers.Control.TYPE_BUTTON,
            trigger: function () {
                if (ImageMap.map)
                    ImageMap.map.changeScale(prompt("Enter a new scale (width of the current view)"));
            }
        });

        redo_button = new OpenLayers.Control.Button({
            displayClass: 'redoMapButton',
            title: "Redo Last Change",
            type: OpenLayers.Control.TYPE_BUTTON,
            trigger: function () {
                if (ImageMap.map)
                    ImageMap.Redo();
            }
        });

        popup_function = popup_func;
        draw_add = draw_func;

        // dc.events.register("featureadded", dc, draw_add );

        add_button = new OpenLayers.Control.Button({
            displayClass: 'addImageButton',
            title: "Add Image To the Map",
            type: OpenLayers.Control.TYPE_BUTTON,
            trigger: function(){
                    //that.mode = "Add Image";
                    //that.map.events.register("click", that.map, popup_function);
                    //that.selectControl.hover = false;
                    var ll = ImageMap.map.map.getExtent();
                    var l = ImageMap.map.map.center.clone();
					l.lat = ll.top - ll.top * 0.4;
                    l.lon = ll.right;
					popup_function(null, l);
					$("#addimageform_div").lightbox_me({
						onClose: function () {
								
						}
        });


                }
                //'deactivate': function () {
                   // that.mode = "drag";
                   // that.map.events.unregister("click", that.map, popup_function);
                   // that.selectControl.hover = true;
                //}
            
        });
        data_button = new OpenLayers.Control.Button({
            displayClass: 'addDataButton',
            title: "Add Data To The Map",
            type: OpenLayers.Control.TYPE_TOGGLE,
            eventListeners: {
                'activate': function () {
                    that.mode = "Add Data";
                    if (that.selectControl) {
                        that.selectControl.unselectAll();
                    }

                    if (ImageMap.Data.bank.length == 0) {
                        document.getElementById('csvFile').click();
                        document.getElementById('ips').style.display = "";
                        return;
                    }

                    that.selectControl.hover = false;
                    var q = $("#queue");
                    if (!ImageMap.Data.queue)
                        ImageMap.Data.queue = new Array();
                    for (var i = 0; i < q[0].rows.length; i++) {
                        for (var j = 0; j < ImageMap.Data.bank.length; j++) {
                            if (ImageMap.Data.bank[j].pointnumber == q[0].rows[i].cells[0].innerHTML) {
                                q[0].rows[i].data = ImageMap.Data.bank[j];
                            }
                        }
                        //ImageMap.Data.queue.push(q[0].rows[i]);

                    }

                    updateToolTipFun = function (e) {
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
                        var highest = 0;
                        var li = 0;
                        for (var f in cand) {
                            if (cand[f].attributes) {
                                if (cand[f].attributes.graphicZIndex > highest) {
                                    highest = cand[f].attributes.graphicZIndex;
                                    li = f;
                                }
                            }
                        }

                        var feature = cand[li];

                        if (feature && ImageMap.Data.queue[0]) {
                            var xp = (ll.lon - feature.geometry.bounds.left) / (feature.attributes.graphicWidth) *
                                100;
                            var yp = (feature.geometry.bounds.top - ll.lat) / feature.attributes.graphicHeight *
                                100;
                            var d = ImageMap.Data.queue[0].cells[0].innerHTML + " , ";
                            if (ImageMap.Data.queue[0].cells[1])
                                d += ImageMap.Data.queue[0].cells[1].innerHTML;

                            d = ImageMap.Data.queue.lastTooltip || d;

                            $("div#aToolTip")[0].childNodes[0].innerHTML = d + "(" + xp.toFixed(1) + "%," + yp.toFixed(
                                1) + "%)";
                        }

                    };

                    ImageMap.map.map.events.register("mousemove", ImageMap.map.map, updateToolTipFun);

                    if (ImageMap.Data.queue.length > 0) {
                        var d = ImageMap.Data.queue[0].cells[0].innerHTML + " , ";
                        if (ImageMap.Data.queue[0].cells[1])
                            d += ImageMap.Data.queue[0].cells[1].innerHTML
                        $('div').aToolTip({
                            toolTipId: 'aToolTip',
                            tipContent: d,
                        });

                    }

                },
                'deactivate': function () {
                    that.mode = "drag";
                    that.selectControl.hover = true;

                    that.addNewSelectControl();
                    $('#aToolTip').hide();
                    $('div').unbind();
                    ImageMap.map.map.events.unregister("mousemove", ImageMap.map.map, updateToolTipFun);
                    that.save(1, 1);

                }
            }
        });

        toolbar.addControls([add_button, data_button, save_button, load_button, redo_button, undo_button]);

        that.features = new Array();
        that.topScale = undefined;
        that.addLayer(vectors, undefined, undefined, true);
        that.vectorLayer = vectors;
        that.padding = 38;
        that.data_button = data_button;

        var target = document.getElementById(that.div + "map");

        target.addEventListener("dragover", function (event) {
            event.preventDefault();
        }, false);

        target.addEventListener("drop", function (dropEvent) {
            dropEvent.stopPropagation();
            dropEvent.preventDefault();



            var lon = (dropEvent.layerX - ((window.innerWidth - ImageMap.map.width - 230) / 2));

            var lat = (dropEvent.layerY - 10);

            p = ImageMap.map.map.getLonLatFromViewPortPx({
                'x': lon,
                'y': lat
            })

            var files = FileAPI.getFiles(dropEvent);

            if (files.length == 0) {
                files = [document.getElementById(dropEvent.dataTransfer.getData("Files"))];
            }


            addFeaturesFromFiles(files, p, "Untitled Layer");
        }, false);

        that.map.addControl(new OpenLayers.Control.MousePosition());
        var slid = document.createElement("div");
        slid.id = "scaleline-id";
        document.getElementById(that.div).appendChild(slid);

        $("#map" + that.div).dblclick(function () {
            if (ImageMap.map.passedSelect)
                ImageMap.map.map.zoomIn(1);
            ImageMap.map.passedSelect = false;

        });

        var click = new OpenLayers.Control.Click();
        that.map.addControl(click);
        click.activate();

        var scaleline = new OpenLayers.Control.ScaleLine({
            div: document.getElementById("scaleline-id")
        });

        var ls = document.createElement("div");
        ls.id = "layerswitcher";
        ls.className = "olControlLayerSwitcher";
        document.getElementById(that.div).appendChild(ls);

        that.scaleLine = scaleline;

        that.map.addControl(scaleline);
        scaleline.activate();
        that.layerSwitcher = new OpenLayers.Control.LayerSwitcher({
            'div': OpenLayers.Util.getElement('layerswitcher')
        });
        that.layerSwitcher.map = that;

        that.layerSwitcher.ascending = false;
        that.layerSwitcher.useLegendGraphics = true;
        that.map.addControl(that.layerSwitcher);

        //that.addNewSelectControl();
        controls_ = that.map.getControlsByClass('OpenLayers.Control.Navigation');

        for (var i = 0; i < controls_.length; ++i) {
            controls_[i].disableZoomWheel();

        }

        that.loaded = true;

        ImageMap.map = that;
        this.map.zoomToMaxExtent();

    }

    /** @ignore @constructor */

    __construct = function (that, div, name, url, scale, options) {
        if (div.url) {
            div = div.div;
            name = div.name;
            url = div.url;
            scale = div.scale;
            options = div.options;
        }

        if (options && options['height']) {
            that.height = options['height'];
        }
        if (options && options['width']) {
            that.width = options['width'];
        }
        
        

        ImageMap.scale = scale;
        that.scale = scale;
        
        if (that.width < 100 || that.height < 100){
	        that.width = 800;
	        that.height = 400;
        }
        
        if (!name) name = "Base Layer";
        that.div = div;

        if (options == undefined) {
            baseLayer_options = new Array();
        }
        options = {
            isBaseLayer: true,
            layers: 'basic'
        };
        var di = document.createElement("div");
        di.name = div + "map"
        di.id = div + "map";
        di.className = 'empty';

        document.getElementById(div).appendChild(di);

        that.map = new OpenLayers.Map(that.div + "map", {
            projection: new OpenLayers.Projection("EPSG:3857"),
            fallThrough: true,
            units: 'm',
            minScale: 10,
            maxScale: 10000,

        });

        // This is used to calculate how the features should display at different zooms       
        context = {
            getGraphic: function (feature) {
                return feature.attributes.externalGraphic;
            },

            //width = graphicWidth / current Resolution
            getW: function (feature) {
                feature.scale = feature.attributes.graphicWidth / that.map.getResolution();
                return feature.attributes.graphicWidth / that.map.getResolution();
            },

            getH: function (feature) {
                return feature.attributes.graphicHeight / that.map.getResolution();
            },
            getZ: function (feature) {
                return feature.attributes.graphicZIndex;
            },
            rotation: function (feature) {
                if (!feature.attributes.rotation) feature.attributes.rotation = 0;
                return (feature.attributes.rotation == undefined) ? 0 : feature.attributes.rotation;

            },
            getO: function (feature) {
                if (!feature.attributes.opacity) feature.attributes.opacity = 1.0;

                return (feature.attributes.opacity == undefined) ? 1.0 : feature.attributes.opacity;

            },
            getXO: function (feature) {
                if (!feature.attributes.graphicXOffset) return 0;
                return feature.attributes.graphicXOffset / that.map.getResolution(); // * mh / h;
            },
            getYO: function (feature) {
                if (!feature.attributes.graphicYOffset) return 0;

                return feature.attributes.graphicYOffset / that.map.getResolution();;
            },

            shouldDisplay: function (feature) {
                return true;
            }

        };
        that.context = context;

        template = {
            externalGraphic: "${getGraphic}",
            pointRadius: 2,
            graphicHeight: "${getH}",
            graphicWidth: "${getW}",
            graphicXOffset: "${getXO}",
            graphicYOffset: "${getYO}",
            graphicOpacity: "${getO}",
            graphicZIndex: "${getZ}",

            rotation: "${rotation}",
            strokeWidth: 2,
            cursor: "${role}",
            strokeColor: "#0000ff",
            fillOpacity: 1,

        };
        template2 = {
            externalGraphic: "${getGraphic}",
            pointRadius: 2,
            graphicHeight: "${getH}",
            graphicWidth: "${getW}",
            graphicXOffset: "${getXO}",
            graphicYOffset: "${getYO}",
            graphicOpacity: .5,
            graphicZIndex: "${getZ}",

            rotation: "${rotation}",
            strokeWidth: 10,
            cursor: "${role}",
            strokeColor: "#0000ff",
            fillOpacity: 0.3,
            fillColor: "#aaa"

        };
        st = template;
        st['strokeColor'] = '#ff0000';
        that.template = template;

        oStyleMap = new OpenLayers.StyleMap({
                "default": new OpenLayers.Style(template, {
                        context: context,

                    }

                ),
                "select": new OpenLayers.Style(template2, {
                        context: context,

                    }

                )

            }, {
                renderers: renderer
            }

        );

        that.styleMap = oStyleMap;

        tMap = new OpenLayers.StyleMap({

            "transform": new OpenLayers.Style({
                display: "${getDisplay}",
                cursor: "${role}",
                pointRadius: "${pointR}",
                fillColor: "white",
                strokeColor: "black",

                fillOpacity: 1

            }, {
                context: {
                    getDisplay: function (feature) {
                        // hide the resize handle at the south-east corner
                        return feature.attributes.role === "se-resize" ? "none" : "";
                    },
                    pointR: function (feature) {
                        return (feature.type == "Data Point") ? 3 : 6;
                    }

                }
            }),
            "rotate": new OpenLayers.Style({
                pointRadius: "${pointR}",
                fillColor: "#ddd",
                fillOpacity: 0.8,
                display: "${getDisplay}",
                cursor: "${role}",

                strokeColor: "#333",

            }, {
                context: {
                    getDisplay: function (feature) {
                        // only display the rotate handle at the south-east corner
                        return feature.attributes.role === "se-rotate" ? "" : "none";
                    },
                    pointR: function (feature) {
                        return (feature.type == "Data Point") ? 4 : 7;
                    }

                }
            })
        }, {
            renderers: renderer
        });

        that.selectedFeatures = new Array();

        that.name = name;

        if (!url) {
            that.setupBaseLayer();
        } else {
            if (url.src) {
                that.setupBaseLayer(url);
            } else {
                var imm = new Image();
                that.busy = true;
                imm.onload = function () {
                    that.setupBaseLayer(this);
                };

                imm.src = url;
            }
        }

    }(this, div, name, url, scale, options)

};

	/** ImageMap Class Methods */
	
	/**
	     * @description load a map from a ImageMap save file
	     * @param {string} the div to load the map into
	     * @param {string} data JSON data from ImageMap save file
	
	     * @returns loaded imagemap
	     */
	
	ImageMap.load = function (div, data) {
	    if (data[0] == 'P' && data[1] == 'K') { // This means it's a zip
	        var zip = new JSZip(data, {
	            base64: false
	        });
	        $.each(zip.files, function (index, zipEntry) {
	            data = zipEntry.asText();
	        });
	    }
	
	    ImageMap.WasLoaded = true;
	    ImageMap.NoSave = true;
	    ImageMap.Saves = localStorage.saves;
	    if (localStorage.data && !ImageMap.undid && !ImageMap.redid && localStorage.data != []) {
			//$("#pointTable").empty();
			$("#pointTable thead tr").empty()
			$("#pointTable tr").empty()
	        var h = "";
	        var ldata = JSON.parse(localStorage.data);
	        for (var head in ldata[0]) {
	            h += head + ",";
	        }
	        h += "\n";
	        for (var i in ldata) {
	            for (var j in ldata[i]) {
	                h += ldata[i][j] + ",";
	            }
	            h += "\n";
	        }
	        if (h != "\n") {
	            //disable load data
	            ImageMap.Data.readCSV(h);
	            document.getElementById("ips").style.display = "";
	        }
	
	    }
	    var layers = $.parseJSON("[" + data.replace(/&quot;/ig, '"') + "]");
	    if (!layers[0].push)
	        layers = $.parseJSON("[" + layers + "]");
	    layers = layers[0];
	    var base = layers[0];
	
	    var ext = ImageMap.MakeBoundsFromWH(base.width, base.height);
	    var imm = new Image();
	    imm.onload = function () {
	        map = new ImageMap(div, base.name, base.url, base.width, {
	            height: base.height
	        });
	        map.setScale = base.setScale;
	        ImageMap.map = map;
	        ImageMap.setScale = base.setScale;
	        if (!ImageMap.Data.bank) ImageMap.Data.bank = new Array();
	
	        for (var i = 1; i < layers.length; i++) {
	            var obj_layer = layers[i];
	            var layer;
	            if (obj_layer.name == "Vector Layer") {
	                layer = map.getLayer("Vector Layer");
	            } else {
	                layer = map.makeLayer(obj_layer.name);
	
	                if (obj_layer.visibility != undefined) layer.setVisibility(obj_layer.visibility);
	
	                if (obj_layer.id) layer.id = obj_layer.id;
	                if (obj_layer.opacity) layer.opacity = obj_layer.opacity;
	                if (!obj_layer.features || obj_layer.features == undefined || obj_layer.features == "") {
	                    obj_layer.features = new Array();
	                }
	
	                if (obj_layer.metaData) {
	                    layer.addMetaData(obj_layer.metaData);
	                }
	
	                if (obj_layer.locked) {
	                    //map.toggleLockLayer(layer);
	                    layer.locked = obj_layer.locked;
	                }
	                layer.zIndex = obj_layer.zIndex;
	                layer.opacity = obj_layer.opacity;
	                map.addLayer(layer, undefined, undefined, true);


	                if (obj_layer.zIndex) map.map.setLayerIndex(layer, obj_layer.zIndex)
	
	                if (obj_layer.opacity) layer.setOpacity(obj_layer.opacity);
	
	                if (layer) layer.redraw({
	                    force: true
	                });
	
	            }
	
	            var dp = new Array();
	
	            for (var f in obj_layer.features) {
	                var obj_feature = obj_layer.features[f];
	                var feature;
	
	                if (obj_feature.type == "Data Point") {
	                    continue;
	                } else {
	                    bounds = obj_feature.extent;
	                    var feature = ImageMap.MakeFeature(obj_feature.id,
	                        obj_feature.externalGraphic,
	                        obj_feature.x,
	                        obj_feature.y,
	                        obj_feature.graphicWidth,
	                        obj_feature.graphicHeight);
	                    feature.layer = layer;
	                    feature.mp_id = obj_feature.mp_id;
	                    feature.points = new Array();
	                    feature.name = (obj_feature.name || obj_feature.id);
	                    feature.attributes.rotation = obj_feature.rotation;
	                    feature.attributes.graphicZIndex = obj_feature.graphicZIndex;
	                    feature.attributes.graphicXOffset = obj_feature.graphicXOffset;
	                    feature.attributes.graphicYOffset = obj_feature.graphicYOffset;
	                    feature.locked = obj_feature.locked;
	
	                    feature.attributes.opacity = obj_layer.opacity || obj_feature.opacity;
	
	                    feature.layer = layer;
	                    map.addFeatureToLayer(feature, layer, undefined, true);
	
	                    for (var p in obj_feature.points) {
	                        var p = obj_feature.points[p];

	
	                        r = ImageMap.MakeDataPoint(p.id, p.x,
	                            p.y, p.data, layer, p.shape || p.externalGraphic, p.size || p.graphicWidth);

	                        map.addDataPoint(r, feature);
	                        r.attributes.graphicXOffset = p.graphicXOffset;
	                        r.attributes.graphicYOffset = p.graphicYOffset;
	                        r.attributes.graphicWidth = p.graphicWidth;
	                        r.attributes.graphicHeight = p.graphicHeight;
	                        r.attributes.opacity = p.opacity;
	                        r.xp = p.xp;
	                        r.yp = p.yp;
	                        if (r.geometry.y > map.scale) {
	                            r.geometry.x = p.x;
	                            r.geometry.y = p.y;
	                            r.geometry.bounds = ImageMap.MakeBounds(p.x, p.y, p.x, p.y);
	                        }

	
	                        r.layer = layer;
	                        feature.layer = layer;
	
	                    }
	                    //feature.loadData("lib/data.json");
	
	                }
	
	                if (obj_feature.type == "Data Point") {
	                    //feature.parentFeature = obj_feature.parentFeature;
	                    //feature.layer = layer;
	                    //dp.push(feature);
	                } else {
	                    /*
					    	feature.layer = layer;
					        map.addFeatureToLayer(feature, layer);
	*/
	                }
	
	                if (obj_feature.data) {
	                    //feature.data = obj_feature.data;
	                }
	
	            }
	
	            for (var f in dp) {
	
	                // var pf = map.getFeature(dp[f].parentFeature);
	                //map.addDataPoint(dp[f], pf);
	            }
	
	            // layer.setIsBaseLayer means it's a layer
	
	        }
	
	        map.addNewSelectControl();
	        ImageMap.NoSave = false;
	        ImageMap.map.save(1, 1);
	
	        for (var i in map.layers) {
	            if (map.layers[i].zIndex != undefined)
	                map.map.setLayerIndex(map.layers[i], map.layers[i].zIndex);
	            if (map.layers[i].opacity) {
	                map.layers[i].setOpacity(map.layers[i].opacity);
	            }
	

	            map.layers[i].redraw({
	                force: true
	            });
	        }
	
	        return map;
	
	    }
	    imm.src = base.url;
	}

	/**
	 * @description Creates quad. Bounds left,bottom,right,top represent the respective x or y coordinate
	 * @param {float,float,float,float} Left, Bottom, Right, Top points
	 *
	 * @returns {OpenLayers.Bounds} Extent Bounds
	 */
	
	ImageMap.MakeBounds = function (left, bottom, right, top) {
	    if (arguments.length == 1) {
	        return new OpenLayers.Bounds(left.left, left.bottom, left.right, left.top);
	    }
	    if (arguments.length == 2) {
	        return new OpenLayers.Bounds(-0.5 * left, -0.5 * bottom, 0.5 * left, 0.5 * bottom)
	    }
	    return new OpenLayers.Bounds(left, bottom, right, top);
	}
	
	/**
	 * @description Makes a bounds that is the size of the feature
	 * @param {OpenLayers.Feature} Feature
	 * @returns {OpenLayers.Bounds} Extent Bounds
	 */
	
	ImageMap.MakeBoundsFromFeature = function (feature) {
	    var v = feature.geometry.getBounds();
	    return ImageMap.MakeBounds(v.left, v.top - feature.attributes.graphicHeight,
	        v.left + feature.attributes.graphicWidth, v.top);
	}
	
	/**
	 * @description Makes a bounds that start at (x,y) and go to (x + width, y - height)
	 * @param {float,float,float,float} OR {OpenLayers.LonLat, float, float}
	 * @returns {OpenLayers.Bounds} Extent Bounds
	 */
	
	ImageMap.MakeBoundsFromPoint = function (x, y, width, height) {
	    if (x.lon) {
	        y = x.lat;
	        x = x.lon;
	        width = y;
	        height = width;
	    }
	
	    return ImageMap.MakeBounds(x, y - height, x + width, y);
	}
	
	/**
	 * @description Makes Base Image
	 * @param {string} Name of the Base Layer
	 * @param {string} URL of the baseLayer image
	 * @param {OpenLayers.Bounds} Extent Bounds
	 * @param {Object} Options
	 * @param {OpenLayers.Bounds} Size of image (depricated)
	 * @returns {OpenLayers.Layer.Image} for base layer
	 */
	
	ImageMap.MakeImage = function (name, url, extent, options, size) {
	    if (size == undefined) {
	        size = new OpenLayers.Size(
	            Math.abs(extent.right) + Math.abs(extent.left),
	            Math.abs(extent.top) + Math.abs(extent.bottom));
	    }
	    if (options == undefined) options = {
	
	        zIndex: 2,
	        opacity: 1,
	    };
	
	    return new OpenLayers.Layer.Image(name, url, extent, options, size);
	}
	
	/** 
	 * @description Makes a feature
	 * @param {string} Name of the feature
	 * @param {string} URL of the feature
	 * @param {float} starting x point
	 * @param {float} starting y point
	 * @param {float} width
	 * @param {float} height
	 * @returns {OpenLayers.Feature.Vector} The Feature
	 */
	
	ImageMap.MakeFeature = function (name, url, lon, lat, w, h) {
	
	    var feature = new OpenLayers.Feature.Vector(new OpenLayers.Geometry.Point(lon, lat), {
	        externalGraphic: url,
	        graphicWidth: w,
	        graphicHeight: h,
	        graphicYOffset: 0,
	        graphicXOffset: 0,
	        pointRadius: 2,
	        visible: true
	    });
	    feature.id = name;
	    feature.name = name;
	    feature.attributes.render = "drawAlways";
	    feature.w = w;
	    feature.width = w;
	    feature.h = h;
	    feature.height = h;
	    feature.x = lon;
	    feature.y = lat;
	    feature.externalGraphic = url;
	    feature.attributes.graphicZIndex = ImageMap.featureZIndex++;
	    feature.type = "Feature";
	    feature.points = new Array();
	    return feature;
	}
	
	/** 
	 * @description Makes a feature
	 * @param {string} Name of the feature
	 * @param {string} URL of the feature
	 * @param {OpenLayers.Bounds} bounds of the feature
	 * @returns {OpenLayers.Feature.Vector} The Feature
	 */
	
	ImageMap.MakeFeature2 = function (name, url, extent) {
	    var w = Math.abs(extent.left - extent.right);
	    var h = Math.abs(extent.top - extent.bottom);
	    return ImageMap.MakeFeature(name, url, extent.left, extent.top, w, h);
	}
	
	/**
	     * @description Makes a new layer.
	     * @param {string} Name of the layer 
	     * @param {OpenLayers.Bounds} [bounds] Bounds of the layer 
	     * @param {OpenLayers.StyleMap} [stylemap] stylemap for the layer
	     * @param  {Object} [Options]
	
	     */
	
	ImageMap.MakeLayer = function (name, extent, smap, options) {
	    if (smap == undefined || smap == null) smap = oStyleMap;
	
	    var layer = new OpenLayers.Layer.Vector(name, merge_options({
	        styleMap: smap,
	        renderers: renderer,
	        rendererOptions: {
	            transitionEffect: 'resize',
	            displayOutsideMaxExtent: true,
	            zIndexing: true
	        },
	
	        transitionEffect: 'resize',
	        displayOutsideMaxExtent: true,
	        zIndexing: true
	    }, options));
	
	    return layer;
	}
	
	/** 
	 * @description Makes a physical data point
	 * @param {string} Name of the feature
	 * @param {float} starting x point
	 * @param {float} starting y point
	 * @param {Object} data
	 * @param {OpenLayers.Layer} Layer to add the point to
	 * @returns {OpenLayers.Feature.Vector} The Feature
	 */
	
	ImageMap.MakeDataPoint = function (name, x, y, data, layer, marker, size) {
	    if (layer == undefined) layer = "Vector Layer";
	    var d = (data.data || data);
	    var w;
	    if (ImageMap.map.map.calculateBounds())
	        w = ImageMap.map.map.calculateBounds().getWidth();
	    else w = ImageMap.map.scale;

	    if (!size || size == "medium") w /= 25
	    else if (size == "small") w /= 35
	    else if (size == "large") w /= 18
	    else w *= size;
	
	    //if (marker) marker = marker.replace("img/","");
	
	    if (!marker || marker == "diamond") marker = 'img/diamond.png'
	    else if (marker == "circle") marker = 'img/circle.png'
	    else if (marker == "square") marker = 'img/square.png'
	
	    var feature = new OpenLayers.Feature.Vector(new OpenLayers.Geometry.Point(x - w / 2, y + w / 2), {
	        externalGraphic: marker,
	        graphicXOffset: 0,
	        graphicYOffset: 0,
	        graphicHeight: w,
	        graphicWidth: w,
	        'data': d,
	        zIndex: 10000,
	        graphicZIndex: 10000,
	        opacity: 0.75,
	        visible: true
	    });
	    feature.name = name;
	    feature.mp_id = data.id;
	    feature.data_type = data.type;
	    feature.id = name + createUUID();
	    feature.data = data;
	
	    if (!feature.data.pointnumber) {
	        feature.data.pointnumber = feature.data[0];

	    }
	
	    feature.type = "Data Point";
	    feature.shape = marker;
	
	    feature.size = w;
	    return feature;
	}
	
	ImageMap.MakeDataPointFromFeature = function (name, data, feature) {
	    var layer = feature.layer;
	    var f = new OpenLayers.Feature.Vector(new OpenLayers.Geometry.Point(feature.geometry.x, feature.geometry.y), {
	        'data': data
	    });
	
	    f.id = name;
	    return f;
	}
	
	ImageMap.MakeBoundsFromWH = function (w, h) {
	    return new OpenLayers.Bounds(-w / 2, -h / 2, w / 2, h / 2);
	}
	
	ImageMap.CurrentDBOffsetIndex = 0;
	
	ImageMap.Undo = function () {
	    ImageMap.undid = true;
	    var db = openDatabase('Map', '1.0', 'Map', 100 * 1024 * 1024);
	    db.transaction(function (tx) {

	        tx.executeSql('SELECT json FROM save WHERE id = ?', [ImageMap.Saves - ImageMap.CurrentDBOffsetIndex - 1],
	            function (tx, results) {
	                if (results.rows.length < 1) return;
	                delete map;
	                document.getElementById("map").innerHTML = "";
	                if (document.getElementById("layerswitcher")) {
	                    document.getElementById("layerswitcher").innerHTML = "";
	                    document.getElementById("scaleline-id").innerHTML = "";
	                }

	                ImageMap.NoSave = true;
	                map = ImageMap.load('map', results.rows.item(0).json);
	
	                ImageMap.CurrentDBOffsetIndex++;
	            }, function (tx) {

	            });
	
	    });
	}
	
	ImageMap.Redo = function () {
	    ImageMap.redid = true;
	
	    var db = openDatabase('Map', '1.0', 'Map', 100 * 1024 * 1024);
	    db.transaction(function (tx) {
	        ImageMap.CurrentDBOffsetIndex--;
	        tx.executeSql('SELECT json FROM save WHERE id = ?', [ImageMap.Saves - ImageMap.CurrentDBOffsetIndex],
	            function (tx, results) {
	                if (results.rows.length < 1) return;
	                delete map;
	                document.getElementById("map").innerHTML = "";
	                if (document.getElementById("layerswitcher")) {
	                    document.getElementById("layerswitcher").innerHTML = "";
	                    document.getElementById("scaleline-id").innerHTML = "";
	                }

	                ImageMap.NoSave = true;
	                map = ImageMap.load('map', results.rows.item(0).json);
	
	            }, function (tx) {


	            });
	
	    });
	}
	
	/** 
	 * @private @description Adds a move/resize/etc control to a layer
	 * @param {OpenLayers.Layer} Layer to add the control to
	 * @returns {OpenLayers.Control.ModifyFeature} The control
	 */
	
	ImageMap.MakeModifyFeatureControl = function (layer) {
	    return new OpenLayers.Control.ModifyFeature(
	        layer, {
	            deferDelete: false,
	            standalone: true,
	            eventListeners: {
	                'beforefeaturedeleted': reportEvent,
	                'featuredeleted': reportEvent
	            },
	            tools: [{ // custom tools  
	                // to rotate the "angle" attribute of a ponit by steps of 15 degrees
	                geometryTypes: ['OpenLayers.Geometry.Point',
	                    'OpenLayers.Geometry.MultiPoint'
	                ],
	                dragAction: function (feature, initialAtt, escale, rotation) {
	                    var angle = ((initialAtt.angle || 0) - rotation) % 360;
	                    // force steps of 15 degrres
	                    angle = Math.floor(angle / 15) * 15;
	                    feature.attributes.angle = angle;
	                },
	                style: OpenLayers.Control.ModifyFeature_styles.rotate
	            }, {
	                // to resize the pointRadius.
	                geometryTypes: ['OpenLayers.Geometry.Point',
	                    'OpenLayers.Geometry.MultiPoint'
	                ],
	                dragAction: function (feature, initialAtt, escale, rotation) {
	                    var radius = (initialAtt.radius || 6) * escale;
	                    feature.attributes.radius = Math.max(6, radius);
	                },
	                style: OpenLayers.Control.ModifyFeature_styles.resize
	            }, {
	                // to close a lineString as a ring
	                geometryTypes: ['OpenLayers.Geometry.LineString'],
	                pressingAction: function (feature) {
	                    var geometry = feature.geometry;
	                    geometry.addComponent(geometry.components[0].clone());
	                },
	                style: {
	                    label: 'ring',
	                    title: 'press to close as a ring',
	                    cursor: "pointer",
	                    fontSize: '8px',
	                    fontColor: '#222',
	                    pointRadius: 10,
	                    fillColor: '#cccccc',
	                    strokeColor: '#444444'
	                }
	            }]
	        }
	    );
	}
	
	ImageMap.Templates = new Object();
	ImageMap.Templates.Feature = new Object();
	ImageMap.Templates.Feature.Popup = function (feat) {
	
	    var s = "<div id='datapopupform_div'><form id='datapopupform' name='datapopupform'><span>Name:</span> <input name='fname' value='" + (feat.data
	        .pointnumber || feat.id) + "' /><br />";
	    s += "<span>Scale:</span> <input name='fscale' value='" + feat.attributes.graphicWidth.toFixed(2) + "' /><br />";
	    if (feat.type != "Data Point")
	        s += "<span>Opacity:</span> <input name='fopacity' value='" + feat.attributes.opacity + "' /><br />";
	
	    s += "<span>zIndex:</span> <input name='fzindex' value='" + feat.attributes.graphicZIndex + "' /><br />";
	    if (feat.type == "Data Point") {
	        for (var i in feat.data) {
	            s += i + " <input name=\"dp_" + i + "\" value=\"" + feat.data[i] + "\" /><br />";
	        }
	    }
	    s += "<input type=button value='Modify' onclick='javascript:ImageMap.map.updateFeature(\"" + feat.id + "\");' />";
	    s += "<input type=button value='Delete' onclick='javascript:ImageMap.map.removeFeature(\"" + feat.id + "\"," + ((
	        feat.type == "Data Point") ? "true" : "false") + ");' /></form></div>";
	    return s;
	
	}
	
	ImageMap.Data = new Array();
	ImageMap.Data.bank = new Array();
	ImageMap.Data.addDataToDataBank = function (data) {
	    for (var d in data) {
	        ImgeMap.Data.bank.push(data[d])
	    }
	}
	
	ImageMap.Data.queue = new Array();
	
	ImageMap.Data.unQueue = function (r) {
	    var row = r.parentNode.parentNode;
	    row.parentNode.removeChild(row);
	    document.getElementById('points').appendChild(row);

	    r.innerHTML = "Queue Data";
	    r.title = "Queue Data Point in Order for Adding to Map";
	    r.onclick = function () {
	        ImageMap.Data.queuePoint(this.id);
	    }
	    r.style.color = "black";
	    r.style.textDecoration = "underline";

	
	    var i = ImageMap.Data.queue.indexOf(row);
	    ImageMap.Data.queue.splice(i, 1);
	
	    if (ImageMap.Data.queue.length == 0) {

	        ImageMap.map.data_button.deactivate();
	    }
	
	}
	ImageMap.Data.queuePoint = function (row, indiv) {
	    var sel = $(".selected")
	    /*
					if (sel.length >= 1 && !indiv){
						for (var s = 0; s < sel.length; s++){
							var a = sel[s].cells[sel[s].cells.length - 1].childNodes[0]
							if (a == "" || !a.id || !a) continue;
							ImageMap.Data.queuePoint(a.id,true);
						}
					}		
	*/
	
	    var points = document.getElementById("points");
	    var selPoints = document.getElementById("queue");

	    var r = document.getElementById(row).parentNode.parentNode;
	
	    r.parentNode.removeChild(r);
	    r.className = "";
	    selPoints.appendChild(r);
	    r.cells[r.cells.length - 1].innerHTML = '<a id="' + row +
	        '"  style="color:blue; text-decoration:underline"  onclick="javascript:ImageMap.Data.unQueue(this);">x</a>';
	
	    for (var i in ImageMap.Data.bank) {
	        if (parseInt(ImageMap.Data.bank[i].pointnumber) == parseInt(r.cells[0].innerHTML)) {
	            r.data = ImageMap.Data.bank[i];
	
	        }
	    }
	
	    if (data_button.active) {
	        data_button.deactivate();
	        data_button.activate();
	    }
	
	    ImageMap.Data.queue.push(r);
	
	}
	
	ImageMap.Templates.Feature.DataPopup = function (feat, lonlat) {
	
	    //var s = "Data: <textarea name='fdatap' id='fdatap'></textarea><br />";
	    var s = ""
	    if (feat.db_data) {
	        s += "Data: <select id='datums' name='datums'>";
	        var d = feat.db_data;
	        for (var i in d) {
	            var skip = false;
	            for (var p in feat.points) {
	                if (feat.points[p].data.id == d[i].id) {
	                    skip = true;
	                    continue;
	                }
	            }
	            s += "<option value=" + d[i].id + (skip ? "disabled" : "") + ">" + d[i].pointnumber + "</option>";
	        }
	        s += "<input type=button value='Add' onclick='javascript:ImageMap.map.addDataToFeature(\"" + feat.id +
	            "\", readSelected(document.getElementById(\"datums\").selectedIndex, \"" + feat.id + "\"),undefined,1," +
	            lonlat.lon + "," + lonlat.lat + ");' />";
	
	        s += "<br />";
	    }
	    if (ImageMap.Data.bank) {
	        s += "Data Bank: <select id='datums_b' name='datums_b'>";
	        d = ImageMap.Data.bank;
	        for (var i in d) {
	            var skip = false;
	            for (var p in feat.points) {
	                if (feat.points[p].data.pointnumber == d[i].pointnumber) {
	                    skip = true;
	                    break;
	                }
	            }
	            s += "<option value=\"" + d[i].pointnumber + "\" " + (skip ? "disabled" : "") + " >" + d[i].pointnumber +
	                "</option>";
	        }
	        s += "<input type=button value='Add' onclick='javascript:ImageMap.map.addDataToFeature(\"" + feat.id +
	            "\", readSelected(document.getElementById(\"datums_b\").selectedIndex, \"" + feat.id + "\",1),\"" + "2" +
	            "\",1," + lonlat.lon + "," + lonlat.lat + ");' />";
	
	    }
	
	    return s;
	
	}
	var headz = 0;
	ImageMap.Data.readCSV = function (data) {

	    var obs = $.csv.toObjects(data);
	    var points = document.getElementById("points");
	    var pointsTable = document.getElementById("pointTable");
	    if (1) {
	        var hr;
	        if (ImageMap.Data.bank.length == 0 && ImageMap.Data.queue.length == 0 && pointTable.tHead.rows.length == 0) {
	            var h = pointsTable.createTHead();
	            hr = h.insertRow(headz++);
	
	        } else {
	            hr = points.insertRow(pointsTable.rows.length - 1);
	            hr.className = "fauxHeader";
	
	        }
	        j = 0;
	        var f = false;
	        for (var c in obs[0]) {
	            if (c == "" || !c || c == "\n") continue;
	            var cell = hr.insertCell(j++)
	            cell.innerHTML = c;
	            f = true;
	        }
	        if (f) {
	            var cell = hr.insertCell(j++)
	            cell.innerHTML = "<a href='javascript:ImageMap.Data.queueAll();'>Queue All</a>";
	        }
	    }
	
	    //$(pointsTable).after(h);
	    if (points.rows.length >= 1) {
	        var p = document.createElement('tbody');
	        p.className = "pointss connectedSortable";
	        $(points).after(p);
	        points = p;
	    }
	
	    for (var ob in obs) {
	        var obj = obs[ob];
	        var first;
	        for (first in obj) {
	            break;
	        }
	        if (!first || !obj[first]) continue;
	        var row = points.insertRow(0);
	        row.id = JSON.stringify(obs[ob]).hashCode();
	
	        var i = 0;
	        for (var c in obj) {
	            if (c == "" || !c || c == "\n") continue;
	            var cell = row.insertCell(i++);
	            cell.innerHTML = obj[c]
	        }
	        var cell = row.insertCell(i);
	        var a = document.createElement('a');
	        a.id = createUUID();
	        a.appendChild(document.createTextNode("Queue Data"));
	        a.title = "Queue Data Point in Order for Adding to Map";
	        a.href = "javascript:ImageMap.Data.queuePoint(\"" + a.id + "\")";
	        cell.appendChild(a);
	        if (!obj.pointnumber) {
	            var first;
	            for (first in obj) break;
	            obj.pointnumber = obj[first];
	        }
	
	        ImageMap.Data.bank.push(obj);
	    }
	    /*
				    $( ".pointss" ).sortable({
				      connectWith: ".connectedSortable",
				      helper: fixHelper,
				      start: function(e, info) {
				      	if (info.item.siblings(".selected") != info.item){
					        info.item.siblings(".selected").appendTo(info.item);
					        $(".selected").css( "background-color", "white" );
					    }
				        
				      },
				      stop: function(e, info) {
				        info.item.after(info.item.find("tr"))
					    $(".selected").css( "background-color", "" );
					    $(".selected").toggleClass("selected")
				
				      }
				    }).disableSelection(); */
	
	    localStorage.data = JSON.stringify(ImageMap.Data.bank);
	    if ($("#pointTable")[0].className != "dataTable")
	        $("#pointTable").dataTable({
	            "bPaginate": false,
	        });
	
	}
	
	ImageMap.Data.queueAll = function (table) {
	    if (!table) table = document.getElementById('pointTable');

	    var l = table.tBodies[0].rows.length;
	    for (var i = 0; i < l; i++) {
	        ImageMap.Data.queuePoint(table.tBodies[0].rows[0].children[table.tBodies[0].rows[0].children.length - 1].children[
	            0].id, true);
	    }
	}
	
	ImageMap.Templates.Feature.MovePopup = function (feat) {
	
	    //var s = "Data: <textarea name='fdatap' id='fdatap'></textarea><br />";
	    var s = "Move To Layer: <select id='m_layers' name='m_layers' onchange='name_for_new_layer(this)'>";
	    for (var i = 2; i < ImageMap.map.layers.length; i++) {
	        var l = ImageMap.map.layers[i];
	        if (l.id == feat.layer.id) continue
	        if (l.id == "Resizable layer" || l.name == "Resizable layer") continue;
	        s += "<option value=\"" + l.id + "\">" + l.name + "</option>";
	    }
	    if (ImageMap.map.layers.length == 3) {
	        s += "<option value='New Layer'>Pick a Layer</option>"
	    }
	    s += "<option value='New Layer'>New Layer</option>";
	
	    s += "</select><br /><input type=button value='Move' onclick='javascript: ImageMap.map.moveFeatureToLayer(\"" +
	        feat.id +
	        "\", document.getElementById(\"m_layers\").options[document.getElementById(\"m_layers\").selectedIndex ].value); document.getElementById(\"m_layers\").parentNode.removeChild(document.getElementById(\"m_layers\"))' />";
	    return s;
	
	}
	
	ImageMap.PreLoad = function (src) {
	    var im = new Image();
	    im.src = src;
	    return im;
	}
	
	ImageMap.downloadZip = function (name, content) {
	    var zip = new JSZip();
	
	    zip.file(name, content);
	    var content = zip.generate();
	    location.href = "data:application/zip;base64," + content;
	
	}
	
	/** 
			* @namespace Examples
			* @description <code>
			/<br /><br /> 
			<br /> @description <code>
			<br /> map = new ImageMap('map', 'Base Layer', 'img/garnet1.jpg', 500);<br />
	    	<br /> //  map = new ImageMap({div:'map', name:'Base Layer', url: 'img/garnet1.jpg', scale: 500});
	    	<br /> var feature = ImageMap.MakeFeature('Little Feature', 'img/garnet2.jpg',10,10,200,300);
	    	<br /> var layer = ImageMap.MakeLayer("Little Feature Holder");
	    	
	    	<br /> map.addFeatureToLayer(feature,layer);
	    	<br /> map.addLayer(layer);
	    	
	    	<br /> var layer2 = ImageMap.MakeLayer("Other Layer");
	    	<br /> var feature2 = ImageMap.MakeFeature('Little Feature Recursive', 'img/garnet1.jpg',-10,-10,100,100);
	    	<br /> var feature3 = ImageMap.MakeFeature('Little Feature 3', 'img/widelong.jpg',200,200,50,50);
	    	<br /> var feature4 = ImageMap.MakeFeature('Jerry', 'img/widelong.jpg',200,200,50,50);
	    	
	    	<br /> map.addFeatureToLayer([feature2,feature3], layer2);
	    	<br /> map.addLayer(layer2);
			<br /> layer2.lockLayer();
			<br /> layer2.setIndex(1)
			<br /> layer.setIndex(2);
			
			<br /> layer.addMetaData("This is a layer that holds things")
	
			
			<br /> map.moveFeature(feature, 40,-10);
			<br /> map.removeFeature(feature3); // Invalidates feature
			<br /> map.addFeatureToLayer(feature4, layer2)
			<br /> feature4.addMetaData("Uncle Jerry");
			<br /> map.save(); </code>
			*/
	
	function Examples() {}
	
	OpenLayers.Util.extend(ImageMap, {
	    zIndex: 2,
	    featureZIndex: 2
	})