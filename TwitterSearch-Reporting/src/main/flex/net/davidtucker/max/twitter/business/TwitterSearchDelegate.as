package net.davidtucker.max.twitter.business
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import net.davidtucker.max.twitter.translator.TwitterSearchTranslator;
	
	public class TwitterSearchDelegate implements ITwitterSearchDelegate
	{
	
		protected static const TWITTER_SEARCH_URL:String = "http://search.twitter.com/search.atom";
		
		protected var service:HTTPService;
		
		/**
		 * Constructor.
		 */
		public function TwitterSearchDelegate()
		{
			service = new HTTPService();
			service.url = TWITTER_SEARCH_URL;
			service.resultFormat = HTTPService.RESULT_FORMAT_E4X;
		}
		
		/**
		 * @inherited
		 */
		public function searchTwitter( searchTerms:Array ):AsyncToken
		{
			var joinedSearchTerms:String = searchTerms.join( "+" );
			var params:Object = { q: joinedSearchTerms };
			return service.send( params ); 
		}
		
	}
}