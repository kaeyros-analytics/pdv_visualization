// duration of scroll animation
var scrollDuration = 300;
// paddles
var leftPaddle = document.getElementById('left-paddle');
var rightPaddle = document.getElementById('right-paddle');
// get items dimensions
var itemsLength = $('.itemVariable').length;
console.log(itemsLength)
var itemSize = $('.itemVariable').outerWidth(true);
console.log("=================== itemSize =============");
console.log(itemSize);
// get some relevant size for the paddle triggering point
var paddleMargin = 20;

// get wrapper width
var getMenuWrapperSize = function() {
	return $('.menu-wrapper').outerWidth();
}

var menuWrapperSize = getMenuWrapperSize();
// the wrapper is responsive
$(window).on('resize', function() {
	menuWrapperSize = getMenuWrapperSize();
    
});
// size of the visible part of the menu is equal as the wrapper size 
var menuVisibleSize = menuWrapperSize;

// get total width of all menu items
var getMenuSize = function() {
	return itemsLength * itemSize + 305;
};
var menuSize = getMenuSize();
// get how much of menu is invisible
var menuInvisibleSize = menuSize - menuWrapperSize;

// get how much have we scrolled to the left
var getMenuPosition = function() {
	return $('.menuVariable').scrollLeft();
};

// finally, what happens when we are actually scrolling the menu
$('.menuVariable').on('scroll', function() {

	// get how much of menu is invisible
	menuInvisibleSize = menuSize - menuWrapperSize;
	// get how much have we scrolled so far
	var menuPosition = getMenuPosition();

	var menuEndOffset = menuInvisibleSize - paddleMargin;

	// show & hide the paddles 
	// depending on scroll position

    console.log(menuPosition +" == " + paddleMargin)
    console.log(menuPosition <= paddleMargin)
    console.log(menuPosition + 100 +" == " + menuEndOffset)
    console.log(menuPosition + 100 < menuEndOffset)
    console.log(menuPosition + 100 +" == " + menuEndOffset)
    console.log(menuPosition + 100 >= menuEndOffset)

	if (menuPosition <= paddleMargin) {
		$(leftPaddle).addClass('hidden');
		$(rightPaddle).removeClass('hidden');
	} else if (menuPosition + 100 < menuEndOffset) {
		// show both paddles in the middle
		$(leftPaddle).removeClass('hidden');
		$(rightPaddle).removeClass('hidden');
	} else if (menuPosition + 100 >= menuEndOffset) {
        console.log("=========================== close end")
		$(leftPaddle).removeClass('hidden');
		$(rightPaddle).addClass('hidden');
    }

});

let scrollPosition = 0;

// scroll to left
$(rightPaddle).on('click', function() {
    
    scrollPosition += itemSize;
	$('.menuVariable').animate( { scrollLeft: scrollPosition}, scrollDuration);
});

// scroll to right
$(leftPaddle).on('click', function() {
	
    scrollPosition -= itemSize;
	$('.menuVariable').animate( { scrollLeft: scrollPosition }, scrollDuration);
	
});

/*function init() {
  $('#plot1').show();
  $('#plot2').hide();
  $('#plot3').hide();
  $('#plot4').hide();
  $('#plot5').hide();
  $('#plot6').hide();
  $('#plot7').hide();
  $('#plot8').hide();
  
  $('#var-1').show();
  $('#var-2').hide();
  $('#var-3').hide();
  $('#var-4').hide();
  $('#var-5').hide();
  $('#var-6').hide();
  $('#var-7').hide();
  $('#var-8').hide();
}*/


 /* $('#plot1').show();
  $('#plot2').show();
  $('#plot3').show();
  $('#plot4').show();
  $('#plot5').show();
  $('#plot6').show();
  $('#plot7').show();
  $('#plot8').show();
  
  $('#var-1').show();
  $('#var-2').show();
  $('#var-3').show();
  $('#var-4').show();
  $('#var-5').show();
  $('#var-6').show();
  $('#var-7').show();
  $('#var-8').show();*/
  
setTimeout(function() {
  /*$('#plot1').show();
  $('#plot2').hide();
  $('#plot3').hide();
  $('#plot4').hide();
  $('#plot5').hide();
  $('#plot6').hide();
  $('#plot7').hide();
  $('#plot8').hide();
  
  $('#var-1').show();
  $('#var-2').hide();
  $('#var-3').hide();
  $('#var-4').hide();
  $('#var-5').hide();
  $('#var-6').hide();
  $('#var-7').hide();
  $('#var-8').hide();*/

}, 1000);


