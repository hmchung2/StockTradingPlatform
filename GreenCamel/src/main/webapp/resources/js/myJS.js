/**
 * Form check 과 관련된 라이브러리.
 */

function isNull(obj ,str){
		if(obj.value ==""){
			alert(str)
			obj.focus()
			return true
		}
		return false
	}

