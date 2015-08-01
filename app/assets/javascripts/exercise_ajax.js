$('.submit-new-exercise').on('click', function(event) {
  event.preventDefault();
  var url = $('form#new_exercise')[0].action;
  $.ajax({
    type: 'POST',
    url: url,
    dataType: 'json',
    data: JSON.stringify({activity: $('#exercise_activity').val(),
    intensity: $('#exercise_intensity').val()}),
    success: function(response) { success_update(response) },
    error: function(response) { failure_update(response) },
  });
});

var success_update = function(response) {
  $('.notice').addClass('hide');
  $('#notice_wrapper').append(success_flash());
  $('.exercises-table-edit-page').removeClass('hide');
  $('.exercises-table-list').append(new_row(response));
  $('#exercise_activity').val('');
  $('#exercise_intensity').val('');
}

var failure_update = function(response) {
    $('.notice').addClass('hide');
    $('#notice_wrapper').append(failure_flash(response));
    $('body').animate({ scrollTop: 0 }, 1000);
}

var failure_flash = function(response) {
  return '<div class="flash flash-error"><p class="notice">' +
    response.responseText + '</p></div>';
}

var success_flash =  function() {
  return '<div class="flash flash-success">' +
    '<p class="notice">Exercise added to your workout</p></div>';
}

var new_row = function(response) {
  return '<tr>' +
    '<td class="icon-edit">' +
      '<a href="/workout/' + response.workout_id +'/exercise/' +
      response.id + '/edit" class="edit-icon">' +
        '<i class="fa fa-pencil"></i>' +
      '</a>' +
    '</td>' +
    '<td class="icon-edit">' +
      '<a class="delete-icon" data-confirm=' +
      '"Are you sure you want to delete this exercise?" rel="nofollow"' +
      'data-method="delete" href="/workouts/' + response.workout_id +
      '/exercises/' + response.id + '">' +
        '<i class="fa fa-times"></i>' +
      '</a>' +
    '</td>' +
    '<td>' +
      '<div class="exercise-type">' + response.activity + '</div>' +
      '<div class="exercise-intensity">' + response.intensity + '</div>'+
    '</td>' +
  '</tr>'
}
