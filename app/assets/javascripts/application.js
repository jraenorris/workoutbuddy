// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){ $(document).foundation(); });
// on click
$('.submit-new-exercise').on('click', function(event) {
  event.preventDefault();
  var url = $('form#new_exercise')[0].action;
  var workoutTable = $('.exercises-table-edit-page');
  var lastRow = $('.exercises-table-list');
  var noticeWrapper = $('#notice_wrapper');
  var flashMessage = $('.notice');
  $.ajax({
    type: 'POST',
    url: url,
    dataType: 'json',
    data: JSON.stringify({activity: $('#exercise_activity').val(),
      intensity: $('#exercise_intensity').val()}),
    success: function(response) {
      workoutTable.removeClass('hide');
      flashMessage.addClass('hide');
      lastRow.append('<tr>' +
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
      '</tr>');
      $('#exercise_activity').val('');
      $('#exercise_intensity').val('');
      noticeWrapper.append('<div class="flash flash-success">' +
        '<p class="notice">Exercise added to your workout</p></div>');
    },
    error: function(response) {
      flashMessage.addClass('hide');
      noticeWrapper.append('<div class="flash flash-error"><p class="notice">' +
        response.responseText + '</p></div>'
      );
      $('body').animate({
        scrollTop: 0
      }, 1000);
    },
  });
});


// 
// $('.submit-new-exercise').on('click', function(event) {
//   event.preventDefault();
//   var url = $('form#new_exercise')[0].action;
//   var workoutTable = $('.exercises-table-edit-page');
//   var lastRow = $('.exercises-table-list');
//   var noticeWrapper = $('#notice_wrapper');
//   var flashMessage = $('.notice');
//   $.ajax({
//     type: 'POST',
//     url: url,
//     dataType: 'json',
//     data: JSON.stringify({activity: $('#exercise_activity').val(),
//       intensity: $('#exercise_intensity').val()}),
//     success: function(response) {
//       workoutTable.removeClass('hide');
//       flashMessage.addClass('hide');
//       lastRow.append('<tr>' +
//         '<td class="icon-edit">' +
//           '<a href="/workout/' + response.workout_id +'/exercise/' +
//           response.id + '/edit" class="edit-icon">' +
//             '<i class="fa fa-pencil"></i>' +
//           '</a>' +
//         '</td>' +
//         '<td class="icon-edit">' +
//           '<a class="delete-icon" data-confirm=' +
//           '"Are you sure you want to delete this exercise?" rel="nofollow"' +
//           'data-method="delete" href="/workouts/' + response.workout_id +
//           '/exercises/' + response.id + '">' +
//             '<i class="fa fa-times"></i>' +
//           '</a>' +
//         '</td>' +
//         '<td>' +
//           '<div class="exercise-type">' + response.activity + '</div>' +
//           '<div class="exercise-intensity">' + response.intensity + '</div>'+
//         '</td>' +
//       '</tr>');
//       $('#exercise_activity').val('');
//       $('#exercise_intensity').val('');
//       noticeWrapper.append('<div class="flash flash-success">' +
//         '<p class="notice">Exercise added to your workout</p></div>');
//     },
//     error: function(response) {
//       flashMessage.addClass('hide');
//       noticeWrapper.append('<div class="flash flash-error"><p class="notice">' +
//         response.responseText + '</p></div>'
//       );
//       $('body').animate({
//         scrollTop: 0
//       }, 1000);
//     },
//   });
// });
