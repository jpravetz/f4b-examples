package test.provider
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	public class ProviderContainerPM extends EventDispatcher
	{
		private var _items:ArrayCollection = new ArrayCollection();
		
		public function ProviderContainerPM(target:IEventDispatcher=null) {
			super(target);
		}
		
		[Bindable] public function get items():ArrayCollection {
			return _items;
		}
		
		public function set items(items:ArrayCollection):void {
			_items = items;
		}
		
		[Init]
		public function init():void {
			var array:Array = [ "Line 1", "Line 2", "Line 3" ];
			_items.source = array;
		}
	}
}