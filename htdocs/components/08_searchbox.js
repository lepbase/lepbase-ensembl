window.onload = function(){
    $(function() {
          $("#se_q").autocomplete({
                source: function(request, response) {
    				var url = window.location.pathname.split('/');
    				url.pop();
    				var prefix = '';
    				url.forEach(function(i){
    					prefix += '../';
    				});
    				$.getJSON(prefix+"autocomplete", { term: request.term, table: $('#search_table').val() }, 
              		response);
  				},
                minLength: 3,
                select: function(event, ui) {
                	window.location = prefix+'search.html';
        		}
            });
         });
    }