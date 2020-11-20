$(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
  if (event.keyCode === 13) {
    if (!event.target.value.trim().length) {
      return 0;
    }
    App.room.speak(event.target.value,
      $("#user_id").val(),
      $("#messages").attr("room_id")
    );
    event.target.value = '';
    return event.preventDefault();
  }
});