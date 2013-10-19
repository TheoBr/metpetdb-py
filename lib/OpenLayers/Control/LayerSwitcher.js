/* Copyright (c) 2006-2008 MetaCarta, Inc., published under the Clear BSD
 * license.  See http://svn.openlayers.org/trunk/openlayers/license.txt for the
 * full text of the license. */

/** 
 * @requires OpenLayers/Control.js
 */

/**
 * Class: OpenLayers.Control.LayerSwitcher
 *
 * Inherits from:
 *  - <OpenLayers.Control>
 */
OpenLayers.Control.LayerSwitcher = 
  OpenLayers.Class(OpenLayers.Control, {
	
    /**  
     * Property: activeColor
     * {String}
     */
    activeColor: "white",
    removeFeature: function(f){
    	console.log(f);
	    var c = document.getElementById("div_" + htmlEncode(f));
	    $(c).empty();
	    console.log(c.parentNode);
	    c.parentNode.parentNode.removeChild(c.parentNode);
    },
    
    /**  
     * Property: layerStates 
     * {Array(Object)} Basically a copy of the "state" of the map's layers 
     *     the last time the control was drawn. We have this in order to avoid
     *     unnecessarily redrawing the control.
     */
    layerStates: null,    
        
    /** 
     * Property: useLegendGraphics
     */
    useLegendGraphics: false,    

  // DOM Elements
  
    /**
     * Property: layersDiv
     * {DOMElement} 
     */
    layersDiv: null,
    
    /** 
     * Property: baseLayersDiv
     * {DOMElement}
     */
    baseLayersDiv: null,

    /** 
     * Property: baseLayers
     * {Array(<OpenLayers.Layer>)}
     */
    baseLayers: null,    
    
    /** 
     * Property: dataLayersDiv
     * {DOMElement} 
     */
    dataLayersDiv: null,

    /** 
     * Property: dataLayers
     * {Array(<OpenLayers.Layer>)} 
     */
    dataLayers: null,

    /** 
     * Property: activeLayer
     */
    activeLayer: null,
    
    /** 
     * Property: minimizeDiv
     * {DOMElement} 
     */
    minimizeDiv: null,

    /** 
     * Property: maximizeDiv
     * {DOMElement} 
     */
    maximizeDiv: null,
    
    /**
     * APIProperty: ascending
     * {Boolean} 
     */
    ascending: true,
 
    /**
     * Constructor: OpenLayers.Control.LayerSwitcher
     * 
     * Parameters:
     * options - {Object}
     */
    initialize: function(options) {
        OpenLayers.Control.prototype.initialize.apply(this, arguments);
        this.layerStates = [];     
    },

    /**
     * APIMethod: destroy 
     */    
    destroy: function() {
        
        OpenLayers.Event.stopObservingElement(this.div);

        OpenLayers.Event.stopObservingElement(this.minimizeDiv);
        OpenLayers.Event.stopObservingElement(this.maximizeDiv);

        //clear out layers info and unregister their events 
        this.clearLayersArray("base");
        this.clearLayersArray("data");
        
        this.map.events.un({
            "addlayer": this.redraw,
            "changelayer": this.redraw,
            "removelayer": this.redraw,
            "changebaselayer": this.redraw,
            scope: this
        });

        OpenLayers.Control.prototype.destroy.apply(this, arguments);
    },

    /** 
     * Method: setMap
     *
     * Properties:
     * map - {<OpenLayers.Map>} 
     */
    setMap: function(map) {
        OpenLayers.Control.prototype.setMap.apply(this, arguments);
        
        this.map.events.on({
            "addlayer": this.redraw,
            "changelayer": this.redraw,
            "removelayer": this.redraw,
            "changebaselayer": this.redraw,
            scope: this
        });
    },

    /**
     * Method: draw
     *
     * Returns:
     * {DOMElement} A reference to the DIV DOMElement containing the 
     *     switcher tabs.
     */  
    draw: function() {
        OpenLayers.Control.prototype.draw.apply(this);

        // create layout divs
        this.loadContents();

        // set mode to minimize
        if(!this.outsideViewport) {
            this.minimizeControl();
        }

        // populate div with current info
        this.redraw();

        return this.div;       
    },

    /** 
     * Method: clearLayersArray
     * User specifies either "base" or "data". we then clear all the
     *     corresponding listeners, the div, and reinitialize a new array.
     * 
     * Parameters:
     * layersType - {String}  
     */
    clearLayersArray: function(layersType) {
        var layers = this[layersType + "Layers"];
        if (layers) {
            for(var i=0, len=layers.length; i<len ; i++) {
                var layer = layers[i];
                OpenLayers.Event.stopObservingElement(layer.inputElem);
                OpenLayers.Event.stopObservingElement(layer.labelSpan);
            }
        }
        this[layersType + "LayersDiv"].innerHTML = "";
        this[layersType + "Layers"] = [];
    },


    /**
     * Method: checkRedraw
     * Checks if the layer state has changed since the last redraw() call.
     * 
     * Returns:
     * {Boolean} The layer state changed since the last redraw() call. 
     */
    checkRedraw: function() {
        var redraw = false;
        if ( !this.layerStates.length ||
             (this.map.layers.length != this.layerStates.length) ) {
            redraw = true;
        } else {
            for (var i=0, len=this.layerStates.length; i<len; i++) {
                var layerState = this.layerStates[i];
                var layer = this.map.layers[i];
                if ( (layerState.name != layer.name) || 
                     (layerState.inRange != layer.inRange) || 
                     (layerState.id != layer.id) || 
                     (layerState.visibility != layer.visibility) ) {
                    redraw = true;
                    break;
                }    
            }
        }    
        return redraw;
    },
    
    /** 
     * Method: redraw
     * Goes through and takes the current state of the Map and rebuilds the
     *     control to display that state. Groups base layers into a 
     *     radio-button group and lists each data layer with a checkbox.
     *
     * Returns: 
     * {DOMElement} A reference to the DIV DOMElement containing the control
     */  
    redraw: function(updateFeatures) { 
        // if the state hasn't changed since last redraw, no need 
        // to do anything. Just return the existing div.
        if (!this.checkRedraw() && !updateFeatures) {        
            return this.div;
        } 

        //clear out previous layers 
        this.clearLayersArray("base");
        this.clearLayersArray("data");
       
        var containsOverlays = false;
        var containsBaseLayers = false;
        
        // Save state -- for checking layer if the map state changed.
        // We save this before redrawing, because in the process of redrawing
        // we will trigger more visibility changes, and we want to not redraw
        // and enter an infinite loop.
        var len = this.map.layers.length;
        this.layerStates = new Array(len);
        for (var i=0; i <len; i++) {
            var layer = this.map.layers[i];            
            this.layerStates[i] = {
                'name': layer.name, 
                'visibility': layer.visibility,
                'inRange': layer.inRange,
                'id': layer.id                
            };
        }    

        var layers = this.map.layers.slice();
        if (!this.ascending) { layers.reverse(); }
        for(var i=0, len=layers.length; i<len; i++) {
            var layer = layers[i];
            var baseLayer = layer.isBaseLayer;
            
            if (layer.displayInLayerSwitcher) {

                if (baseLayer) {
                    containsBaseLayers = true;
                } else {
                    containsOverlays = true;
                }               

                // only check a baselayer if it is *the* baselayer, check data
                // layers if they are visible
                var checked = (baseLayer) ? (layer == this.map.baseLayer)
                                          : layer.getVisibility();   			
    			
    			var layerWrapper = document.createElement("div");
    			layerWrapper.id = "layer_" + layer.id;    			
    			layerWrapper.style.overflowY = "scroll";
                // create input element
                var inputElem = document.createElement("input");
                inputElem.id = this.id + "_input_" + layer.name;
                inputElem.name = (baseLayer) ? "baseLayers" : layer.name;
                inputElem.type = (baseLayer) ? "radio" : "checkbox";
                inputElem.value = layer.name;
                inputElem.checked = checked;
                inputElem.defaultChecked = checked;

                if (!baseLayer && !layer.inRange) {
                    inputElem.disabled = true;
                }

                // create the label span
                var labelSpan = document.createElement("span");
                if (!baseLayer && !layer.inRange) {
                    labelSpan.style.color = "gray";
                }
                
                if(layer.queryable) {
                	labelSpan.style.cursor = "pointer";
                }
                labelSpan.innerHTML = layer.name;
                labelSpan.layer = layer;
                labelSpan.onclick = function() { 
	                var newName = prompt("Change Layer Name", this.innerHTML);
	                this.layer.name = newName;
	                this.innerHTML = this.layer.name;
	                
                }
                labelSpan.style.display = "block";
                labelSpan.style.width = "210px";
                labelSpan.style.color = "blue";
                labelSpan.style.cursor = "pointer";
                labelSpan.style.padding = "0px 6px 2px 4px";
                labelSpan.style.verticalAlign = (baseLayer) ? "bottom" : "baseline";     

				
				var abstractSpan = document.createElement("span");
                abstractSpan.id = "abstract_" + layer.id;
                abstractSpan.style.overflowY = 'scroll';
				//abstractSpan.innerHTML = layer.description;
				var ul;
				if (layer.features){
					layer.features.sort( function(b,a){  return a.attributes.graphicZIndex - b.attributes.graphicZIndex; } );
					ul = document.createElement("ul");
					ul.className = 'sortable';
					abstractSpan.appendChild(ul);
				}
				for (var f in layer.features){
					var s = "<li class='ui-state-default'><div class='ls_feature' style='inline-block' id='div_" + htmlEncode(layer.features[f].id) + "'><span style='display:inline-block !important; height: 16px; width:16px;' class='ui-icon ui-icon-arrowthick-2-n-s'></span>";
					s += "<input type='checkbox' id='" + htmlEncode(layer.features[f].id) +  "' ";
					if (layer.features[f].isVisible()) s+= " checked=checked ";
					s +=  " onclick='javascript:ImageMap.map.toggleVisibility(\"" + layer.features[f].id + "\"); ' />";
					var n
					if (layer.features[f].name) n = layer.features[f].name.trunc(10);
					else n = layer.features[f].id.trunc(10);
					
					n =  (layer.features[f].data && layer.features[f].data.pointnumber) || n;
					
					s += "<a href='#' onclick='javascript:ImageMap.map.selectFeature(\"" + layer.features[f].id + "\")'><img width='16'  height='16' src=\"" + layer.features[f].attributes.externalGraphic + "\" class='lsthumb' />" +  n + "<input value='delete' style='display:none' type='button' onclick='javascript:ImageMap.map.removeFeature(\"" + layer.features[f].id + "\")' /></a>";
					if (layer.features[f].metaData)
						s += "<input value='data' style='display:none;' type='button' onclick='javascript:alert(\"" + layer.features[f].metaData + "\");' />";
						
						s += "<input value='properties' style='padding-left:10px;' type='image' src='img/queryable.png'  onclick='javascript:ImageMap.map.getFeature(\"" + layer.features[f].id + "\").displayPopup()' />";
						
						if (layer.features[f].type != "Data Point" && layer.features[f].db_data){
						s += "<input value='addData' type='image' style='padding-left:10px;' src='img/metadata.png'  onclick='javascript:ImageMap.map.getFeature(\"" + layer.features[f].id + "\").addDataPopup()' />";
}
						if (layer.features[f].type != "Data Point"){
						
						s += "<input value='moveTo'   type='image' style='width:12px;height:12px;padding-left:10px;' src='img/move.png' onclick='javascript:ImageMap.map.getFeature(\"" + layer.features[f].id + "\").addMovePopup()' />";
						
						}
						var srcc = (layer.features[f].locked) ? "lock_activated.png" : "lock.png" ;
						s += "<input value='lockFeature' type='image' style='width:12px;height:12px;padding-left:10px;' src='img/" + srcc + "' onclick='javascript:ImageMap.map.layerSwitcher.lockFeature(\"" + layer.features[f].id  + "\" , this);' />";

						
						if (layer.features[f].points && layer.features[f].points.length != 0){
						s += "<input value='downloadData'   type='image' style='width:12px;height:12px;padding-left:10px;' src='img/download.png' onclick='javascript:ImageMap.downloadZip(\"" + layer.features[f].id + "_data.csv" + "\" , ImageMap.map.getFeature(\"" + layer.features[f].id + "\").dataToCSV())' />";
						

						
							var dataUrlLink = document.createElement("a");
						    dataUrlLink.style.cursor = "pointer";
						    dataUrlLink.style.display = "inline-block";
						    dataUrlLink.alt = "download";
		                    dataUrlLink.title = "download"; 
						    dataUrlLink.innerHTML = '<img src="' + OpenLayers.Util.getImagesLocation() + 'download.png" style="border: none;" />';
		                    
		                    var dataUrlLinkContext = {
		                        'feature' : layer.features[f]
		                    };
		                    
		                    OpenLayers.Event.observe(dataUrlLink, "click", 
		                        OpenLayers.Function.bindAsEventListener(this.onDownloadPointsClick, dataUrlLinkContext)
		                    );
		
						}
						

					ul.innerHTML += s + "</div></li><br />"
					
				}
				/*
if (ul){
					ImageMap.adjustment = null;
					$(function  () {
					  $(ul).sortable({

				});
			})
			}
*/
			
				
				
				abstractSpan.style.display = "block";
				abstractSpan.style.fontWeight = "normal";
				abstractSpan.style.padding = "0px 6px 2px 5px";
				abstractSpan.style.fontSize = "11px";
				
				
				
				var abstractToolbarSpan = document.createElement("span");
				abstractToolbarSpan.style.display = "block";
                    
                abstractSpan.appendChild(abstractToolbarSpan);


				if(layer.metaDataasdfasdf) {
				    var dataUrlLink = document.createElement("a");
				    dataUrlLink.style.cursor = "pointer";
				    dataUrlLink.style.display = "inline-block";
				    dataUrlLink.alt = "download";
                    dataUrlLink.title = "download"; 
				    dataUrlLink.innerHTML = '<img src="' + OpenLayers.Util.getImagesLocation() + 'download.png" style="border: none;" />';
                    
                    var dataUrlLinkContext = {
                        'url': 'javascript:alert("' + layer.metaData + '")'
                    };
                    
                    OpenLayers.Event.observe(dataUrlLink, "click", 
                        OpenLayers.Function.bindAsEventListener(this.onDataUrlClick, dataUrlLinkContext)
                    );
				}
				
				// i added this delete after
				layer.metadataURL = "things";
				
				if(layer.metaData) {
				    var metadataUrlLink = document.createElement("a");
				    metadataUrlLink.style.cursor = "pointer";
				    metadataUrlLink.style.display = "inline-block";
				    metadataUrlLink.style.margin = "5px 0px 0px 0px";
				    metadataUrlLink.alt = "metadata";
                    metadataUrlLink.title = "metadata"; 
				    metadataUrlLink.innerHTML = '<img src="' + OpenLayers.Util.getImagesLocation() + 'metadata.png" style="border: none;" />';
                    
                    var metadataUrlLinkContext = {
                        'url': layer.metadataURL,
                        metaData : layer.metaData
                    };
                    
                    OpenLayers.Event.observe(metadataUrlLink, "click", 
                        OpenLayers.Function.bindAsEventListener(this.onMetadataUrlClick, metadataUrlLinkContext)
                    );
                
                    abstractToolbarSpan.appendChild(metadataUrlLink);
				}
               
                // create the title div
                var titleDiv = document.createElement("div");
                titleDiv.id = "title_" + layer.id;
                                
                if(this.activeLayer == layer.id)
                {
                    titleDiv.style.backgroundColor = "#999";
                    titleDiv.style.border = "solid 1px #999";
                }
                else
                {
                    titleDiv.style.backgroundColor = "#e1e1e1";
                    titleDiv.style.border = "solid 1px #e1e1e1";
                }
                
                titleDiv.style.width = "220px";
                titleDiv.style.padding = "2px";               	     
                titleDiv.style.position = "relative";
                
                // create the layer operation panel
                var buttonSpan = document.createElement("span");
                buttonSpan.style.padding = "3px 3px 3px 0";
                
                // remove control
                var removeButton = document.createElement("img");
                removeButton.src = OpenLayers.Util.getImagesLocation() + "del.png";
                removeButton.style.cursor = "pointer";
                removeButton.alt = "remove layer";
                removeButton.title = "remove layer";     
                                
                // layer order controls
                var upButton = document.createElement("img");
                upButton.src = OpenLayers.Util.getImagesLocation() + "up.png";
                upButton.style.cursor = "pointer";  
                upButton.alt = "move layer up";
                upButton.title = "move layer up";
                
                var downButton = document.createElement("img");
                downButton.src = OpenLayers.Util.getImagesLocation() + "down.png";
                downButton.style.cursor = "pointer";
                downButton.alt = "move layer down";
                downButton.title = "move layer down";
                
                // Lock Layer Controls
                var lockLayer = document.createElement("img");
                lockLayer.src =  OpenLayers.Util.getImagesLocation() + ( (layer.locked) 
        																	? "lock_activated" : 																								"lock"
        																	) + ".png";

                lockLayer.style.cursor = "pointer";
                lockLayer.alt = "Lock Layer";
                lockLayer.title = "Lock Layer";

                
                // opacity controls
                var opacityMinusButton = document.createElement("img");
                opacityMinusButton.src = OpenLayers.Util.getImagesLocation() + "minus.png";
                opacityMinusButton.style.cursor = "pointer";
                opacityMinusButton.alt = "decrease opacity";
                opacityMinusButton.title = "decrease opacity";
                                
                // set the default opacity
                layer.setOpacity(layer.opacity); 
                
                var opacitySpan = document.createElement("span");                
                opacitySpan.setAttribute("id", "opacityValue_" + layer.id);                
                opacitySpan.style.display = "inline-block";
                opacitySpan.style.width = "23px";        
                
                var opacityImg = document.createElement("img");
                opacityImg.setAttribute("id", "opacityImg_" + layer.id); 
                opacityImg.src = OpenLayers.Util.getImagesLocation() + "opacity.png";
                opacityImg.width = (layer.opacity != null) ? (layer.opacity * 23).toFixed(0) : "23";

                opacityImg.height = "12";
                opacityImg.alt = "opacity";
                opacityImg.title = "opacity";
                
                var opacityTextInput = document.createElement("input");                
                opacityTextInput.setAttribute("id", "opacity_" + layer.id); 
                opacityTextInput.setAttribute("type", "hidden");
                opacityTextInput.setAttribute("value", "1.0");
                
                var opacityPlusButton = document.createElement("img");
                opacityPlusButton.src = OpenLayers.Util.getImagesLocation() + "plus.png";
                opacityPlusButton.style.cursor = "pointer";
                opacityPlusButton.alt = "increase opacity";
                opacityPlusButton.title = "increase opacity";
				
				var abstractButton = document.createElement("img");
				abstractButton.setAttribute("id", "abstractButton_" + layer.id); 
                abstractButton.src = OpenLayers.Util.getImagesLocation() + "collapse.png";
                abstractButton.style.cursor = "pointer";
                abstractButton.style.position = "absolute";
                abstractButton.style.top = "0";
                abstractButton.style.right = "0";
                abstractButton.style.padding = "5px";   		

                
                
                var scaleButton = document.createElement("img");
                scaleButton.src = OpenLayers.Util.getImagesLocation() + "scale_height_1-128.png";
                scaleButton.width= "12";
                scaleButton.height = "12"
                scaleButton.style.cursor = "pointer";
                scaleButton.alt = "increase opacity";
                scaleButton.title = "increase opacity";
                
                var context = {
                    'layer': layer,
                    'inputElem': inputElem,
                    'titleDiv': titleDiv,
                    'layerSwitcher': this
                };
                
                var contextplus = function(k,v){
                	var a = context;
                	a[k] = v;
                	return a;
                }                   
                                              
                OpenLayers.Event.observe(inputElem, "mouseup", 
                    OpenLayers.Function.bindAsEventListener(this.onInputClick, context)
                );
                
                if(layer.queryable) {
                
                	var queryableButton = document.createElement("img");
               		queryableButton.src = OpenLayers.Util.getImagesLocation() + "queryable.png"; 
               		queryableButton.style.cursor = "pointer";
               		queryableButton.alt = "select for query";
                	queryableButton.title = "select for query";
                	
                	OpenLayers.Event.observe(labelSpan, "click", 
	                    OpenLayers.Function.bindAsEventListener(this.onTitleClick, context)
	                );
	                
					OpenLayers.Event.observe(queryableButton, "click", 
	                    OpenLayers.Function.bindAsEventListener(this.onTitleClick, context)
	                );
	            }
                
                OpenLayers.Event.observe(upButton, "click", 
                    OpenLayers.Function.bindAsEventListener(this.onUpClick, context)
                );
                
                OpenLayers.Event.observe(downButton, "click", 
                    OpenLayers.Function.bindAsEventListener(this.onDownClick, context)
                );
                
                OpenLayers.Event.observe(removeButton, "click", 
                    OpenLayers.Function.bindAsEventListener(this.onRemoveClick, context)
                );
                
                OpenLayers.Event.observe(lockLayer, "click", 
                    OpenLayers.Function.bindAsEventListener(this.lockLayer, contextplus("img",lockLayer))
                );
                
                var opacityMinusContext = {
                    'layer': layer,
                    'byOpacity': '-0.1',
                    'layerSwitcher': this
                };
                OpenLayers.Event.observe(opacityMinusButton, "click", 
                    OpenLayers.Function.bindAsEventListener(this.changeLayerOpacity, opacityMinusContext)
                );
               
                var opacityPlusContext = {
                    'layer': layer,
                    'byOpacity': '0.1',
                    'layerSwitcher': this
                };
                OpenLayers.Event.observe(opacityPlusButton, "click", 
                    OpenLayers.Function.bindAsEventListener(this.changeLayerOpacity, opacityPlusContext)
                );
				
				var abstractContext = {
                    'layer': layer,
                    'button' : abstractButton
                };
                
				OpenLayers.Event.observe(abstractButton, "mouseup", 
                    OpenLayers.Function.bindAsEventListener(this.toggleAbstract, abstractContext)
                );               
				var scaleContext = {
                    'layer': layer,
                    'button' : scaleButton
                };
				OpenLayers.Event.observe(scaleButton, "click", 
                    OpenLayers.Function.bindAsEventListener(this.changeScale, scaleContext)
                );               
                
                // create line break
                var br = document.createElement("br");
                
                var groupArray = (baseLayer) ? this.baseLayers
                                             : this.dataLayers;
                groupArray.push({
                    'layer': layer,
                    'inputElem': inputElem,
                    'titleDiv': titleDiv,
                    'labelSpan': labelSpan
                });
                                                     
                var groupDiv = (baseLayer) ? this.baseLayersDiv
                                           : this.dataLayersDiv;
                                           
                groupDiv.appendChild(layerWrapper);
                layerWrapper.appendChild(titleDiv);  
                titleDiv.appendChild(inputElem);
                titleDiv.appendChild(buttonSpan);				
                buttonSpan.appendChild(upButton);
                buttonSpan.appendChild(downButton);
                buttonSpan.appendChild(removeButton);
                buttonSpan.appendChild(lockLayer);
                buttonSpan.appendChild(opacityMinusButton);
                opacitySpan.appendChild(opacityImg);
                buttonSpan.appendChild(opacitySpan);
                buttonSpan.appendChild(opacityTextInput);
                buttonSpan.appendChild(opacityPlusButton);
                buttonSpan.appendChild(scaleButton);
                
				if(layer.description) {
					titleDiv.appendChild(abstractButton);
				}
                if(layer.queryable) {
                	buttonSpan.appendChild(queryableButton);
                }
                if(layer.dataURL) {
                    buttonSpan.appendChild(dataUrlLink);
                }
                
                titleDiv.appendChild(labelSpan); 
				titleDiv.appendChild(abstractSpan);
				
				if(this.useLegendGraphics && layer.params) {
                    var legendGraphicURL = layer.getFullRequestString({
                    REQUEST: "GetLegendGraphic",
                    LAYER: layer.params.LAYERS,
                    FORMAT: "image/png",
                    WIDTH: "150"});

                    var imgSpan = document.createElement('span');

                    imgSpan.innerHTML = "<img style=\"display:none\" src=\"" + legendGraphicURL + "\" onload=\"this.style.display = 'inline'\" alt=\"\" onerror=\"this.src='" + OpenLayers.Util.getImagesLocation() + "blank.gif" + "'\" />";
                    layerWrapper.appendChild(imgSpan);                          
                }                          
            }   
        }
		
		
		
		
        
        return this.div;        
            
    },   
    
    
    changeScale: function() {
	  var sca = prompt("Enter a new Scale");
	  this.layer.changeScale(sca);
	    
	    
    },
    
    
    /** 
     * Method:
     * A label has been clicked, check or uncheck its corresponding input
     * 
     * Parameters:
     * e - {Event} 
     *
     * Context:  
     *  - {DOMElement} inputElem
     *  - {<OpenLayers.Control.LayerSwitcher>} layerSwitcher
     *  - {<OpenLayers.Layer>} layer
     */

    onInputClick: function(e) {
    	ImageMap.map.selectControl.unselectAll();
        if (!this.inputElem.disabled) {
            if (this.inputElem.type == "radio") {
                this.inputElem.checked = true;
                this.layer.map.setBaseLayer(this.layer);
            } else {
                this.inputElem.checked = !this.inputElem.checked;
                this.layerSwitcher.updateMap();
            }
        }
        
        if (e != null) {
            OpenLayers.Event.stop(e);                                            
        }
    },    

    /**
     * Method: lockLayer
     * lock the layer... duh
     * 
     * Parameters: 
     * e - {Event} 
     */
    lockLayer: function(e,dontNotifyLayer)
    {
    	if (dontNotifyLayer == undefined)
        map.toggleLockLayer(this.layer,false);
        
        var l = (this.layer || e);
        
        this.img.src = OpenLayers.Util.getImagesLocation() + ( (l.locked) 
        																	? "lock_activated" : 																								"lock"
        																	) + ".png";
        														

    },

    lockFeature: function(f,img){
    	var f = map.getFeature(f);
    	
    	if (ImageMap.map.selectedFeatures[0] == f){
    		ImageMap.map.selectControl.unselect(f);
    	}
    	
    	if (f.locked == undefined) f.locked = false;
    	f.locked = !f.locked;
        img.src = OpenLayers.Util.getImagesLocation() + ( (f.locked) 
        																	? "lock_activated" : 																								"lock"
        																	) + ".png";
    },

    /**
     * Method: onRemoveClick
     * Remove the layer from the map
     * 
     * Parameters: 
     * e - {Event} 
     */
    onRemoveClick: function(e)
    {
    	
        map.removeLayer(this.layer);
        
        if (e != null) {
            OpenLayers.Event.stop(e);                                            
        } 
    },
    
    /**
     * Method: onDownClick
     * Set the layer position down one level
     * 
     * Parameters: 
     * e - {Event} 
     */
    onDownClick: function(e)
    {;
        map.map.raiseLayer(this.layer, -1);  
        
        if (e != null) {
            OpenLayers.Event.stop(e);                                            
        }
    },
    
    /**
     * Method: onUpClick
     * Set the layer position up one level
     * 
     * Parameters: 
     * e - {Event} 
     */
    onUpClick: function(e)
    {
    	
        map.map.raiseLayer(this.layer, 1);  
        
        if (e != null) {
            OpenLayers.Event.stop(e);                                            
        }  
    },
    
     /**
     * Method: onTitleClick
     * Set the active layer
     * 
     * Parameters: 
     * e - {Event} 
     */
    onTitleClick: function(e) 
    {
        var id = this.layer.id;
       
        layerSwitcher.activeLayer = id;
        
        for (var i=0; i<map.layers.length;i++) { 
          var layer = map.layers[i]; 
          
          if(id == layer.id) {
            this.titleDiv.style.backgroundColor = "#999";
            this.titleDiv.style.border = "solid 1px #999";
          }
          else {           
            var div = OpenLayers.Util.getElement("title_" + layer.id); 
            
            if(div) { 
                div.style.backgroundColor = "#e1e1e1";
                div.style.border = "solid 1px #e1e1e1";
            }
          }           
        }        
        
        if (e != null) {
            OpenLayers.Event.stop(e);                                            
        }
    },
	
	toggleAbstract: function(e) 
	{		
		var span = OpenLayers.Util.getElement("abstract_" + this.layer.id);
		var button = this.button;
            
		if(span && button) { 
			var display = span.style.display;
			
			if(display == "block") {
				span.style.display = "none";
				button.src = OpenLayers.Util.getImagesLocation() + "expand.png";
			}
			else {
				span.style.display = "block";
				button.src = OpenLayers.Util.getImagesLocation() + "collapse.png";
			}
		}
		
	},
    
    /**
     * Method: onDataUrlClick
     * Open new window and redirect to URL.
     * 
     * Parameters: 
     * e - {Event} 
     *
     * Context:  
     *  - {string} url to redirect to
     */
    onDataUrlClick: function(e) 
    {    
        window.open(this.url , "data", "width=550,height=350,status=yes,scrollbars=yes,resizable=yes");
    },
    
    // this = layer.features[f]
    onDownloadPointsClick: function(e){
    		  var zip = new JSZip();
    		  content = this.dataToCSV();
    		  console.log(content);
	    	  zip.file(this.id + "_data.csv", content);
	    	  var content = zip.generate();
	    	  location.href="data:application/zip;base64,"+content;

    },
    /**
     * Method: onMetadataUrlClick
     * Open new window and redirect to URL.
     * 
     * Parameters: 
     * e - {Event} 
     *
     * Context:  
     *  - {string} url to redirect to
     */
    onMetadataUrlClick: function(e) 
    {    
    	alert(this.metaData)
        //window.open(this.url , "metadata", "width=550,height=350,status=yes,scrollbars=yes,resizable=yes");
    },
    
    /**
     * Method: onLayerClick
     * Need to update the map accordingly whenever user clicks in either of
     *     the layers.
     * 
     * Parameters: 
     * e - {Event} 
     */
    onLayerClick: function(e) {
        this.updateMap();
    },

    /**
     * Method: changeLayerOpacity
     * Changes opacity of a given layer for a given delta
     * 
     * Parameters: 
     * e - {Event} 
     *
     * Context:  
     *  - {string} amount to increase or decrease opacity value
     *  - {<OpenLayers.Layer>} layer
     *  - {<OpenLayers.Control.LayerSwitcher>} layerSwitcher
     */
    changeLayerOpacity: function(e) 
    {    
        var maxOpacity = 1.0;
        var minOpacity = 0.1;
        var opacity = (this.layer.opacity != null) ? this.layer.opacity : 1.0;
        var i = parseFloat(this.byOpacity);
        var opacityElement = "opacity_" + this.layer.id;  
        var opacityImg = "opacityImg_" + this.layer.id;
        var newOpacity = (parseFloat(opacity + i)).toFixed(1);
        
        newOpacity = Math.min(maxOpacity, Math.max(minOpacity, newOpacity));
        
        OpenLayers.Util.getElement(opacityElement).value = newOpacity;       
        OpenLayers.Util.getElement(opacityImg).width = (newOpacity * 23).toFixed(0);
        
if (this.layer && this.layer.renderer && this.layer.renderer.root) {
    OpenLayers.Util.modifyDOMElement(this.layer.renderer.root,
        null, null, null, null, null, null, newOpacity);
        		
                this.layer.setOpacity(newOpacity);
}
 else       
        this.layer.setOpacity(newOpacity);
        
        
    },

    /** 
     * Method: updateMap
     * Cycles through the loaded data and base layer input arrays and makes
     *     the necessary calls to the Map object such that that the map's 
     *     visual state corresponds to what the user has selected in 
     *     the control.
     */
    updateMap: function() 
    {
        // set the newly selected base layer        
        for(var i=0, len=this.baseLayers.length; i<len; i++) {
            var layerEntry = this.baseLayers[i];
            if (layerEntry.inputElem.checked) {
                this.map.setBaseLayer(layerEntry.layer, false);
            }
        }

        // set the correct visibilities for the overlays
        for(var i=0, len=this.dataLayers.length; i<len; i++) {
            var layerEntry = this.dataLayers[i];   
            layerEntry.layer.setVisibility(layerEntry.inputElem.checked);
        }
    },

    /** 
     * Method: maximizeControl
     * Set up the labels and divs for the control
     * 
     * Parameters:
     * e - {Event} 
     */
    maximizeControl: function(e) 
    {
        this.div.style.width = "20em";
        this.div.style.height = "100%";
        this.div.style.borderLeft = "solid 1px #999";

        this.showControls(false);

        if (e != null) {
            OpenLayers.Event.stop(e);                                            
        }
    },
    
    /** 
     * Method: minimizeControl
     * Hide all the contents of the control, shrink the size, 
     *     add the maximize icon
     *
     * Parameters:
     * e - {Event} 
     */
    minimizeControl: function(e) 
    {
        this.div.style.width = "0px";
        this.div.style.height = "100%";
        this.div.style.borderLeft = "none";

        this.showControls(true);

        if (e != null) {
            OpenLayers.Event.stop(e);                                            
        }
    },

    /**
     * Method: showControls
     * Hide/Show all LayerSwitcher controls depending on whether we are
     *     minimized or not
     * 
     * Parameters:
     * minimize - {Boolean}
     */
    showControls: function(minimize) {

        this.maximizeDiv.style.display = minimize ? "" : "none";
        this.minimizeDiv.style.display = minimize ? "none" : "";

        this.layersDiv.style.display = minimize ? "none" : "";
    },
    
    /** 
     * Method: loadContents
     * Set up the labels and divs for the control
     */
    loadContents: function() {

        //configure main div
        this.div.style.position = "absolute";
/*
        this.div.style.top = "0px";
        this.div.style.right = "0px";
        this.div.style.left = "";
        this.div.style.fontFamily = "sans-serif";
        this.div.style.fontWeight = "bold";
        this.div.style.fontSize = "13px";   
        this.div.style.color = "#333";   
        this.div.style.height = "100%";
        this.div.style.marginTop = "175px";
*/

    
        OpenLayers.Event.observe(this.div, "mouseup", 
            OpenLayers.Function.bindAsEventListener(this.mouseUp, this));
        OpenLayers.Event.observe(this.div, "click",
                      this.ignoreEvent);
        OpenLayers.Event.observe(this.div, "mousedown",
            OpenLayers.Function.bindAsEventListener(this.mouseDown, this));
        OpenLayers.Event.observe(this.div, "dblclick", this.ignoreEvent);

        // layers list div        
        this.layersDiv = document.createElement("div");
        this.layersDiv.setAttribute("className", "olLayerSwitcherLayerContainer");
        this.layersDiv.id = this.id + "_layersDiv";        
        this.layersDiv.style.overflowX = "hidden"; 
        this.layersDiv.style.overflowY = "scroll";
        this.layersDiv.style.position = "relative";
        this.layersDiv.style.height = "100%";        
        
        // ignore any mousewheel events
        OpenLayers.Event.observe(this.layersDiv, "mousewheel", this.ignoreEvent);

        // had to set width/height to get transparency in IE to work.
        // thanks -- http://jszen.blogspot.com/2005/04/ie6-opacity-filter-caveat.html
        
        this.baseLayersDiv = document.createElement("div");
        this.baseLayersDiv.style.display = "none";
        this.dataLayersDiv = document.createElement("div");
        this.dataLayersDiv.style.paddingLeft = "5px";
       
        if (this.ascending) {
            this.layersDiv.appendChild(this.baseLayersDiv);
            this.layersDiv.appendChild(this.dataLayersDiv);
        } else {
            this.layersDiv.appendChild(this.dataLayersDiv);
            this.layersDiv.appendChild(this.baseLayersDiv);
        }    
        
        this.div.appendChild(this.layersDiv);
        //OpenLayers.Rico.Corner.changeOpacity(this.layersDiv, 0.95);		
		
        var imgLocation = OpenLayers.Util.getImagesLocation();
        var sz = new OpenLayers.Size(20,60);        

        // maximize button div
        var img = imgLocation + 'layer-switcher-maximize.png';
        this.maximizeDiv = OpenLayers.Util.createAlphaImageDiv(
                                    "OpenLayers_Control_MaximizeDiv", 
                                    null, 
                                    sz, 
                                    img, 
                                    "absolute");
        this.maximizeDiv.style.top = "50%";
		this.maximizeDiv.style.marginTop = "-30px";
        this.maximizeDiv.style.right = "0px";
        this.maximizeDiv.style.left = "";
        this.maximizeDiv.style.display = "none";
        OpenLayers.Event.observe(this.maximizeDiv, "click", 
            OpenLayers.Function.bindAsEventListener(this.maximizeControl, this)
        );
        
        this.div.appendChild(this.maximizeDiv);
        //OpenLayers.Rico.Corner.changeOpacity(this.maximizeDiv, 0.95);

        // minimize button div
        var img = imgLocation + 'layer-switcher-minimize.png';
        var sz = new OpenLayers.Size(20,60);        
        this.minimizeDiv = OpenLayers.Util.createAlphaImageDiv(
                                    "OpenLayers_Control_MinimizeDiv", 
                                    null, 
                                    sz, 
                                    img, 
                                    "absolute");
        this.minimizeDiv.style.top = "50%";
		this.minimizeDiv.style.marginTop = "-30px";
        this.minimizeDiv.style.right = "258px";
        this.minimizeDiv.style.left = "";
        OpenLayers.Event.observe(this.minimizeDiv, "click", 
            OpenLayers.Function.bindAsEventListener(this.minimizeControl, this)
        );

        this.div.appendChild(this.minimizeDiv);
        //OpenLayers.Rico.Corner.changeOpacity(this.minimizeDiv, 0.95);
        
        
    },
    
    /** 
     * Method: ignoreEvent
     * 
     * Parameters:
     * evt - {Event} 
     */
	    ignoreEvent: function(evt) {
        OpenLayers.Event.stop(evt);
    },

    /** 
     * Method: mouseDown
     * Register a local 'mouseDown' flag so that we'll know whether or not
     *     to ignore a mouseUp event
     * 
     * Parameters:
     * evt - {Event}
     */
    mouseDown: function(evt) {
        this.isMouseDown = true;
        this.ignoreEvent(evt);
    },

    /** 
     * Method: mouseUp
     * If the 'isMouseDown' flag has been set, that means that the drag was 
     *     started from within the LayerSwitcher control, and thus we can 
     *     ignore the mouseup. Otherwise, let the Event continue.
     *  
     * Parameters:
     * evt - {Event} 
     */
    mouseUp: function(evt) {
        if (this.isMouseDown) {
            this.isMouseDown = false;
            this.ignoreEvent(evt);
        }
    },
	
	CLASS_NAME: "OpenLayers.Control.LayerSwitcher"
});

