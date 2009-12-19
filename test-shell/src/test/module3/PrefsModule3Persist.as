package test.module3
{
	import test.util.PrefsSharedObject;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	/**
	 * Object used to persist settings that are specific to this module
	 * and that are not used by the main application.
	 */
	[Bindable]
	public class PrefsModule3Persist extends PrefsSharedObject
	{
		/**
		 * The name by which this preference is stored on disk
		 * in a Flash SharedObject.
		 */
		public var name:String;
		private static const _log:Logger = LogContext.getLogger(PrefsModule3Persist);
		
		public function PrefsModule3Persist() {
			super();
		}
		
		[Init]
		public function init():void {
			load(name);
			_log.debug( "init called load({0})", name );
		}
		
		public function set persistText(value:String):void {
			setStringProperty("persistText", value);
		}
		
		public function get persistText():String {
			var value:String = getStringProperty("persistText","Default Value");
			_log.debug( "get lastTabIndex = {0}", value );
			return value;
		}
		
	}
}