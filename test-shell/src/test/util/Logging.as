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
	import com.adobe.air.logging.FileTarget;
	import com.adobe.utils.DateUtil;
	
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	
	import mx.logging.Log;
	import mx.logging.LogEventLevel;
	import mx.logging.targets.TraceTarget;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	public class Logging
	{
		public function Logging()
		{
		}
		
		/**
		 * Initialize logging for the application. 
		 * This needs to be done before everything else, else log messages won't be recorded.
		 * Classes that wish to log messages should call:
		 *	private static const log:Logger = LogContext.getLogger(MyClass);
		 *	log.info("Number {0}, {1}", 1, 2 );
		 * NOTE: I'd like to move this to the Context file, but do not know the syntax to do so.
		 */
		public static function initLogging() : void
		{
			// var logTarget : TraceTarget = new TraceTarget();
			var file:File = File.desktopDirectory;
			file = file.resolvePath( "test_log.txt" );
			var logTarget : FileTarget = new FileTarget(file);
			
			// logTarget.filters = [ "com.adobe.cairngorm.persistence.*", "org.spicefactory.*" ];
			
			logTarget.level = LogEventLevel.ALL;
			
			// logTarget.includeDate = true;
			logTarget.includeTime = true;
			logTarget.includeCategory = true;
			logTarget.includeLevel = true;
			
			Log.addTarget( logTarget );
		}
		
		
		public static function logApplicationInformation():void {
			
			var log:Logger = LogContext.getLogger(Logging);
			log.info("ApplicationID = {0}", NativeApplication.nativeApplication.applicationID);			
			log.info("runtimeVersion = " + NativeApplication.nativeApplication.runtimeVersion);			
			log.info("runtimePatchLevel = " + NativeApplication.nativeApplication.runtimePatchLevel);			
		}
	}
}