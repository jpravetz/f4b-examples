package test.module2
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import test.common.ModelLocator;
	import test.common.TestEvent;
	
	[Event( name="testEvent", type="test.common.TestEvent" )]
	[ManagedEvents( "testEvent" )]
	public class Module2PanelPM extends EventDispatcher
	{
		[Bindable] public var textReceive:String = "Initial string";
		[Bindable] public var textSend:String = "";
		private var _model:ModelLocator = ModelLocator.getInstance();
		
		public function Module2PanelPM(target:IEventDispatcher=null) {
			super(target);
		}
		
		public function sendMessage() : void {
			dispatchEvent( new TestEvent( textSend, "Module2" ) );
		}
		
		[MessageHandler]
		public function onMessage( event : TestEvent ) : void {
			textReceive = "[" + _model.incrementedCount() + "] ";
			if( event.sender != null )
				textReceive += event.sender + ": ";
			textReceive += event.message;
		}
	}
}