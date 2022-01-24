/**
 * Created by yuganji on 2017. 1. 20..
 */

function HeaderMenu(){
    return {
        menu: {
            items: [
                {
                    iconCssClass: "fa fa-fw fa-sort-asc",
                    title: "Sort Ascending",
                    command: "sort-asc"
                },
                {
                    iconCssClass: "fa fa-fw fa-sort-desc",
                    title: "Sort Descending",
                    command: "sort-desc"
                },
                {
                    title: "Column Statistics",
                    command: "stats",
                },
                {
                    title: "Hide Column",
                    command: "hide",
                    disabled: true,
                    tooltip: "Can't hide this column"
                },
                {
                    title: "Set Label",
                    command: "isLabel"
                },
                {
                    seperator: "true"
                },
                {
                    iconCssClass: "fa fa-fw fa-columns",
                    title: "Column",
                    items: [
                        {
                            title: "Change Name",
                            command: "change"
                        },
                        {
                            title: "Remove",
                            command: "remove"
                        }
                    ]
                },
                {
                    iconCssClass: "fa fa-fw fa-exchange",
                    title: "Transform",
                    command: "Transform",
                    items: [
                        {
                            title: "split",
                            command: "split"
                        },
                        {
                            title: "concat",
                            command: "concat"
                        },
                        {
                            title: "replace",
                            command: "replace"
                        },
                        {
                            title: "indexOf",
                            command: "indexOf"
                        },
                        {
                            title: "startsWith",
                            command: "startsWith"
                        },
                        {
                            title: "endsWith",
                            command: "endsWith"
                        },
                        {
                            title: "contains",
                            command: "contains"
                        },
                        {
                            title: "trim",
                            command: "trim"
                        },
                        {
                            title: "toLowerCase",
                            command: "toLowerCase"
                        },
                        {
                            title: "toUpperCase",
                            command: "toUpperCase"
                        },
                        {
                            title: "mapping",
                            command: "mapping"
                        },
                        {
                            title: "z-score",
                            command: "z-score"
                        },
                        {
                            title: "length",
                            command: "length"
                        },
                        {
                            title: "ip2number",
                            command: "ip2number"
                        }
                    ]
                }
            ]
        }
    };
}

function HeaderMenuNotPreProcessing(){
    return {
        menu: {
            items: [
                {
                    iconCssClass: "fa fa-fw fa-sort-asc",
                    title: "Sort Ascending",
                    command: "sort-asc"
                },
                {
                    iconCssClass: "fa fa-fw fa-sort-desc",
                    title: "Sort Descending",
                    command: "sort-desc"
                },
                {
                    title: "Column Statistics",
                    command: "stats",
                }
            ]
        }
    };///
}

function DataItem(index, data) {
    this.id = index;
    for(var i=0; i < slick_columns.length; i++){
        var type = slick_columns[i]["type"];
        if(["long", "int", "short", "double"].indexOf(slick_columns[i]["type"]) > -1){
            this[slick_columns[i]["name"]] = Number(data[i]);
        }
        else {
            this[slick_columns[i]["name"]] = data[i];
        }
        type = null;
    }
    data = null
}



function TransformInfo(command, column, type, old_col_hide, extend){
    var new_col_id = column.id + "__" + command;
    var new_col = {
        name:   old_col_hide ? column.name : new_col_id,
        id:     new_col_id,
        field:  new_col_id,
        type:   type,
        header: new HeaderMenu(),
        width:150
    }
    var transform = {
        type: command,
        old_column: column.id,
        new_column: new_col_id,
        old_col_hide: old_col_hide
    }
    for (var obj in extend){
        transform[obj] = extend[obj];
    }
    this.getNewCol = function(){
        return new_col;
    }
    this.getTransform = function(){
        return transform;
    }
}

