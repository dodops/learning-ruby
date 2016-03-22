
modulejs.define('ui/state-selector', function(){
	var dynamicSelect = {
		init: function() {
			$('#complaint_city_id').prop('disabled', true);
			var cities = $('#complaint_city_id').html();

			$('#complaint_state_id').change(function() {
				var state = $("#complaint_state_id :selected").text();
				var options = $(cities).filter("optgroup[label='" + state + "']").html();
				if (options) {
					$('#complaint_city_id').html(options);
					$('#complaint_city_id').prop('disabled', false);
				} else {
					$('#complaint_city_id').empty();
					$('#complaint_city_id').prop('disabled', true);
				}
			});
		}
	};

	return dynamicSelect;
});

