var cardTemplate = '<div class="card border-info queue_entry" style="width: 18rem;"><div class="card-header bg-dark" style="color: white"></div><ul class="list-group list-group-flush"><li class="list-group-item"></li><li class="list-group-item"></li></ul></div>'

function str_pad_left(string, pad, length) {
  return (new Array(length+1).join(pad)+string).slice(-length);
}


App.oh = App.cable.subscriptions.create("OfficeHourChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    qeBox = $("#queue_entries")
    newCard = $($.parseHTML(cardTemplate)[0])
    newCard.attr("start_time", data['start_time'])
    seconds = (new Date() - new Date(data['start_time'])) / 1000;
    min = Math.floor(seconds/60);
    sec = Math.floor(seconds % 60);

    $(newCard.children()[0]).html(data['name'])
    $($(newCard.children()[1]).children()[0]).html(str_pad_left(min, '0', 2) + ':' + str_pad_left(sec, '0', 2))
    $($(newCard.children()[1]).children()[1]).html(data['desc'])

    qeBox.append(newCard)
  },

  speak: function(op, ohID, name, desc) {
    if (op == "enqueue") {
      return this.perform('speak', {"op": op, "ohID": ohID, "name": name, "desc": desc});
    } else {
      console.log("Unimplemented")
    }
  }
});

$(document).ready(function() {
  $("#enqueue-btn").click(function() {
    nameInput = $("#name-input")
    descInput = $("#desc-input")
    ohInput = $("#oh-input")
    App.oh.speak("enqueue", ohInput.val(), nameInput.val(), descInput.val())
    nameInput.val("")
    descInput.val("")
  });

  setInterval(function() {
    qeBox = $("#queue_entries")
    qeBox.children().each( function () {
      startTime = $(this).attr("start_time")
      seconds = (new Date() - new Date(startTime)) / 1000;
      min = Math.floor(seconds/60);
      sec = Math.floor(seconds % 60);

      $($($(this).children()[1]).children()[0]).html(str_pad_left(min, '0', 2) + ':' + str_pad_left(sec, '0', 2))

    });
  }, 500)
});