//all item
var item1 = document.getElementById('item-1');
var item2 = document.getElementById('item-2');
var item3 = document.getElementById('item-3');
var item4 = document.getElementById('item-4');
var item5 = document.getElementById('item-5');
var item6 = document.getElementById('item-6');
var item7 = document.getElementById('item-7');
var item8 = document.getElementById('item-8');


//click on card item
/*$(item1).on('click', function() {
	$('#plot1').show();
  $('#plot2').hide();
  $('#plot3').hide();
  $('#plot4').hide();
  $('#plot5').hide();
  $('#plot6').hide();
  $('#plot7').hide();
  $('#plot8').hide();
  
  $('#var-1').show();
  $('#var-2').hide();
  $('#var-3').hide();
  $('#var-4').hide();
  $('#var-5').hide();
  $('#var-6').hide();
  $('#var-7').hide();
  $('#var-8').hide();
  
  
});

$(item2).on('click', function() {
	$('#plot2').show();
  $('#plot1').hide();
  $('#plot3').hide();
  $('#plot4').hide();
  $('#plot5').hide();
  $('#plot6').hide();
  $('#plot7').hide();
  $('#plot8').hide();
  
  $('#var-2').show();
  $('#var-1').hide();
  $('#var-3').hide();
  $('#var-4').hide();
  $('#var-5').hide();
  $('#var-6').hide();
  $('#var-7').hide();
  $('#var-8').hide();
});

$(item3).on('click', function() {
	$('#plot3').show();
  $('#plot1').hide();
  $('#plot2').hide();
  $('#plot4').hide();
  $('#plot5').hide();
  $('#plot6').hide();
  $('#plot7').hide();
  $('#plot8').hide();
  
  $('#var-3').show();
  $('#var-1').hide();
  $('#var-2').hide();
  $('#var-4').hide();
  $('#var-5').hide();
  $('#var-6').hide();
  $('#var-7').hide();
  $('#var-8').hide();
});

$(item4).on('click', function() {
	$('#plot3').hide();
  $('#plot1').hide();
  $('#plot2').hide();
  $('#plot4').show();
  $('#plot5').hide();
  $('#plot6').hide();
  $('#plot7').hide();
  $('#plot8').hide();
  
  $('#var-3').hide();
  $('#var-1').hide();
  $('#var-2').hide();
  $('#var-4').show();
  $('#var-5').hide();
  $('#var-6').hide();
  $('#var-7').hide();
  $('#var-8').hide();
});

$(item5).on('click', function() {
	$('#plot3').hide();
  $('#plot1').hide();
  $('#plot2').hide();
  $('#plot4').hide();
  $('#plot5').show();
  $('#plot6').hide();
  $('#plot7').hide();
  $('#plot8').hide();
  
  $('#var-3').hide();
  $('#var-1').hide();
  $('#var-2').hide();
  $('#var-4').hide();
  $('#var-5').show();
  $('#var-6').hide();
  $('#var-7').hide();
  $('#var-8').hide();
});

$(item6).on('click', function() {
	$('#plot3').hide();
  $('#plot1').hide();
  $('#plot2').hide();
  $('#plot4').hide();
  $('#plot5').hide();
  $('#plot6').show();
  $('#plot7').hide();
  $('#plot8').hide();
  
  $('#var-3').hide();
  $('#var-1').hide();
  $('#var-2').hide();
  $('#var-4').hide();
  $('#var-5').hide();
  $('#var-6').show();
  $('#var-7').hide();
  $('#var-8').hide();
});

$(item7).on('click', function() {
	$('#plot3').hide();
  $('#plot1').hide();
  $('#plot2').hide();
  $('#plot4').hide();
  $('#plot5').hide();
  $('#plot6').hide();
  $('#plot7').show();
  $('#plot8').hide();
  
  $('#var-3').hide();
  $('#var-1').hide();
  $('#var-2').hide();
  $('#var-4').hide();
  $('#var-5').hide();
  $('#var-6').hide();
  $('#var-7').show();
  $('#var-8').hide();
});

$(item8).on('click', function() {
	$('#plot3').hide();
  $('#plot1').hide();
  $('#plot2').hide();
  $('#plot4').hide();
  $('#plot5').hide();
  $('#plot6').hide();
  $('#plot7').hide();
  $('#plot8').show();
  
  $('#var-3').hide();
  $('#var-1').hide();
  $('#var-2').hide();
  $('#var-4').hide();
  $('#var-5').hide();
  $('#var-6').hide();
  $('#var-7').hide();
  $('#var-8').show();
});*/
