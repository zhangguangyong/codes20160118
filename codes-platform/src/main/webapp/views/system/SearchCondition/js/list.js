$(function(){
	
	$.util.ajax({
		url: WEB_ROOT + '/system/SearchCondition/doList',
		success: function(result){
			console.info( result );
		}
	});
	
});