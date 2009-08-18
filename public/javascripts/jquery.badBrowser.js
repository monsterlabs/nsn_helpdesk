function badBrowser(){
	// Check for Microsoft Internet Explorer < 8.0
	if ($.browser.msie) {
	  if (parseInt($.browser.version, 10) <= 7) {
	    return true
	  }
		return false;
	}
	// Check for Opera
	if ($.browser.opera) {
		return true;
	}
	// Check for Mozilla Firefox 2.0
	if (/firefox[\/\s](\d+\.\d+)/.test(userAgent)) {
		var ffversion = Number(RegExp.$1);
		if (ffversion < 3) {
			return true;
		}
	}
	// Check for Safari < Version 4.0
	if (/safari[\/\s](\d+\.\d+)/.test(userAgent) && !/chrome[\/\s](\d+\.\d+)/.test(userAgent)) {
		var safari = userAgent.indexOf('version');
		if (safari > -1) {
			var snip1 = safari+8;
			var version = userAgent.substring(snip1, (snip1+1));
			if (version < 4) {
				return true;
			}
		}
	}
	// Check for Chrome < Version 2.0
	var chrome = userAgent.indexOf('chrome');
	if (chrome > -1) {
		var snip1 = chrome+7;
		var version = userAgent.substring(snip1, (snip1+1));
		if (version < 2) {
			return true;
			}
	}
	
	return false;
}

if(badBrowser()){
	$(function(){
		$("<div id='browserWarning'>You are using an unsupported browser. "+
		    "Please use the mos recient version of:&nbsp;" + 
		      "<a href='http://www.apple.com/safari/'><img title='Safari 4' src='/images/Safari.png' /></a>&nbsp;&nbsp;"+
		      "<a href='http://www.mozilla.com/firefox/'><img title='Firefox 3' src='/images/firefox.png' /></a>&nbsp;"+
		      "<a href='http://www.google.com/chrome/'><img title='Google Chrome' src='/images/google-chrome.png' /></a>&nbsp;"+
		      "<a href='http://www.microsoft.com/windows/internet-explorer/default.aspx'><img title='Internet Explorer 8' src='/images/explorer.png'/></a>")
			.prependTo("body");
	});	
}
