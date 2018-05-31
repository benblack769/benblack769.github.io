AWS.config.region = 'us-west-2'; // Region
AWS.config.credentials = new AWS.CognitoIdentityCredentials({
    IdentityPoolId: 'us-west-2:f6649357-417f-443c-8a4f-c853855d44ad',
});
function checkposint(num_str){
    return /^(0|[1-9]\d*)$/.test(num_str)
}
function check_num(num_str){
    return num_str
}
function check_non_neg(num_str){
    return num_str && Number(num_str) >= 0
}
function verify_user_args(){
    retval = true;
    if(!(checkposint(document.getElementById('Mval').value))){
        $("#Mvalerr").show()
        retval = false
    }
    if(!(checkposint(document.getElementById('Nval').value))){
        $("#Nvalerr").show()
        retval = false
    }
    if(!(checkposint(document.getElementById('Pval').value))){
        $("#Pvalerr").show()
        retval = false
    }
    if(!(checkposint(document.getElementById('RedSurvival').value) &&
         checkposint(document.getElementById('BlueSurvival').value))){
        $("#Survivalerr").show()
        retval = false
    }
    if(!(checkposint(document.getElementById('RedStart').value) &&
         checkposint(document.getElementById('BlueStart').value))){
        $("#Starterr").show()
        retval = false
    }
    if(!(check_non_neg(document.getElementById('Aval').value))){
        $("#Cvalerr").show()
        retval = false
    }
    if(!(check_num(document.getElementById('Cval').value))){
        $("#Cvalerr").show()
        retval = false
    }
    return retval
}
function hide_all(){
    $("#Mvalerr").hide()
    $("#Nvalerr").hide()
    $("#Pvalerr").hide()
    $("#Survivalerr").hide()
    $("#Starterr").hide()
    $("#Cvalerr").hide()
}
function place_text_on_svg(text){
    document.getElementById("svg_item").innerHTML = text
}
function load_svg(){
    hide_all()
    if(!verify_user_args()){
        place_text_on_svg("Bad user input")
        return false;
    }
    place_text_on_svg("Loading...")
    console.log("kjnasdasd");

    var result = {
        'Mval': document.getElementById('Mval').value,
        'Nval': document.getElementById('Nval').value,
        'Pval': document.getElementById('Pval').value,
        'RedSurvival': document.getElementById('RedSurvival').value,
        'BlueSurvival': document.getElementById('BlueSurvival').value,
        'RedStart': document.getElementById('RedStart').value,
        'BlueStart': document.getElementById('BlueStart').value,
        'Aval': document.getElementById('Aval').value,
        'Cval': document.getElementById('Cval').value,
        'should_run_fast': document.getElementById('fast_checkbox').checked ? "true" : "false",
    }

    console.log(result)
    var pullParams = {
      FunctionName : 'geneology_lambda_function',
      InvocationType : 'RequestResponse',
      LogType : 'None',
      Payload: JSON.stringify(result),
    };
    var lambda = new AWS.Lambda({region: 'us-west-2', apiVersion: '2015-03-31'});
    lambda.invoke(pullParams, function(error, data) {
      if (error) {
          place_text_on_svg("Server Error")
        prompt(error);
      } else {
        data = JSON.parse(data.Payload);
        if (data.success){
            html_code = JSON.parse(data.success);
            //console.log(html_code)

            var container = document.getElementById("svg_item");
            container.innerHTML = html_code;
        }
      }
  });
    return true;
}

$( document ).ready(function(){
    load_svg()
    console.log("lakfjlaksdjl")
    document.getElementById("submitbutton").onclick = load_svg
})
