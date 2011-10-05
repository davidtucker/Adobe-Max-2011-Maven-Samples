package net.davidtucker.max.twitter.vo
{
	
	[Bindable]
	public class TwitterEntry
	{
		
		public var id:String;
		public var published:Date;
		public var url:String;
		public var title:String;
		public var content:String;
		public var updated:Date;
		public var profileImageUrl:String;
		public var source:String;
		public var language:String;
		public var author:TwitterAuthor;
		
	}
}