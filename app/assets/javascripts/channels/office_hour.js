App.oh = App.cable.subscriptions.create("OfficeHourChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    alert("Name:"+data["name"]+", Desc:"+data['desc'])
  },

  speak: function(name, desc) {
    return this.perform('speak', {"name": name, "desc": desc});
  }
});


$(document).ready(function() {
  $("#enqueue-btn").click(function() {
    nameInput = $("#name-input")
    descInput = $("#desc-input")
    console.log(App.oh)
    App.oh.speak(nameInput.val(), descInput.val())
    nameInput.val("")
    descInput.val("")
  })
});

