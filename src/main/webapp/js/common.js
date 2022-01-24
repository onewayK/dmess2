/****************************************************************
 * 
 * 파일명 : common.js
 * 설  명 : 공통js
 * 
 *    수정일      수정자     Version        Function 명
 * ------------    ---------   -------------  ----------------------------
 * 2015-04-09	권건보 1.0
 * 
 * 
 *      **************************************************************/

/**
	유니크키 생성
**/
function unikey()
{
	var temp1 = Math.floor(Math.random() * 100000) + 1;
	var rand = randNum();

	return temp1+rand;
}

/**
 * replaceAll 지정 prototype지정
 */
String.prototype.replaceAll = function(target, replacement) {
	  return this.split(target).join(replacement);
};

function randNum(){
 var ALPHA = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9'];
 var rN='';
 for(var i=0; i<20; i++){
  var randTnum = Math.floor(Math.random()*ALPHA.length);
  rN += ALPHA[randTnum];
 }
 return rN;
}



/**
 * 
 * @param url
 * @param width
 * @param height
 */
function fn_openwindow(url, width, height, page_id)
{

	
	if(page_id =="fn_capture_popup")
	{
		var option = 'scrollbars=no,toolbar=no,resizable=yes,fullscreen=yes,left=0,top=0';
	}
	else
	{
		var option = 'scrollbars=no,toolbar=no,resizable=yes,width='+width+',height='+height+',left=0,top=0';
	}
	
	
	var win = null;
	win = window.open(url ,page_id,option);
	win.focus();
}

/**
 * 
 * @param url
 * @param width
 * @param height
 */
function fn_openwindow2(url, width, height, page_id)
{
	var option = 'scrollbars=auto,toolbar=no,resizable=yes,width='+width+',height='+height+',left=0,top=0';
	var win = null;
	win = window.open(url ,page_id,option);
	win.focus();
}


function dateAdd(date, interval, units) {
	  var ret = new Date(date); //don't change original date
	  switch(interval.toLowerCase()) {
	    case 'year'   :  ret.setFullYear(ret.getFullYear() + units);  break;
	    case 'quarter':  ret.setMonth(ret.getMonth() + 3*units);  break;
	    case 'month'  :  ret.setMonth(ret.getMonth() + units);  break;
	    case 'week'   :  ret.setDate(ret.getDate() + 7*units);  break;
	    case 'day'    :  ret.setDate(ret.getDate() + units);  break;
	    case 'hour'   :  ret.setTime(ret.getTime() + units*3600000);  break;
	    case 'minute' :  ret.setTime(ret.getTime() + units*60000);  break;
	    case 'second' :  ret.setTime(ret.getTime() + units*1000);  break;
	    default       :  ret = undefined;  break;
	  }
	  return ret;
}


function dbDatetoLong(d)
{
	value = d;
	var year = value.substring(0, 4);
	var month = value.substring(5, 7);
	var day = value.substring(8, 10);
	var hour = value.substring(11, 13);
	var minute = value.substring(14, 16);
	var second = value.substring(17, 19);
	
	return year+month+day+hour+minute+second;
}

/**
 * 미리보기
 * @param form
 * @returns {Boolean}
 */
function preViewHtml(html, title ,option) {
    
	if(option=="")
	{
		option = "top=100px, left=100px, height=800px, width=800px";
	}
	
	var preview = window.open('','preview',option);
    preview.document.write(html);
    preview.document.title = title;
    preview.document.close();
    return true;
}


function tag_valid(str)
{
	if(str!=null || str!=""){
		str=str.replace("\'\g", "&#39;");
		str=str.replace("\"\g", "&quot;");		
	}
	
	return str;
}

function ban_tag_valid(str)
{
	var boolean = false;
	var regexp = new RegExp("\"");
	
	if(regexp.test(str)){
		boolean=true;
	}
	
	return boolean;
}


/**
 * 날짜 차이 계산
 * @param form
 * @returns {Boolean}
 */
function dateDiff(_date1, _date2) {

    var diffDate_1 = _date1 instanceof Date ? _date1 : new Date(_date1);
    var diffDate_2 = _date2 instanceof Date ? _date2 : new Date(_date2);
    
    diffDate_1 = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth()+1, diffDate_1.getDate());
    diffDate_2 = new Date(diffDate_2.getFullYear(), diffDate_2.getMonth()+1, diffDate_2.getDate());

 
    var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
    diff = Math.ceil(diff / (1000 * 3600 * 24));

    return diff;

}

