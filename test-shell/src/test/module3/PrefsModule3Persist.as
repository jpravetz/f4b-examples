package test.module3
{
	import flash.utils.describeType;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	import test.util.PrefsSharedObject;
	
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
			_log.debug( "Called: constructor" );
			var xml:XML = flash.utils.describeType(this);
			_log.debug( xml.toString() );
			super();
		}
		
		[Init]
		public function init():void {
			_log.debug( "Called: [Init]" );
			load(name);
		}
		
		public function set persistText(value:String):void {
			setStringProperty("persistText", value);
		}
		
		public function get persistText():String {
			_log.debug( "Called: get persistText()" );
			return getStringProperty("persistText","Default Value");
		}
		
	}
}