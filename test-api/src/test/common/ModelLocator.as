package test.common
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Put data here that must be shared across many or all views of the application.
	 */
	[Bindable]
	public class ModelLocator
	{
		
		/**
		 * Singleton instance of ModelLocator
		 */
		private static var _instance:ModelLocator = null;
		
		/**
		 * Returns the Singleton instance of ModelLocator
		 */
		public static function getInstance():ModelLocator{
			if (_instance == null) {
				_instance = new ModelLocator( new Private );
			}
			return _instance;
		}
		
		public function ModelLocator(access:Private) {
			if (access != null) {
				if (_instance == null) {
					_instance = this;
				}
			} else {
				throw new Error( "Singleton Exception" );
			}
		}
		
		private var _count:int = 0;
		public var items:ArrayCollection = new ArrayCollection();
		
		public function incrementedCount():int {
			return ++_count;
		}
	}
}

/**
 * Inner class which restricts contructor access to Private
 */
class Private {}
