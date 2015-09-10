window.onload = function(){
    $(function() {
          $("#se_q").autocomplete({
                source: function(request, response) {
    				console.log(request)
    				//$.getJSON("/cgi-bin/autocomplete.pl", { term: request.term, table: $('#table').val() }, 
              		//response);
  				},
                minLength: 3,
                select: function(event, ui) {
                	//do_search(ui.item.value);
        		}
            });
         });
    }