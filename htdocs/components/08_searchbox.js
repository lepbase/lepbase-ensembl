window.onload = function(){
    $(function() {
          $("#se_q").autocomplete({
                source: function(request, response) {
    				console.log(request);
    				$.getJSON("autocomplete", { term: request.term }, 
              		response);
  				},
                minLength: 3,
                appendTo: $('#auto_search'),
                select: function(event, ui) {
                	//do_search(ui.item.value);
        		}
            });
         });
    }