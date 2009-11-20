package test.module1
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	import test.common.GlobalData;
	import test.common.TestEvent;
	
	[Event( name="testEvent", type="test.common.TestEvent" )]
	[ManagedEvents( "testEvent" )]
	public class Module1PanelPM extends EventDispatcher
	{
		[Bindable] public var textReceive:String = "Initial string";
		[Bindable] public var textSend:String = "";
		
		private static const log:Logger = LogContext.getLogger(Module1PanelPM);
		
		// This object will be injected when the IOC framework instantiates this object.
		[Inject] [Bindable] public var globalData:GlobalData;
		
		public function Module1PanelPM(target:IEventDispatcher=null) {
			super(target);
		}
		
		public function sendMessage() : void {
			log.debug( "Module1 dispatch message = '{0}'", textSend );
			globalData.incrementedCount();
			dispatchEvent( new TestEvent( textSend, "Module1" ) );
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