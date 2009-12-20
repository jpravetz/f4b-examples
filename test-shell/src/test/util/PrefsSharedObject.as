/*************************************************************************
 * CAYO CONFIDENTIAL
 * Copyright 2009 Cayo Systems, Inc. All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains the property
 * of Cayo Systems, Inc. and its suppliers, if any.  The intellectual
 * and technical concepts contained herein are proprietary to 
 * Cayo Systems, Inc. and its suppliers and may be covered by U.S. and
 * Foreign Patents, patents in process, and are protected by trade secret
 * or copyright law. Dissemination of this information or reproduction of
 * this material is strictly forbidden unless prior written permission
 * is obtained from Cayo Systems, Inc..
 **************************************************************************/

package test.util
{
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.SharedObject;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	/**
	 * Superclass used to store preferences in a SharedObject.
	 * Plays nice with IOC frameworks if used correctly.
	 */
	[Bindable]
	public class PrefsSharedObject
	{
		private var _so:SharedObject;
		
		private static const _log:Logger = LogContext.getLogger(PrefsSharedObject);
		
		/**
		 * The subclass should either call load() directly from its constructor,
		 * or ensure that load() is called during object initialization (for
		 * example under an [Init] tag for an injected object.
		 */
		public function PrefsSharedObject() {
		}
		
		/**
		 * Method must be called before using this shared object.
		 * @param name Name by which this shared object is stored.
		 */
		public function load(name:String):void {
			_so = SharedObject.getLocal(name);
			_log.debug( "Result for '_so = SharedObject.getLocal({0})' is _so = {1}", name, (_so==null) ? "null" : "non null" );
		}
		
		protected function setUIntProperty(key:String,value:uint):void {
			_so.data[key] = value;
		}
		
		protected function getUIntProperty(key:String,defaultValue:uint):uint {
			return _so.data.hasOwnProperty(key) ? (_so.data[key] as uint) : defaultValue;
		}
		
		protected function setIntProperty(key:String,value:int):void {
			_so.data[key] = value;
		}
		
		protected function getIntProperty(key:String,defaultValue:int):int {
			return _so.data.hasOwnProperty(key) ? (_so.data[key] as int) : defaultValue;
		}
		
		protected function setNumberProperty(key:String,value:Number):void {
			_so.data[key] = value;
		}
		
		protected function getNumberProperty(key:String,defaultValue:Number):Number {
			return _so.data.hasOwnProperty(key) ? (_so.data[key] as Number) : defaultValue;
		}
		
		protected function setBooleanProperty(key:String,value:Boolean):void {
			_so.data[key] = value;
		}
		
		protected function getBooleanProperty(key:String,defaultValue:Boolean):Boolean {
			return _so.data.hasOwnProperty(key) ? (_so.data[key] as Boolean) : defaultValue;
		}
		
		protected function setStringProperty(key:String,value:String):void {
			_so.data[key] = value;
		}
		
		protected function getStringProperty(key:String,defaultValue:String=null):String {
			if( _so.data.hasOwnProperty(key) ) {
				_log.debug( "Result for '_so.data[{0}]' = '{1}'", key, _so.data[key] );
			} else {
				_log.debug( "Result for '_so.data[{0}]' = {1}", key, "<Not Set>" );
			}
			return _so.data.hasOwnProperty(key) ? (_so.data[key] as String) : defaultValue;
		}
		
		protected function setProperty(key:String,value:Object):void {
			_so.data[key] = value;
		}
		
		protected function getProperty(key:String,defaultValue:Object=null):Object {
			return _so.data.hasOwnProperty(key) ? (_so.data[key]) : defaultValue;
		}
		
		
		
		public function write():void {
			_so.flush();
		}
		
		public function clear():void {
			_so.clear();
		}
		
	}
}