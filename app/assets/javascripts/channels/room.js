$(document).ready(function(){
  var room_id = $('#messages').attr('room_id');
  App.room = App.cable.subscriptions.create({channel: "RoomChannel", room_id: room_id}, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      if ($('#messages').attr('current_user') == data['user_id']) {
        $('#messages').append(data['message']);
      } else {
        $('messages').append(data['message_other']);
      }
      scrollToLastMessage();
    },
    speak: function(message, user_id, room_id){
      this.perform('speak', {
        message: message,
        user_id: user_id,
        room_id: room_id
      });
    }
  });
});


