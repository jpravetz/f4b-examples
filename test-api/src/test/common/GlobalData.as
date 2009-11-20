package test.common
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Put data here that must be shared across many or all views of the application.
	 */
	[Bindable]
	public class GlobalData
	{
	
		public var items:ArrayCollection = new ArrayCollection();
		
		/**
		 * Public properties can be initialized by the Context.
		 */
		public var count:int = 0;

		public function incrementedCount():int {
			return ++count;
		}
	}
}

/**
 * Inner class which restricts contructor access to Private
 */
class Private {}
