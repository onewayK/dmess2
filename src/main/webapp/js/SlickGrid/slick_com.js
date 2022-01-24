/****************************************************************
 * 
 * 파일명 : slick_comm.js
 * 설  명 : slick 그리드 공통 공통js
 * 
 *    수정일      수정자     Version        Function 명
 * ------------    ---------   -------------  ----------------------------
 * 2018-05-14		김보성 	1.0
 * 
 * 
 ***************************************************************/

/**
	슬릭 그리드 생성 	
**/


	//헤더 	
	var slick_fields = [];	
	var slick_columns = [];
	//데이터
	var slick_data = [];	
	var slick_dataView;
	
	//버튼 html
	var slick_btn_str= "";
	//grid option
	
	var  plugin ;
	var slick_grid_list= [];
	var slick_dataView_list= [];
	var slick_grid;
	var slick_options = 
	{
			forceFitColumns: true,
			enableCellNavigation: true,
		    enableColumnReorder: false,
		    multiColumnSort: true,
		    headerRowHeight: 45,
		    rowHeight: 35 
		 //   leaveSpaceForNewRows : true
			/*
	    showHeaderRow: true,
	    headerRowHeight: 20,
	    explicitInitialization: true,
	    enableColumnReordjer: false,
	    enableCellNavigation: true,
	    //forceFitColumns: true,
	   */
	};
	
	//하나의 grid에 대한 데이터 클래스
	function DataItem(index, data) 
	{
		  this.id = index;
	    for(var i=0; i < slick_columns.length; i++){
	        var type = slick_columns[i]["type"];
	        if(["long", "int", "short", "double"].indexOf(slick_columns[i]["type"]) > -1){
	            this[slick_columns[i]["id"]] = Number(data[i]);
	        }
	        else {
	            this[slick_columns[i]["id"]] = data[i];
	        }
	        type = null;
	    }
	    data = null;
	}

	
	/**
	 * slick 버튼 생성 
	 * @param fields
	 */
	function setSlickBtn(id,name) 
	{
		slick_btn_str+=" <button id='"+id+"' type='button' class='btn btn-info'>"+name+"</button>";
	}
	
	/**
	 * slick header 생성시 버튼 타입일 경우 불러오는 함수
	 * parm : 필요시 사용
	 * @param row, cell, value, columnDef, dataContext 
	 */
	function getSlickBtn(row, cell, value, columnDef, dataContext) 
	{
		return slick_btn_str;
	}
	
	/**
	 * slick grid 생성
	 * @param fields
	 */
	function create_slick_grid(div_name) 
	{
		
		if(slick_columns == null && slick_columns.length < 1 )
		{
			console.log("not slick grid fields");
			return;
		}
				
		slick_dataView = new Slick.Data.DataView({ inlineFilters: true });
		
		slick_dataView.beginUpdate();
		slick_dataView.setItems(slick_data);
		slick_dataView.endUpdate();
		
		slick_grid = new Slick.Grid(div_name, slick_dataView, slick_columns, slick_options);
		
		  plugin = new Slick.ColumnGroup();
		slick_grid.registerPlugin(plugin);
		slick_grid_list.push(slick_grid);
			 
		slick_dataView.onRowCountChanged.subscribe(function (e, args) 
		{
			slick_grid.updateRowCount();
			slick_grid.render();
	    });
	    
		slick_dataView.onRowsChanged.subscribe(function (e, args) {
			slick_grid.invalidateRows(args.rows);
			slick_grid.render();
	    });
		
		
	}
	
	/**
	 * slick 정렬 이벤트 추가
	 * @param fields
	 */
	function setSort_one_table()
	{
		   //sort settin
		slick_grid.onSort.subscribe(function (e, args) {
		    var cols = args.sortCols;
		
		    slick_dataView.sort(function (dataRow1, dataRow2) {
		      for (var i = 0, l = cols.length; i < l; i++) {
		        var field = cols[i].sortCol.field;
		        var sign = cols[i].sortAsc ? 1 : -1;
		        var value1 = dataRow1[field], value2 = dataRow2[field];
		        var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
		        if (result != 0) {
		          return result;
		        }
		      }
		      return 0;
		    });
		    slick_grid.invalidate();
		    slick_grid.render();
		    
		  });
	}
	
	/**
	 * slick 정렬 이벤트 추가
	 * @param fields
	 */
	function setSort_multi_table()
	{
		var num = slick_grid_list.length -1;
		  //sort settin
		slick_grid.onSort.subscribe(function (e, args) {
		    var cols = args.sortCols;
		    
		    slick_grid_list[num].getData().sort(function (dataRow1, dataRow2) {
		      for (var i = 0, l = cols.length; i < l; i++) {
		        var field = cols[i].sortCol.field;
		        var sign = cols[i].sortAsc ? 1 : -1;
		        var value1 = dataRow1[field], value2 = dataRow2[field];
		        var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
		        if (result != 0) {
		          return result;
		        }
		      }
		      return 0;
		    });
		    slick_grid_list[num].invalidate();
		    slick_grid_list[num].render();
		  });
	}
	/**
	 * slick header 생성
	 * @param fields
	 */
	function setSlickHeader(fields)
	{	
		slick_columns = fields.map(function(v) {	
			
			if(v.type == "btn"){
				return {
					"id":v.id, 
					"name":v.name, 
					"field":v.id, 
					"rerenderOnResize" : true,
				//	"width":25,	
					"formatter":getSlickBtn,
					"headerCssClass" : "slick-text-center",
					"CssClass": "slick-text-center"
				}
			}
			
			if(v.type == "hide"){
				return {
					"id":v.id, 
					"name":v.name, 
					"field":v.id, 
					"width":0,
					"resizable" : false,
					"minWidth":0,
					"maxWidth":0,
					"headerCssClass": "reallyHidden",
					"CssClass": "reallyHidden"
				}
			}
			
			if(v.type == "grp"){
				return {
					"id":v.id, 
					"name":v.name, 
					"field":v.id, 
					"rerenderOnResize" : true,
					"groupName": v.grpname,					
				//	"width":25,	
					"formatter":teststr,
					"headerCssClass" : "slick-text-center",
					"CssClass": "slick-text-center",
					"sortable": true 	
				}
			}
			
			return {
				"id":v.id, 
				"name":v.name, 
				"field":v.id, 
				"colspan" : 2,
				"rerenderOnResize" : true,
				"headerCssClass" : "slick-text-center",
				"CssClass": "slick-text-center",
			//	"width":25,
				"sortable": true 	
			}
		});
	}
	
	/**
	 * 초기 slick data 생성
	 * @param fields
	 */
	function setSlickData_first(rData)
	{
		slick_data =[];
		
		var v = function(n) {
			var arr = [];       
			for(var m=0;m<slick_columns.length;m++)
			{
				$.each(rData[n], function(k, val) {					
					if(k==slick_columns[m].id)
					{
					   arr.push(val);
					}
				});
			}
			return arr;
		};
	
		for(var j = 0; j < rData.length; j++){
			
			var d = new DataItem(j, v(j));
			
			slick_data.push(d);
		}
	}
	
	/**
	 * 하나의 slick 행 수정 
	 * @param row
	 */
	function one_grid_modfiy(row)
	{		
		slick_dataView.updateItem(row.id, row);
	}	
	
	/**
	 * 하나의 slick 행 삭제 
	 * @param msg
	*	 @param id
	 */
	function one_grid_delete(id)
	{		
		slick_dataView.deleteItem(id);
	}
	
	/**
	 * 하나의 slick 행 추가(맨 마지막에 행 추가
	 * @param row
	 */
	function one_grid_append(row)
	{							    	
		slick_dataView.addItem(new DataItem(unikey(),row));
		slick_dataView.refresh();	    	
	}
	
	/**
	 * slick grid total row 수 
	 * @param msg
	*	 @param id
	 */
	function total_grid_number()
	{
		var num=0;
		
		if(slick_dataView == null){
			
		}else{
			num = slick_dataView.getLength();
		}
		
		return num;
	}
	
	/**
	 * 해당 slick grid 초기화
	 * @param row
	 */
	function slick_grid_init()
	{							    	
		slick_grid.init();
	}
	
	/**
	 * 해당 slick grid 초기화
	 * @param row
	 */
	function slick_group_init()
	{	
		  plugin.enableColumnGrouping();		 
	}	
	

	