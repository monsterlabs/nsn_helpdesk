/*
	jQuery floating header plugin v1.0.5
	Licenced under the MIT License	
	Copyright (c) 2009 
		Erik Bystrom <erik.bystrom@gmail.com>
		Elias Bergqvist <elias@basilisk.se>		

	Contributors:
		Diego Arbelaez <diegoarbelaez@gmail.com>
*/ 
(function($){
	/**
	 * Clone the table header floating and binds its to the browser scrolling
	 * so that it will be displayed when the original table header is out of sight.
	 *
	 * @param config
	 *		An optional dictionary with configuration for the plugin.
	 *		
	 *		fadeOut		The length of the fade out animation in ms. Default: 250
	 *		faceIn		The length of the face in animation in ms. Default: 250
	 *		forceClass	Forces the plugin to use the markerClass instead of thead. Default: false
	 *		markerClass The classname to use when marking which table rows that should be floating. Default: floating
	 *		floatClass	The class of the div that contains the floating header. The style should
	 *					contain an appropriate z-index value. Default: 'floatHeader'
	 *		cbFadeOut	A callback that is called when the floating header should be faded out.
	 *					The method is called with the wrapped header as argument.
	 *		cbFadeIn	A callback that is called when the floating header should be faded in.
	 *					The method is called with the wrapped header as argument.
	 *
	 * @version 1.0.5
	 * @see http://slackers.se/2009/jquery-floating-header-plugin
	 */
	$.fn.floatHeader = function(config) {
		config = $.extend({
			fadeOut: 250,
			faceIn: 250,
			forceClass: false,
			markerClass: 'floating',
			floatClass: 'floatHeader'
		}, config);	
		
		return this.each(function () {
			var self = $(this);
			var table = self.clone();
			table.children().remove();
			
			self.floatBox = $('<div class="'+config.floatClass+'"style="display:none"></div>');
			self.floatBox.append(table);
			
			// create the floater
			createFloater(table, self, config);
						
			// bind to the scroll event
			$(window).scroll(function() {		
				if (self.floatBoxVisible) {		
					if (!showHeader(self)) {
						// kill the floatbox			
						var offset = self.offset();
						self.floatBox.css('position', 'absolute');
						self.floatBox.css('top', offset.top);
						self.floatBox.css('left', offset.left);					
						
						self.floatBoxVisible = false;
						if (config.cbFadeOut) {
							config.cbFadeOut(self.floatBox);
						} else {
							self.floatBox.fadeOut(config.fadeOut);
						}					
					}
				} else {
				  if (showHeader(self)) {								
					self.floatBoxVisible = true;

					// show the floatbox
					self.floatBox.css('position', 'fixed');
					
					if (config.cbFadeIn) {
						config.cbFadeIn(self.floatBox);
					} else {
						self.floatBox.fadeIn(config.faceIn);
					}
				  }
				}
				
				// if the box is visible update the position
				if (self.floatBoxVisible) {
					self.floatBox.css('top', 0);
					self.floatBox.css('left', self.offset().left-$(window).scrollLeft());					
				}
			});
			
			// bind to the resize event
			$(window).resize(function() {		
				// recreate the floating table
				table.children().remove();
				createFloater(table, self, config);
			});			
			
			// append the floatBox to the dom
            $(self).after(self.floatBox);			
		});
	};
	
	/**
	 * Copies the template and inserts each element into the target.
	 */
	function createFloater(target, template, config) {
		target.width(template.width());
		
		var items;
		if (!config.forceClass && template.children('thead').length > 0) {
			// set the template to the children of thead
			items = template.children('thead').eq(0).children();				
		} else {
			// set the template to the class marking
			items = template.find('.'+config.markerClass);
		}		
		
		// iterate though each row that should be floating
		items.each(function() {
			var row = $(this);
			var floatRow = row.clone();
			floatRow.children().remove();

			// adjust the column width for each header cell
			row.children().each(function() {
				var cell = $(this);
				var floatCell = cell.clone();

				floatCell.css('width', cell.width());
				floatRow.append(floatCell);
			});

			// append the row to the table
			target.append(floatRow);
		});	
	}
	
	/**
	 * Determines if the element is visible
	 */
	function showHeader(element) {
		var top = $(window).scrollTop();
		var y0 = $(element).offset().top;
		return y0 <= top && top <= y0 + $(element).height();
	}
})(jQuery);
