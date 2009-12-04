package com.cayo.canmore.shell.presentation
{
	import com.cayo.canmore.events.ViewChangeEvent;
	import com.cayo.canmore.prefs.domain.WorkspacePrefs;
	
	import flash.desktop.NativeApplication;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	
	import mx.core.UIComponent;
	
	import org.spicefactory.parsley.core.context.Context;
	
	/**
	 * 
	 */
	
	[Event(name="menu.prefs",type="com.cayo.canmore.messaging.MenuCommandEvent")]
	[Event(name="view.inbox",type="com.cayo.canmore.events.ViewChangeEvent")]
	[Event(name="view.provider",type="com.cayo.canmore.events.ViewChangeEvent")]
	[Event(name="view.debug",type="com.cayo.canmore.events.ViewChangeEvent")]
	[ManagedEvents("menu.prefs,view.inbox,view.provider,view.debug")]
	public class RootMenuManager extends EventDispatcher
	{
		private var _parent:UIComponent;
		
		[Inject] public var context:Context;
		[Inject] public var prefs:WorkspacePrefs;
		
		public function RootMenuManager(target:IEventDispatcher=null) {
			super(target);
		}
	
		public function createAppMenuBar(menuParent:UIComponent):void {
			
			var viewMenuItem:NativeMenuItem = newParentMenuItem( "View", createViewMenu(), null );
			var toolsMenuItem:NativeMenuItem = newParentMenuItem( "Tools", createToolsMenu(), null );
			
			if (NativeApplication.supportsMenu) {
				// Mac
				var rootMenu:NativeMenu = NativeApplication.nativeApplication.menu;
				rootMenu.getItemAt(0).submenu.addItemAt( newMenuItem( "Preferences...", handlePrefsClick,"," ), 1 );
				rootMenu.getItemAt(0).submenu.addItemAt( newSeparator(), 1 );
				NativeApplication.nativeApplication.menu.addItem( viewMenuItem );
				NativeApplication.nativeApplication.menu.addItem( toolsMenuItem );
				
			} else if (NativeWindow.supportsMenu) {
				// Windows
				menuParent.stage.nativeWindow.menu.addItem( viewMenuItem );
				menuParent.stage.nativeWindow.menu.addItem( toolsMenuItem );
			}
			//NativeApplication.nativeApplication.menu = menuBar;
		}
		
		
		private function newParentMenuItem(label:String, subMenu:NativeMenu, handler:Function):NativeMenuItem {
			var result:NativeMenuItem = new NativeMenuItem(label);
			result.submenu = subMenu;
			if( handler != null )
				result.addEventListener(Event.SELECT,handler);
			return result;
		}
		
		private function newMenuItem( label:String, handler:Function, keyEquivalent:String=null ):NativeMenuItem {
			var result:NativeMenuItem = new NativeMenuItem( label );
			result.addEventListener(Event.SELECT,handler);
			if( keyEquivalent != null )
				result.keyEquivalent = keyEquivalent;
			return result;
		}
		
		private static function newSeparator():NativeMenuItem {
			return new NativeMenuItem(null,true);
		}
		
		private function createViewMenu():NativeMenu {
			var viewMenu:NativeMenu = new NativeMenu();
			viewMenu.addItem( newMenuItem( "Inbox", viewInbox, "1" ) );
			viewMenu.addItem( newMenuItem( "Providers", viewProviders, "2" ) );
			viewMenu.addItem( newMenuItem( "Debug", viewDebug, "3" ) );
			return viewMenu;
		}
		
		private function createToolsMenu():NativeMenu {
			
			var menu:NativeMenu = new NativeMenu();
			menu.addItem( newMenuItem( "Preferences...", handlePrefsClick,"," ) );
			return menu;
		}
		
		private function viewInbox(event:Event):void {
			dispatchEvent( new ViewChangeEvent(ViewChangeEvent.INBOX) );
		}
		
		private function viewProviders(event:Event):void {
			dispatchEvent( new ViewChangeEvent(ViewChangeEvent.PROVIDER) );
		}
		
		private function viewDebug(event:Event):void {
			dispatchEvent( new ViewChangeEvent(ViewChangeEvent.DEBUG) );
		}
		
		/**
		 * Dispatches an event that causes the prefs dialog to pop up.
		 */
		private function handlePrefsClick(event:Event):void {
			var window:PrefsWindow = new PrefsWindow();
			context.viewManager.addViewRoot(window);
			window.open();
		}
		
		private function createFileMenu():NativeMenu {
			
			var fileMenu:NativeMenu = new NativeMenu();
			/*
			fileMenu.addItem( newMenuItem( "Load Library", loadLibrary ) );
			fileMenu.addItem( newMenuItem( "Save Library", saveLibrary ) );
			fileMenu.addItem( newSeparator() );
			fileMenu.addItem( newMenuItem( "Import Feed List...", importFeedsHandler ) );
			fileMenu.addItem( newMenuItem( "Export Feed List...", exportFeedsHandler ) );
			fileMenu.addItem( newSeparator() );
			fileMenu.addItem( newMenuItem( "Clear Feed Results...", clearFeedHandler ) );
			fileMenu.addItem( newMenuItem( "Delete Attachments...", deleteAttachmentsHandler ) );
			fileMenu.addItem( newSeparator() );
			fileMenu.addItem( newMenuItem( "View Item...", viewItemHandler ) );
			*/
			fileMenu.addItem( newMenuItem( "Preferences...", handlePrefsClick,"," ) );
			/*
			fileMenu.addItem( newSeparator() );
			fileMenu.addItem( newMenuItem( "Debug...", debugHandler ) );
			*/
			return fileMenu;
		}
		
		private function handleMenuClick(e:Event) :void {
			var menuItem:NativeMenuItem = e.target as NativeMenuItem;
			trace( "Menu command = " + menuItem.label );
			/*       
			if(menuItem.label == "Minimize") 
			this.minimize();
			
			if(menuItem.label == "Maximize") 
			this.maximize();
			
			if(menuItem.label == "Restore") 
			this.restore();
			
			if(menuItem.label == "Close") 
			this.close();
			*/
		}
		
		/*
		private function viewItemHandler(event:Event):void {
		var popup:CTestItem = new CTestItem();
		popup.open();
		}
		
		private function saveLibrary(event:Event):void {
		CairngormEventDispatcher.getInstance().dispatchEvent(new PrefsWriteEvent());			
		}
		private function loadLibrary(event:Event):void {
		CairngormEventDispatcher.getInstance().dispatchEvent(new LibraryReadEvent(true));			
		}
		
		private function debugHandler(event:Event):void {
		var folder:File = File.desktopDirectory;
		var file:File = folder.resolvePath( "test.emlx" );
		var mailFile:MailFile = new MailFile();
		mailFile.read( file );
		mailFile.write( folder.resolvePath( "testout.emlx" ) );
		var x:String = "breakpoint line";
		}
		
		private function importFeedsHandler(event:Event):void {
		if( EPDocRSSModelLocator.getInstance().rootFolder == null ||
		!EPDocRSSModelLocator.getInstance().rootFolder.exists ) {
		Alert.show( "No Root Folder defined. Please use preferences to define a root folder.", "Error" );
		return;
		}
		var file:File = EPDocRSSModelLocator.getInstance().rootFolder.clone();
		file.browseForOpen("RSS Feed List file");
		file.addEventListener( Event.SELECT, openRSSList );
		}
		
		private function openRSSList(event:Event):void {
		var file:File = event.target as File;
		Library.readRSSList(file);
		}
		
		
		private function exportFeedsHandler(event:Event):void {
		var file:File = EPDocRSSModelLocator.getInstance().rootFolder.clone();
		file.browseForSave( "Save RSS URL List" );
		file.addEventListener( Event.SELECT, saveRSSList );
		}
		
		private function saveRSSList(event:Event):void {
		var file:File = event.target as File;
		if( file.exists ) {
		Alert.show("Overwrite existing file?","Confirm",Alert.OK|Alert.CANCEL,null,confirmOverwriteHandler);
		_file = file;
		} else {
		Library.writeRSSList(file);
		}
		}
		
		private function confirmOverwriteHandler(event:CloseEvent):void {
		if( event.detail == Alert.OK && _file != null )
		Library.writeRSSList(_file);
		_file = null
		}
		
		private function clearFeedHandler(event:Event):void {
		Alert.show("Clear feed results?","Confirm",Alert.OK|Alert.CANCEL,null,confirmClearHandler);
		}
		
		private function confirmClearHandler(event:CloseEvent):void {
		if( event.detail == Alert.OK )
		Library.clearFeeds();
		}
		
		private function deleteAttachmentsHandler(event:Event):void {
		Alert.show("Delete all file attachments in root folder?\n\nReally?",
		"Confirm",Alert.OK|Alert.CANCEL,null,confirmDeleteAttachmentsHandler);
		}
		
		private function confirmDeleteAttachmentsHandler(event:CloseEvent):void {
		if( event.detail == Alert.OK )
		Library.deleteAllAttachments();
		}
		/**
		* Save preference settings and exit the app.
		*
		private function handleQuitClick(event:Event):void {
		//var prefsEvent:PrefsWriteEvent = new PrefsWriteEvent();
		//prefsEvent.bAppExitOnWrite = true;
		//CairngormEventDispatcher.getInstance().dispatchEvent(prefsEvent);			
		}
		
		private function handleAboutClick(event:Event):void {
		var popup:About = new About();
		popup.open();
		}
		*/
		
	}
}