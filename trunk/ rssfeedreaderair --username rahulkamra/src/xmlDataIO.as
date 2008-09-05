// ActionScript file
import flash.xml.XMLNode;
import mx.events.ListEvent;


                public function addNode(parentPage:Air,url:String,tagName:String,nameRss:String):void{
                var airApp:Air = parentPage as Air;
	            var fs:FileStream = new FileStream();               

               /**
               * Calculating total number of children of page
               */        
	            var totalTags:int =airApp.recordsXML.children().length();
	           
	           
	           /**
	           * Calculating the total number of sub nodes
	           */
	           
	            var totalSubTags:int=airApp.recordsXML.tag.(@label==tagName).children().length();

	           
	             var isNodeExist:Boolean;
	            /**
	            * Checking weather the node exist or not
	            */ 
	            var temp:XMLList=parentPage.recordsXML.tag.(@label==tagName);
	            if(temp.toString()== ""){
	            	isNodeExist=false;
	            }else{
	            	isNodeExist=true;
	            }
	            
	           var item:XMLNode=new XMLNode(1,"item"); 
	            var data:XMLNode=new XMLNode(XMLNodeType.TEXT_NODE,url);
	            item.appendChild(data);
	             	        
                if(!isNodeExist){           //Creating a new node if node exist
                var tag:XMLNode=new XMLNode(1,"tag");
	            tag.appendChild(item);	
	            airApp.recordsXML.appendChild(tag); 
	            airApp.recordsXML.tag[totalTags]['@label']=tagName;
	            airApp.recordsXML.tag.(@label==tagName).item[0]['@label']=nameRss;
                }else{
                	
                	airApp.recordsXML.tag.(@label==tagName).appendChild(item);
                	 airApp.recordsXML.tag.(@label==tagName).item[totalSubTags]['@label']=nameRss;
                }
	            
	            
              /**
              * Writing the data
              */
                var newXMLStr:String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + airApp.recordsXML.toXMLString();
                fs.open(airApp.file, FileMode.WRITE);
                fs.writeUTFBytes(newXMLStr);
                fs.close();  
               
}




public function getURL(event:ListEvent,myRssCmpt:MyRss):void{
   var data:XML=event.currentTarget.value;
   if(data.children().toString()==""){
   	myRssCmpt.parentObj.getRssFeed(data);
   }
}

