package thx.http.core;

import thx.core.Functions;

class HaxeRequest {
	public static function make(requestInfo : RequestInfo, requestHandler : RequestHandler) : Void -> Void {
		var req = new haxe.Http(requestInfo.url);
		for(key in requestInfo.headers.keys())
			req.setHeader(key, requestInfo.headers.get(key));
		req.onStatus = requestHandler.statusHandler;
		//req.onData = requestHandler.dataHandler;
		//req.onError = requestHandler.errorHandler;
		switch requestInfo.method {
			case Get: req.request(false);
			case Post: req.request(true);
			case other: throw 'haxe.Http doesn\'t support method "$other"';
		}
		#if (flash || js)
		return req.cancel;
		#else
		// no cancel, sorry
		return Functions.noop;
		#end
	}
}