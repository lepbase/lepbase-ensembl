window.onload = function(){
    $(function() {
          $("#se_q").autocomplete({
                source: function(request, response) {
    				console.log(request.term + ' ' + $('#search_table').val());
    				$.getJSON("/autocomplete", { term: request.term, table: $('#search_table').val() }, 
              		response);
  				},
                minLength: 3,
                select: function(event, ui) {
                	//do_search(ui.item.value);
        		}
            });
         });
    }