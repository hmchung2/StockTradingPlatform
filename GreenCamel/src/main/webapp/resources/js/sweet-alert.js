/**
 * 
 */
const myAlarm = function(fullMsg){
	let arr = fullMsg.split(":");
	if(arr[0] == "basic" ){
		swal(arr[1], arr[2])
	}else if(arr[0] == "warning" ){
		swal({   
            title: arr[1],   
            text: arr[2],   
            type: "warning",   
            showCancelButton: false,   
            confirmButtonColor: "#DD6B55",   
            confirmButtonText: "확인",   
            closeOnConfirm: true 
        });
	} else if(arr[0] == "success"){
		swal(arr[1], arr[2], "success")
	}else{
		swal(arr[arr.length-1])
	}	
}

