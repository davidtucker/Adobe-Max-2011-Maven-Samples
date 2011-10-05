package net.davidtucker.max.twitter.translator
{
	import com.adobe.utils.DateUtil;
	
	import flash.xml.XMLDocument;
	import flash.utils.ByteArray;
	
	import net.davidtucker.max.twitter.vo.TwitterAuthor;
	import net.davidtucker.max.twitter.vo.TwitterEntry;
	import net.davidtucker.max.twitter.vo.TwitterSearch;
	
	import org.flexunit.Assert;
	
	public class TwitterSearchTranslatorTest
	{	
		private static function getXMLFromClass(Value:Class):XML
		{
			var byteArray:ByteArray = new Value;
			var xmlString:String = byteArray.readUTFBytes( byteArray.length );
			return new XML( xmlString );
		}
		
		[Embed(source='/searchResults.xml',mimeType='application/octet-stream')]
		private static const SEARCH_RESULT_EMEBEDDED_DATA:Class;
		
		[Embed(source='/entry1.xml',mimeType='application/octet-stream')]
		private static const ENTRY_1_EMBEDDED_DATA:Class;
		
		[Embed(source='/entry2.xml',mimeType='application/octet-stream')]
		private static const ENTRY_2_EMBEDDED_DATA:Class;
		
		[Embed(source='/author1.xml',mimeType='application/octet-stream')]
		private static const AUTHOR_1_EMBEDDED_DATA:Class;
		
		[Embed(source='/author2.xml',mimeType='application/octet-stream')]
		private static const AUTHOR_2_EMBEDDED_DATA:Class;
		
		private static var SEARCH_RESULT_XML:XML = getXMLFromClass( SEARCH_RESULT_EMEBEDDED_DATA );
			
		private static var ENTRY_XML_1:XML = getXMLFromClass( ENTRY_1_EMBEDDED_DATA );
		
		private static var ENTRY_XML_2:XML = getXMLFromClass( ENTRY_2_EMBEDDED_DATA );
			
		private static var AUTHOR_XML_1:XML = getXMLFromClass( AUTHOR_1_EMBEDDED_DATA );
		
		private static var AUTHOR_XML_2:XML = getXMLFromClass( AUTHOR_2_EMBEDDED_DATA );
		
		private static var USERNAME_NAME_1:String = "AdrianPomilio (Adrian Pomilio)";
		
		private static var USERNAME_NAME_2:String = "nithiljose (nithiljose)";
		
		private var translator:TwitterSearchTranslator;
		
		[Before]
		public function setup():void
		{
			translator = new TwitterSearchTranslator();
		}
		
		[After]
		public function tearDown():void
		{
			translator = null;
		}
		
		[Test]
		public function testSeparateUsernameName():void
		{
			var result:Array = translator.separateUsernameName( USERNAME_NAME_1 );
			Assert.assertTrue( false );
			Assert.assertEquals( result.length, 2 );
			Assert.assertEquals( result[0], "AdrianPomilio" );
			Assert.assertEquals( result[1], "Adrian Pomilio" );
			
			result = translator.separateUsernameName( USERNAME_NAME_2 );
			Assert.assertTrue( result is Array );
			Assert.assertEquals( result.length, 2 );
			Assert.assertEquals( result[0], "nithiljose" );
			Assert.assertEquals( result[1], "nithiljose" );
		}
		
		[Test]
		public function testTranslateTwitterAuthor():void
		{
			var author:TwitterAuthor = translator.translateTwitterAuthor( AUTHOR_XML_1 );
			Assert.assertEquals( author.username, "AdrianPomilio" );
			Assert.assertEquals( author.name, "Adrian Pomilio" );
			Assert.assertEquals( author.url, "http://twitter.com/AdrianPomilio" );
			
			author = translator.translateTwitterAuthor( AUTHOR_XML_2 );
			Assert.assertEquals( author.username, "nithiljose" );
			Assert.assertEquals( author.name, "nithiljose" );
			Assert.assertEquals( author.url, "http://twitter.com/nithiljose" );
		}
		
		[Test]
		public function testTranslateTwitterEntry():void
		{
			var entry:TwitterEntry = translator.translateTwitterEntry( ENTRY_XML_1 );
			Assert.assertEquals( entry.id, "tag:search.twitter.com,2005:26518381711" );
			Assert.assertEquals( entry.published.time, DateUtil.parseW3CDTF( "2010-10-06T03:22:24Z").time  );
			Assert.assertEquals( entry.url, "http://twitter.com/AdrianPomilio/statuses/26518381711" );
			Assert.assertEquals( entry.title, "@mindmillmedia didn't you guys have a pretty awesome ball player named Keith Jennings?  aka Mister Jennings?" );
			Assert.assertEquals( entry.content, new XML( <value>&lt;a href=&quot;http://twitter.com/mindmillmedia&quot;&gt;&lt;b&gt;@mindmillmedia&lt;/b&gt;&lt;/a&gt; didn&amp;apos;t you guys have a pretty awesome ball player named Keith Jennings?  aka Mister Jennings?</value> ).toString() );
			Assert.assertEquals( entry.updated.time, DateUtil.parseW3CDTF( "2010-10-06T03:22:24Z" ).time );
			Assert.assertEquals( entry.profileImageUrl, "http://a0.twimg.com/profile_images/1103123336/53b39485-57dc-4714-824a-bc61f310eb19_normal.png" );
			Assert.assertEquals( entry.source, new XML( <value>&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;</value> ).toString() );
			Assert.assertEquals( entry.language, "en" );
			
			Assert.assertTrue( entry.author is TwitterAuthor );
			var author:TwitterAuthor = entry.author;
			Assert.assertEquals( author.username, "AdrianPomilio" );
			Assert.assertEquals( author.name, "Adrian Pomilio" );
			Assert.assertEquals( author.url, "http://twitter.com/AdrianPomilio" );
			
			entry = translator.translateTwitterEntry( ENTRY_XML_2 );
			Assert.assertEquals( entry.id, "tag:search.twitter.com,2005:26436759975" );
			Assert.assertEquals( entry.published.time, DateUtil.parseW3CDTF( "2010-10-05T07:35:02Z").time  );
			Assert.assertEquals( entry.url, "http://twitter.com/nithiljose/statuses/26436759975" );
			Assert.assertEquals( entry.title, "RT @mindmillmedia: Major update to the AS3 SDK for Facebook http://bit.ly/bnMWa2 #graphapi (via @__ted__)" );
			Assert.assertEquals( entry.content, new XML( <value>RT &lt;a href=&quot;http://twitter.com/mindmillmedia&quot;&gt;&lt;b&gt;@mindmillmedia&lt;/b&gt;&lt;/a&gt;: Major update to the AS3 SDK for Facebook &lt;a href=&quot;http://bit.ly/bnMWa2&quot;&gt;http://bit.ly/bnMWa2&lt;/a&gt; &lt;a href=&quot;http://search.twitter.com/search?q=%23graphapi&quot; onclick=&quot;pageTracker._setCustomVar(2, 'result_type', 'recent', 3);pageTracker._trackPageview('/intra/hashtag/#graphapi');&quot;&gt;#graphapi&lt;/a&gt; (via &lt;a href=&quot;http://twitter.com/__ted__&quot;&gt;@__ted__&lt;/a&gt;)</value> ).toString() );
			Assert.assertEquals( entry.updated.time, DateUtil.parseW3CDTF( "2010-10-05T07:35:02Z" ).time );
			Assert.assertEquals( entry.profileImageUrl, "http://a3.twimg.com/profile_images/457569023/aa_normal.jpg" );
			Assert.assertEquals( entry.source, new XML( <value>&lt;a href=&quot;http://www.tweetdeck.com&quot; rel=&quot;nofollow&quot;&gt;TweetDeck&lt;/a&gt;</value> ).toString() );
			Assert.assertEquals( entry.language, "en" );
			
			Assert.assertTrue( entry.author is TwitterAuthor );
			author = entry.author;
			Assert.assertEquals( author.username, "nithiljose" );
			Assert.assertEquals( author.name, "nithiljose" );
			Assert.assertEquals( author.url, "http://twitter.com/nithiljose" );
		}

		[Test]
		public function testTranslateTwitterSearch():void
		{
			var search:TwitterSearch = translator.translateTwitterSearch( SEARCH_RESULT_XML );
			Assert.assertEquals( search.id, "tag:search.twitter.com,2005:search/@mindmillmedia" );
			Assert.assertEquals( search.searchUrl, "http://search.twitter.com/search?q=%40mindmillmedia" );
			Assert.assertEquals( search.title, "@mindmillmedia - Twitter Search" );
			Assert.assertEquals( search.itemsPerPage, 15 );
			
			Assert.assertTrue( search.entries is Array );
			Assert.assertEquals( search.entries.length, 2 );
			
			var entry:TwitterEntry = search.entries[0];
			Assert.assertEquals( entry.id, "tag:search.twitter.com,2005:26518381711" );
			Assert.assertEquals( entry.published.time, DateUtil.parseW3CDTF( "2010-10-06T03:22:24Z").time  );
			Assert.assertEquals( entry.url, "http://twitter.com/AdrianPomilio/statuses/26518381711" );
			Assert.assertEquals( entry.title, "@mindmillmedia didn't you guys have a pretty awesome ball player named Keith Jennings?  aka Mister Jennings?" );
			Assert.assertEquals( entry.content, new XML( <value>&lt;a href=&quot;http://twitter.com/mindmillmedia&quot;&gt;&lt;b&gt;@mindmillmedia&lt;/b&gt;&lt;/a&gt; didn&amp;apos;t you guys have a pretty awesome ball player named Keith Jennings?  aka Mister Jennings?</value> ).toString() );
			Assert.assertEquals( entry.updated.time, DateUtil.parseW3CDTF( "2010-10-06T03:22:24Z" ).time );
			Assert.assertEquals( entry.profileImageUrl, "http://a0.twimg.com/profile_images/1103123336/53b39485-57dc-4714-824a-bc61f310eb19_normal.png" );
			Assert.assertEquals( entry.source, new XML( <value>&lt;a href=&quot;http://twitter.com/&quot;&gt;web&lt;/a&gt;</value> ).toString() );
			Assert.assertEquals( entry.language, "en" );
			
			Assert.assertTrue( entry.author is TwitterAuthor );
			var author:TwitterAuthor = entry.author;
			Assert.assertEquals( author.username, "AdrianPomilio" );
			Assert.assertEquals( author.name, "Adrian Pomilio" );
			Assert.assertEquals( author.url, "http://twitter.com/AdrianPomilio" );
			entry = search.entries[1];
			Assert.assertEquals( entry.id, "tag:search.twitter.com,2005:26436759975" );
			Assert.assertEquals( entry.published.time, DateUtil.parseW3CDTF( "2010-10-05T07:35:02Z").time  );
			Assert.assertEquals( entry.url, "http://twitter.com/nithiljose/statuses/26436759975" );
			Assert.assertEquals( entry.title, "RT @mindmillmedia: Major update to the AS3 SDK for Facebook http://bit.ly/bnMWa2 #graphapi (via @__ted__)" );
			Assert.assertEquals( entry.content, new XML( <value>RT &lt;a href=&quot;http://twitter.com/mindmillmedia&quot;&gt;&lt;b&gt;@mindmillmedia&lt;/b&gt;&lt;/a&gt;: Major update to the AS3 SDK for Facebook &lt;a href=&quot;http://bit.ly/bnMWa2&quot;&gt;http://bit.ly/bnMWa2&lt;/a&gt; &lt;a href=&quot;http://search.twitter.com/search?q=%23graphapi&quot; onclick=&quot;pageTracker._setCustomVar(2, 'result_type', 'recent', 3);pageTracker._trackPageview('/intra/hashtag/#graphapi');&quot;&gt;#graphapi&lt;/a&gt; (via &lt;a href=&quot;http://twitter.com/__ted__&quot;&gt;@__ted__&lt;/a&gt;)</value> ).toString() );
			Assert.assertEquals( entry.updated.time, DateUtil.parseW3CDTF( "2010-10-05T07:35:02Z" ).time );
			Assert.assertEquals( entry.profileImageUrl, "http://a3.twimg.com/profile_images/457569023/aa_normal.jpg" );
			Assert.assertEquals( entry.source, new XML( <value>&lt;a href=&quot;http://www.tweetdeck.com&quot; rel=&quot;nofollow&quot;&gt;TweetDeck&lt;/a&gt;</value> ).toString() );
			Assert.assertEquals( entry.language, "en" );
			
			Assert.assertTrue( entry.author is TwitterAuthor );
			author = entry.author;
			Assert.assertEquals( author.username, "nithiljose" );
			Assert.assertEquals( author.name, "nithiljose" );
			Assert.assertEquals( author.url, "http://twitter.com/nithiljose" );
		}

	}
}