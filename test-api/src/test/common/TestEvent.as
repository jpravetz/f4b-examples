package test.common
{
	import flash.events.Event;
	
	public class TestEvent extends Event
	{
		public static const TEST:String = "testEvent";
		private var _message:String;
		private var _sender:String;
		
		public function TestEvent( message:String, sender:String=null ) {
			super( TEST );
			_message = message;
			_sender = sender;
		}
		
		
		public function get message():String {
			return _message;
		}
		
		public function get sender():String {
			return _sender;
		}
		
		override public function clone() : Event {
			return new TestEvent( message, sender );
		}
		
	}
}