package net.davidtucker.max.twitter.vo
{
	
	[Bindable]
	public class TwitterSearch
	{
		
		public var id:String;
		public var searchUrl:String;
		public var title:String;
		public var itemsPerPage:uint;
		
		[ArrayElementType("net.davidtucker.max.twitter.vo.TwitterEntry")]
		public var entries:Array;
		
	}
}