function pieChart(view_id, data, mouseOver, mouseOut,w,h)
{
	console.log(w);
	console.log(h);
	
	var pattern = new Array();
	var obj = new Object();
	for(i=0;i<data.length;i++)
	{
		obj[data[i].k] =data[i].v;
		pattern[i] = data[i].c;
		
	}
	
	c3.generate({
		bindto: '#'+view_id,
		size:{
			width: ''+w
			, height: ''+h
		},
		data: {
		    json: [obj],
		    keys: {
		      value: Object.keys(obj),
		    },
		    type: "pie",
		  }
		,
		color: {
			pattern:pattern
		}
		,pie: 
		{
	        label: 
	        {
	            format: function (value, ratio, id) 
	            {
//	            	console.log(value);
//	            	console.log(ratio);
	            	
	                return value;
	            }
	        }
	    }
	});
}