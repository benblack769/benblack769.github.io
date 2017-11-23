
function draw_plot(plot_data){
    MG.data_graphic({
        title: "Downloads",
        description: "This graphic shows a time-series of downloads.",
        data: plot_data, //[{'date':new Date('2014-11-01'),'value':12},
                        //{'date':new Date('2014-11-02'),'value':18}],
        width: 600,
        height: 250,
        target: '#stock_chart',
        x_accessor: 'date',
        y_accessor: 'open',
    })
}
function parse_line(line){
    var elements = line.split('\n');
    var old_date = elements[0];
    var new_date = new Date(old_date.slice(0,4), old_date.slice(4,6), old_date.slice(6,8));
    return {
        "date":new_date,
        "open":elements[2],
        "high":elements[3],
        "low":elements[4],
        "close":elements[5],
        "volume":elements[6],
    }
}
function parse_csv_into_elements(csv_string){
    var lines = csv_string.split('\n');
    return lines.map(parse_line)
}
function process_stock_name(name){
    $.ajax({
        url : "daily/table_"+name+".csv",
        success : function(result){
            draw_plot(parse_csv_into_elements(result))
        },
        error: function(result){
            console.log(result)
            alert("the stock data did not load properly");
        }
    });
}
function init_stock_options(){
    var select = document.getElementById('stock_options');
    stock_list.forEach(function(stock_name){
        var opt = document.createElement('option');
        opt.value = stock_name;
        opt.innerHTML = stock_name.toUpperCase();
        if(stock_name == "amzn"){
            opt.selected="selected"
        }
        select.appendChild(opt);
    })
}
window.onload = function(){
    $('#stock_options').change(function(){
        process_stock_name($("#stock_options").val())
    });
    init_stock_options()
}
