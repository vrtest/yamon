window.onload = function(){
	new JsDatePick({ useMode:2, target:"dfrom" });
	new JsDatePick({ useMode:2, target:"dto" });
};

function checkallfields() {
	for(e=0; e<document.myform.elements.length;e++) {
		if((document.myform.elements[e].type== "checkbox")){
			document.myform.elements[e].checked=true;
		}
    }
};
  
function lastnight() {
	var myDate = new Date();
	document.filterForm.dmin.value=10;
	document.filterForm.limit.value=500;
	document.filterForm.dfrom.value=myDate.getFullYear()+'-'+
                                    (myDate.getMonth()+1)+'-'+
                                    (myDate.getDate()-1)+' 19:00';
	document.filterForm.dto.value=myDate.getFullYear()+'-'+
                                  (myDate.getMonth()+1)+'-'+
                                  myDate.getDate()+' 09:00';
};
