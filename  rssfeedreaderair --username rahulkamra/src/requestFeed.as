// ActionScript file
import mx.controls.Alert;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;

[Bindable]
public var request:HTTPService=new HTTPService();
public function requestFeedFunc(url:String):Object{
	request.addEventListener(FaultEvent.FAULT,errorFeed);
	request.addEventListener(ResultEvent.RESULT,resultFeed);
	statusNode.text="Getting Data from the server";
	request.url=url;
	request.send();
	
	return request.lastResult;
}

public function errorFeed(event:FaultEvent):void{
//Alert.show(event.message.toString());	
statusNode.text="Invalid URL Feed Cannot be retreived";
}

public function resultFeed(event:ResultEvent):void{
	statusNode.text="Data has been retreived";
}