function isLabelTemplet(col_name){
	return ["<div class='row'>",
	        "   <label >Field: <span class='label label-primary'>", col_name, "</span></label>",
	        "</div>",
	        "<hr/>",
	        "<div class='row'>",
	        "   <label>Set Label</label>",
	        // "   <input type='text'>",
	        "</div>"].join("")
}

function splitTemplet(col_name){
    return ["<div class='row'>",
        "   <label >Field: <span class='label label-primary'>", col_name, "</span></label>",
        "</div>",
        "<hr/>",
        "<div class='row'>",
        "   <label>separator</label>",
        "   <input type='text'>",
        "</div>",
        "<div class='row'>",
        "   <label>limit</label>",
        "   <select>",
        // "       <option value='1'>1</option>",
        "       <option value='2'>2</option>",
        "       <option value='3'>3</option>",
        "       <option value='4'>4</option>",
        "       <option value='5'>5</option>",
        "   </select>",
        "</div>"].join("")
}

function replaceTemplet(col_name){
    return ["<div class='row'>",
        "   <label >Field: <span class='label label-primary'>", col_name, "</span></label>",
        "</div>",
        "<hr/>",
        "<div class='row'>",
        "   <label>Old String</label>",
        "   <input type='text'>",
        "</div>",
        "<div class='row'>",
        "   <label>New String</label>",
        "   <input type='text'>",
        "</div>"].join("")
}

function changeTemplet(col_name){
    return ["<div class='row'>",
        "   <label >Field: <span class='label label-primary'>", col_name, "</span></label>",
        "</div>",
        "<hr/>",
        "<div class='row'>",
        "   <label>New Name</label>",
        "   <input type='text'>",
        "</div>"].join("")
}

function findTextTemplet(col_name, command){
    return ["<div class='row'>",
        "   <label >Field: <span class='label label-primary'>", col_name, "</span></label>",
        "</div>",
        "<hr/>",
        "<div class='row'>",
        "   <label>", command , "</label>",
        "   <input type='text'>",
        "</div>"].join("")
}

function caseTemplet(col_name, command){
    return ["<div class='row'>",
        "   <label >Field: <span class='label label-primary'>", col_name, "</span></label>",
        "</div>",
        "<hr/>",
        "<div class='row'>",
        "   <label>Changed ", command, "</label>",
        "</div>"].join("");
}

function mappingTemplet(col_name){
    return ["<div class='row'>",
        "   <label >Field: <span class='label label-primary'>", col_name, "</span></label>",
        "<span>",
        "&nbsp;&nbsp;&nbsp;<select name='method' style='min-width:80px;'>",
        "<option value=''>선택</option>",
        "<option value='Method'>Method</option>",
        "<option value='Protocol'>Protocol</option>",
        "<option value='Asset'>Asset</option>",
        "<option value='Network'>Network</option>",
        "</select>",
        "<span>",
        "</span>",
        "</div>",
        "<hr/>",
        "<div class='row'>",
        "   <label>Value</label>",
        "   <input type='text'>",
        "</div>"].join("")
}

function hist(values, min, max, numBins) {
    var bins = [];
    var range = max - min;
    jQuery.each(values, function(i, value) {
        var bin = Math.floor(numBins * (value - min) / range);
        bin = Math.min(Math.max(bin, -1), numBins) + 1;
        bins[bin] = (bins[bin] || 0) + 1;
    });
    return bins;
}


function consoleHist(values, min, max, numBins) {
    var bins = hist(values, min, max, numBins);
    var step = (max - min) / numBins;

    var temp_x = [];
    var temp_y = [];
    jQuery.each(bins, function(i, count) {
        var lower = (i - 1) * step + min;
        var upper = lower + step;
        if (lower < min) {
            lower = -Infinity;
        }
        if (upper > max) {
            upper = Infinity;
        }
        temp_x.push(Math.round(lower) + "~" + Math.round(upper));
        temp_y.push((count || 0));
        console.log('[' + lower + ', ' + upper + '): ' + (count || 0));
    });
    this.x = temp_x;
    this.y = temp_y;
}