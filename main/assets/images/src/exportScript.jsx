#target photoshop

function MoveLayerTo(fLayer,fX,fY) {

  var Position = fLayer.bounds;
  Position[0] = fX - Position[0];
  Position[1] = fY - Position[1];

  fLayer.translate(-Position[0],-Position[1]);
}

var activeDoc = app.activeDocument;
var layers = activeDoc.layers;

var selRegion = Array(Array(0,0), Array(280,0), Array(280,280), Array(0,280));

for(var i=0; i < layers.length; i++)
{
    if(layers[i].isBackgroundLayer) continue;
    
    var baseName = layers[i].name;   
    var subLayers = layers[i].artLayers;
    
    for(var j=0; j < subLayers.length; j++)
    {       
        var layer = subLayers[j];
        
        layer.visible = true;
        layer.copy();
        
        //layer.selected = true;
        //activeDoc.selection.select (selRegion);
        
        //activeDoc.selection.copy();
        //layer.copy();
        
        
        
        //var layerX = -layer.bounds[0] + layer.bounds[2];
        //var layerY = -layer.bounds[1] + layer.bounds[3];
        
        var newDoc = app.documents.add(activeDoc.width,activeDoc.height,activeDoc.resolution, "export", NewDocumentMode.RGB, DocumentFill.TRANSPARENT);
        newDoc.selection.select(selRegion);
        var newLayer = newDoc.paste();
        
        MoveLayerTo(newLayer, layer.bounds[0].value, layer.bounds[1].value);
        //newLayer.translate(-layer.bounds[0].value, -layer.bounds[1].value);
        
        var options = new ExportOptionsSaveForWeb();
        options.format = SaveDocumentType.PNG;
        options.PNG8 = false;
        options.transparency = true;
        options.optimized = true;
        
        newDoc.exportDocument(File(activeDoc.path+ "/"+baseName+ layer.name +'.png'),ExportType.SAVEFORWEB, options);
        newDoc.close (SaveOptions.DONOTSAVECHANGES);
    }
}