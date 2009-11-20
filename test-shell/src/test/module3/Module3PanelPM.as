package test.module3
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import test.common.GlobalData;
	import test.common.TestEvent;
	
	[Event( name="testEvent", type="test.common.TestEvent" )]
	[ManagedEvents( "testEvent" )]
	public class Module3PanelPM extends EventDispatcher
	{
		[Bindable] public var textReceive:String = "Initial string";
		[Bindable] public var textSend:String = "";
		
		// This object will be injected when the IOC framework instantiates this object.
		[Inject] [Bindable] public var globalData:GlobalData;
		
		public function Module3PanelPM(target:IEventDispatcher=null) {
			super(target);
		}
		
		public function sendMessage() : void {
			globalData.incrementedCount();
			dispatchEvent( new TestEvent( textSend, "Module3" ) );
		}
		
		[MessageHandler]
		public function onMessage( event : TestEvent ) : void {
			textReceive = "[" + globalData.count + "] ";
			if( event.sender != null )
				textReceive += event.sender + ": ";
			textReceive += event.message;
		}
	}
}