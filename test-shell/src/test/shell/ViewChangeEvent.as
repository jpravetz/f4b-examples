package test.shell
{
	import flash.events.Event;
	
	public class ViewChangeEvent extends Event
	{
		public static const INBOX:String = "view.inbox";
		public static const PROVIDER:String = "view.provider";
		public static const DEBUG:String = "view.debug";
		
		
		public function ViewChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}