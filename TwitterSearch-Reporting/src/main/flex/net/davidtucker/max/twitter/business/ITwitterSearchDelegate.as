package net.davidtucker.max.twitter.business
{
	import mx.rpc.AsyncToken;

	public interface ITwitterSearchDelegate
	{
	
		/**
		 * This method actually calls the HTTPService to perform the Twitter search with
		 * the specified search terms.
		 * 
		 * @param searchTerms The array of search terms you are searching against
		 * @return The AsyncToken that corresponds to your service call
		 */
		function searchTwitter(searchTerms:Array):AsyncToken;
		
	}
}