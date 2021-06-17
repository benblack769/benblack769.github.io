function setup_popup(){
    $("#popup").click(function(event) {
        $("#popup").hide()
    });
    $("#popup_body_id").click(function(event) {
        event.stopPropagation();
    });
    $("#popup_button").click(function(e){
        $("#popup").show()
    })
    $("#close_button").click(function(e){
        $('#popup').hide();
    })
}
function set_window_loc(node_name){
    window.location = (""+window.location).replace(/#[A-Za-z0-9_]*$/,'')+"#"+node_name
}
function node_changed(node_data,node_name){
    if(!node_name){
        node_name = node_data[0]['node']
    }
    var node_info = node_data.filter(function(x){return x['node'] === node_name})[0]

    setup_long_descript(node_info)

    //document.getElementById("svg_obj").data = "graphs/"+node_name+".svg"

    var svg_text = document.getElementById(node_name+"__svg").innerHTML
    document.getElementById("svg_obj").innerHTML = svg_text
    document.getElementById("title_loc").innerHTML = node_info['title']
    setup_state(node_data,node_name)
}
function setup_long_descript(node_info){
    document.getElementById("popup_content").innerHTML = ""
    if(node_info['node']){
        var node_fname = "/long_descriptions/"+node_info['node']+".md.html"
        // var obj = document.getElementById("hid_obj")
        // obj.data = node_fname
        //
        // console.log("hi there!")
        // function load(){
        //     console.log("loadded there!")
        //     var objdata = obj.contentDocument
        //     console.log(objdata)
        //     document.getElementById("popup_content").innerHTML = objdata
        // }
        // //$(obj).ready( load)
        // //$(obj).ready( load)
        // obj.onload = load

        $.get(node_fname,"",function(data){
            document.getElementById("popup_content").innerHTML = data
        })
    }
}
function setup_state(node_data,node_name){
    var parent_div = document.getElementById("graphdis")
    var svg_obj = document.getElementById("svg_obj");
    var svg = svg_obj.firstChild;
    var elipse_el = $("#"+node_name+"__el ellipse").get()[0];
    //var elipse_el =
    var graph_div = document.getElementById("svg_container");
    //set the size and position of the parent div
    //graph_div.style.position = "absolute";
    console.log(svg.width.baseVal.value)
    var swidth = svg.width.baseVal.value;//svg.width.substring(svg.width.length-2)
    var sheight = svg.height.baseVal.value;//svg.width.substring(svg.height.length-2)
    console.log(swidth)
    graph_div.style.width = (swidth * 2 - 100) + "px";
    graph_div.style.height = (sheight * 2 - 100) + "px";

    svg_obj.style.position = "relative"
    svg_obj.style.top = sheight/2+"px";
    svg_obj.style.left = swidth/2+"px";
    //graph_div.style.left = (-svg.width + 100) + "px";
    //graph_div.style.top = (-svg.height + 100) + "px";

    //set position of svg so that current node is centered
    //svg_obj.style.pos
    //var elmnt = document.getElementById("content");
    //elipse_el.scrollIntoView();
    var elipse_bounds = elipse_el.getBoundingClientRect();
    var parent_bounds = graph_div.getBoundingClientRect();
    var view_size = parent_div.getBoundingClientRect();
    var cenx = (elipse_bounds.left + elipse_bounds.right)/2
    var ceny = (elipse_bounds.top + elipse_bounds.bottom)/2
    var destx = (-view_size.left + view_size.right)/2
    var desty = (-view_size.top + view_size.bottom)/2
    var scrollx = cenx-parent_bounds.left - destx
    var scrolly = ceny-parent_bounds.top - desty
    console.log(elipse_bounds)
    console.log(parent_bounds)
    console.log(view_size)
    if(parent_div.scroll){
        parent_div.scroll(scrollx, scrolly)
    }


    // get the inner element by id
    node_data.forEach(function(data){
        var name = data['node']

        var delta = document.getElementById(name+"__el");
        if(delta){
            // add behaviour
            delta.addEventListener("mousedown",function(){
                set_window_loc(name)
            }, false);
        }
    })
}
function check_window_resize(){
    var new_width = $('#display_area').parent().width();
    var old_class = document.getElementById("popup").className;
    if(old_class == "popup_global_shader" && new_width > 800){

    }
    else if(old_class != "popup_global_shader" && new_width < 800){

    }
}
function set_internal_link_nav(node_js_info){
    function listener(){
        node_changed(node_js_info,(''+window.location).split('#')[1])
    }
    window.addEventListener('popstate', listener);
}
$(document).ready(function(){
    var js_info_text = document.getElementById("js_node_info").innerHTML
    var node_js_info = JSON.parse(js_info_text)
    setup_popup()

    set_internal_link_nav(node_js_info)
    var start_name = (''+window.location).split('#')[1]
    if (!start_name){
        start_name = node_js_info[0]['node']
    }
    set_window_loc(start_name)
    //node_changed(node_js_info,(''+window.location).split('#')[1])
    //node_changed(node_js_info,node_js_info[0]['node'])
    //setup_initial_state(node_js_info)

    $(window).resize(check_window_resize);
})
