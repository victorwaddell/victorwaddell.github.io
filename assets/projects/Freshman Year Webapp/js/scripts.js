 function validate(){
    var zipcode = $("#zipcode").val();
    if(zipcode.length != 5 || isNan(zipcode)){
        alert("Zipcode is not valid or not correctly formated.");
        return false;
    }

    var phone = $("#phone").val();
    if(phone.length != 10 || isNan(phone)){
        alert("Phone number is not valid or not correctly formated.");
        return false;
    }
}
