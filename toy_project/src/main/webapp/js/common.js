//gfn_isNull() : str으로 들어오는 값이 null인지 아닌지 체크해주는 함수
function gfn_isNull(str){
    if(str == null)
        return true;
    if(str == "NaN")
        return true;
    if(new String(str).valueOf() == "undefined")
        return true;
    
    var chkStr = new String(str);
    if(chkStr.valueOf() == "undefined")
        return true;
    if(chkStr == null)
        return true;
    if(chkStr.toString().length == 0)
        return true;

    return false;
}

//ComSubmit() : 함수안에 <form>태그의 id값을 넣어서, null인지 아닌지 체크해주는 함수
function ComSubmit(opt_formId){
    //form태그 id가 null이면 commonForm이라고 이름붙이고, id가 있으면 가져온 폼 이름 붙여주기
    this.formId = gfn_isNull(opt_formId) == true ? "commonForm" : opt_formId; 
    this.url = "";
    
    if(this.formId == "commonForm"){  //폼Id가 commonForm일경우
        $("#commonForm")[0].reset(); //commonForm안에있는 내용 모두 리셋 시키기
    }
    
    this.setUrl = function setUrl(url){
        this.url = url;
    };
    
    //이름(key)과 값(value)를 넣어주면, 폼태그 안에 아래 <input> 히든태그 추가
    this.addParam = function addParam(key, value){
        $("#"+this.formId).append($("<input type='hidden' name='"+key+"' id='"+key+"' value='"+value+"' >"));
    };
    
    //submit() : 폼에 대한 설정이 끝나면, action이랑 method 설정해서 전송
    this.submit = function submit(){
        var frm = $("#"+this.formId)[0];
        frm.action = this.url;
        frm.method = "post";
        frm.submit();
    };
}
