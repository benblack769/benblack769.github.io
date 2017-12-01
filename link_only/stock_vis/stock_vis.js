function stock_changes(stock_data){
    console.assert(stock_data.length > 0,"bad stock data")
    var res = [];
    var prev_day = stock_data[0];
    for(var i = 1; i < stock_data.length; i++){
        var new_day = stock_data[i];
        var cur_value = new_day.open > prev_day.open ? 1 : -1;
        res.push(cur_value);
        prev_day = new_day;
    }
    return res;
}
function process_stock_data(stock_changes_list,stock_predictor){
    return stock_changes_list.map(function(change){
        var guessed_val = stock_predictor.guess();
        console.assert(Math.abs(guessed_val) == 1,"bad stock predictor")
        stock_predictor.update(change);
        return guessed_val;
    })
}
function did_predict(actual_changes,predicted_changes){
    console.assert(actual_changes.length == predicted_changes.length,"bad changes lists")
    var num_changes = actual_changes.length;
    var res = new Array(num_changes);
    for(var i = 0; i < num_changes; i++){
        res[i] = actual_changes[i] == predicted_changes[i] ? 1 : 0;
    }
    return res;
}
function average_over_time(values,average_over_len){
    console.assert(average_over_len > 0,"bad len")

    var average_len_half = Math.floor(average_over_len/2)
    var num_values = values.length;

    var inc_val = Math.max(average_len_half,1);
    var averages = {};

    for(var i = 0; i < num_values; i += inc_val){
        var begin = Math.max(0,i-average_len_half)
        var end = Math.min(i+average_len_half,num_values-1)
        var cur_sum = 0;
        for(var j = begin; j < end; j++){
            cur_sum += values[j];
        }
        averages[i] = cur_sum / (end-begin);
    }
    return averages;
}
function get_plot_data(stock_data,predictor,average_len){
    var changes = stock_changes(stock_data);
    var predicted_values = process_stock_data(changes,predictor)
    var accurate_predictions = did_predict(changes,predicted_values)
    var averages = average_over_time(accurate_predictions,average_len);

    var plot_data = new Array(averages.length);
    var i = 0;
    for(var idx in averages){
        plot_data[i] = {
            "date":stock_data[idx].date,
            "perc_worked":averages[idx],
        }
        i += 1;
    }
    return plot_data
}
function sparsify_data(stock_data,sparse_factor){
    var res = [];
    for(var i = 0; i < stock_data.length; i += sparse_factor){
        res.push(stock_data[i]);
    }
    return res;
}
var all_strat_info = {
    "bullish":{
        "strat_const":Bull,
        "label":"bullish",
        "color":"yellow",
    },
    "optimistic":{
        "strat_const":Opti,
        "label":"optimistic",
        "color":"green",
    },
    "random":{
        "strat_const":Rand,
        "label":"random",
        "color":"red",
    },
    "skittsh":{
        "strat_const":Skitti,
        "label":"skittsh",
        "color":"blue",
    },
    "rev-skittish":{
        "strat_const":SkitNegate,
        "label":"rev-skittish",
        "color":"rgb(125,255,255)",
    },
    "trend_reversing":{
        "strat_const":BullNegate,
        "label":"trend_reversing",
        "color":"rgb(255,125,255)",
    },
    "pessimistic":{
        "strat_const":Pessimistic,
        "label":"pessimistic",
        "color":"rgb(255,255,125)",
    },
    "mul_weights":{
        "strat_const":PredStocks,
        "label":"mul_weights",
        "color":"black",
    },
}
function place_checkboxes(){
    var mydiv = document.getElementById("strategy_inclusion")
   for(var key in all_strat_info){
        var x = document.createElement("INPUT");
        x.type = "checkbox"
        x.id = key;
        x.checked = true;
        mydiv.appendChild(x);

        var y = document.createElement("label");
        y.innerHTML = key;
        y.for = key;
        mydiv.appendChild(y);
    }
}
function get_cur_strategies(){
    var out_strats = {}
    for(var key in all_strat_info){
        if(document.getElementById(key).checked){
            out_strats[key] = all_strat_info[key]
        }
    }
    return out_strats;
}
function plot_mul_weights_strategies(stock_data,sparse_factor,average_len){
    var cur_values = Object.values(get_cur_strategies());
    var predictors = cur_values.map(function(v){return v.strat_const()})
    var sparse_stock_data = sparsify_data(stock_data,sparse_factor)
    var plot_data = predictors.map(function(pred){
        return get_plot_data(sparse_stock_data,pred,average_len)
    })

    MG.data_graphic({
        title: "more cool stuff",
        description: "This graphic shows a time-series of downloads.",
        data: plot_data, //[{'date':new Date('2014-11-01'),'value':12},
                        //{'date':new Date('2014-11-02'),'value':18}],
        width: 600,
        height: 500,
        target: '#pred_chart',
        x_accessor: 'date',
        y_accessor: 'perc_worked',
        legend: cur_values.map(function(v){return v.label}),
        legend_target: '.legend',
        colors: cur_values.map(function(v){return v.color}),
    })
}
function plot_stocks(plot_data){
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
function parse_dec(str){
    return parseInt(str, 10)
}
function parse_line(line){
    var elements = line.split(',');
    var old_date = elements[0];
    var new_date = new Date(
        (old_date.slice(0,4)),
        (old_date.slice(4,6)),
        (old_date.slice(6,8))
    );
    return {
        "date":new_date,
        "open":parseFloat(elements[2]),
        "high":parseFloat(elements[3]),
        "low":parseFloat(elements[4]),
        "close":parseFloat(elements[5]),
        "volume":parseFloat(elements[6]),
    }
}
function parse_csv_into_elements(csv_string){
    var lines = csv_string.split('\n')
    lines = lines.filter(function(line){return line.length > 2})
    return lines.map(parse_line)
}
function process_stock_name(name){
    var base_url = "https://weepingwillowben.github.io/link_only/stock_vis/"
    var final_url = base_url+"daily/table_"+name+".csv";
    $.ajax({
        url : final_url,
        success : function(result){
            var stock_data = parse_csv_into_elements(result);
            plot_stocks(stock_data);
            var sparsity = parseInt($("#number_days").val());
            var average_over = parseInt($("#average_over").val());
            plot_mul_weights_strategies(stock_data,sparsity,average_over);
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
        if(stock_name == "abc"){
            opt.selected="selected"
        }
        select.appendChild(opt);
    })
}
function update_plot(){
    document.getElementById('stock_chart').innerHTML = "";
    document.getElementById('pred_chart').innerHTML = "";
    process_stock_name($("#stock_options").val())
}
window.onload = function(){
    $('#update_chart').click(update_plot);
    place_checkboxes()
    init_stock_options()
    update_plot()
}
