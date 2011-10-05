package net.davidtucker.max.twitter.translator
{
	import com.adobe.utils.DateUtil;
	import com.adobe.utils.StringUtil;
	
	import flash.xml.XMLDocument;
	
	import net.davidtucker.max.twitter.vo.TwitterAuthor;
	import net.davidtucker.max.twitter.vo.TwitterEntry;
	import net.davidtucker.max.twitter.vo.TwitterSearch;
	
	/**
	 * This class has static methods that handle the translation of the XML data from
	 * Twitter's search API to strongly typed domain model objects.
	 * 
	 * @author David Tucker
	 */
	public class TwitterSearchTranslator
	{
		
		namespace twitter = "http://api.twitter.com/";
		namespace openSearch = "http://a9.com/-/spec/opensearch/1.1/";
		namespace atom = "http://www.w3.org/2005/Atom";
		
		use namespace atom;
		
		/**
		 * Generates a stringly typed <code>TwitterSearch</code> instance when given
		 * a piece of XML data.
		 * 
		 * @param source The initial XML data
		 */
		public function translateTwitterSearch( source:XML ):TwitterSearch
		{
			var result:TwitterSearch = new TwitterSearch();
			result.id = source.id;
			result.searchUrl = source.link[0].@href;
			result.title = source.title;
			result.itemsPerPage = source.openSearch::itemsPerPage;
			
			result.entries = [];
			for each( var entry:XML in source.entry )
			{
				result.entries.push( translateTwitterEntry( entry ) );
			}
			
			// Simulate slow bandwidth
			var length:int = 9000000;
			for( var i:uint = 0; i < length; i++ )
			{
				try{ var aNumber:Number = length; }
				catch( e:Error ){ trace( "FAIL" ); }
			}
			
			return result;
		}
		
		/**
		 * Generates a stringly typed <code>TwitterEntry</code> instance when given
		 * a piece of XML data.
		 * 
		 * @param source The initial XML data
		 */
		public function translateTwitterEntry( source:XML ):TwitterEntry
		{
			
			var result:TwitterEntry = new TwitterEntry();
			result.id = source.id;
			result.published = DateUtil.parseW3CDTF( source.published );
			result.url = source.link[0].@href;
			result.title = source.title;
			result.content = source.content;
			result.updated = DateUtil.parseW3CDTF( source.updated );
			result.profileImageUrl = source.link[1].@href;
			result.source = source.twitter::source;
			result.language = source.twitter::lang;
			result.author = translateTwitterAuthor( source.author[0] );
			return result;
		}
		
		/**
		 * Generates a stringly typed <code>TwitterAuthor</code> instance when given
		 * a piece of XML data.
		 * 
		 * @param source The initial XML data
		 */
		public function translateTwitterAuthor( source:XML ):TwitterAuthor
		{
			var result:TwitterAuthor = new TwitterAuthor();
			var userInfo:Array = separateUsernameName( source.name[0] );
			result.username = userInfo[0];
			result.name = userInfo[1];
			result.url = source.uri;
			return result;
		}
		
		/**
		 * Splits out the username and name of the twitter used from Twitter's string
		 * representation of this data.
		 * 
		 * @param source The string on which to perform the action
		 */
		public function separateUsernameName( source:String ):Array
		{
			var output:Array = source.split( "(" );
			output[0] = StringUtil.trim( output[0] );
			output[1] = String( output[1] ).substr( 0, String( output[1] ).length -1 );
			return output;
		}
		
	}
}