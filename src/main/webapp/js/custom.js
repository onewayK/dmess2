$(document).ready(function(){
	
			
	
			
	/* ---------- Acivate Functions ---------- */
	$("#overlay").delay(1250).fadeOut(500);
	template_functions();
	widthFunctions();


	
	
});





/* ---------- Template Functions ---------- */		
		
function template_functions(){
	


	/* ---------- Makes elements soratble, elements that sort need to have id attribute to save the result ---------- */
	$('.sortable').sortable({
		revert:true,
		cancel:'.btn,.box-content,.nav-header,.sub_box',
		update:function(event,ui){
			//line below gives the ids of elements, you can make ajax call here to save it to the database
			//console.log($(this).sortable('toArray'));
		}
	});

	/* ---------- Datapicker ---------- */
	if($('.datepicker')) {
		
		$('.datepicker').datepicker();
		
	}

	/* ---------- Fullscreen ---------- */
	$('#toggle-fullscreen').button().click(function () {
		var button = $(this), root = document.documentElement;
		if (!button.hasClass('active')) {
			$('#thumbnails').addClass('modal-fullscreen');
			if (root.webkitRequestFullScreen) {
				root.webkitRequestFullScreen(
					window.Element.ALLOW_KEYBOARD_INPUT
				);
			} else if (root.mozRequestFullScreen) {
				root.mozRequestFullScreen();
			}
		} else {
			$('#thumbnails').removeClass('modal-fullscreen');
			(document.webkitCancelFullScreen ||
				document.mozCancelFullScreen ||
				$.noop).apply(document);
		}
	});
	
	/**
	$('.btn-detail').click(function(e){
		e.preventDefault();
		$('#myModal').modal('show');
	});
	**/
	
	/* ---------- Datable ----------
	$('.datatable').dataTable({
			"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'i><'span12 center'p>>",
			"sPaginationType": "bootstrap",
			"oLanguage": {
			"sLengthMenu": "_MENU_ records per page"
			}
		} );
	$('.btn-close').click(function(e){
		e.preventDefault();
		$(this).parent().parent().parent().fadeOut();
	});
	$('.btn-minimize').click(function(e){
		e.preventDefault();
		var $target = $(this).parent().parent().next('.box-content');
		if($target.is(':visible')) $('i',$(this)).removeClass('fa-icon-chevron-up').addClass('fa-icon-chevron-down');
		else 					   $('i',$(this)).removeClass('fa-icon-chevron-down').addClass('fa-icon-chevron-up');
		$target.slideToggle();
	});
	
	$('.btn-open').click(function(e){
		e.preventDefault();
		var $target = $(this).parent().parent().next('.sub_box');
		if($target.is(':visible')) $('i',$(this)).removeClass('fa-icon-minus').addClass('fa-icon-plus');
		else 					   $('i',$(this)).removeClass('fa-icon-plus').addClass('fa-icon-minus');
		$target.slideToggle();
	});
	
	$('.btn-detail').click(function(e){
		e.preventDefault();
		$('#myModal').modal('show');
	});
	$('.btn-board').click(function(e){
		e.preventDefault();
		$('#myModal2').modal('show');
	});
	
	 */
			
}
       





/* ---------- Page width functions ---------- */

$(window).bind("resize", widthFunctions);

function widthFunctions( e ) {
    var winHeight = $(window).height();

	if (winHeight) {
		
		$("#PageHeight").css("min-height",winHeight-100);
		
	}
    
	

}




