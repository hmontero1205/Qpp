var cardTemplate = '<div class="card border-info queue_entry"><div class="card-header bg-dark" style="color: white"></div><ul class="list-group list-group-flush"><li class="list-group-item"></li><li class="list-group-item"></li></ul></div>'

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

    if (data["op"] == "refresh") {
      window.location.reload(false)
    }

    ohID = $("#oh-input").val()  
    if (data["ohID"] != ohID) {
      return
    }
    qeBox = $("#queue_entries")
  
    if (data["op"] == "enqueue") {
      newCard = $($.parseHTML(cardTemplate)[0])
      newCard.attr("start_time", data['start_time'])
      seconds = (new Date() - new Date(data['start_time'])) / 1000;
      min = Math.floor(seconds/60);
      sec = Math.floor(seconds % 60);

      nameSpan = $("<span />").html(data['name'])
      buttsSpan = $("<span />").attr('style',"display: inline-block; float: right")
      xButton = $("<button />").attr('class', 'qe-btn btn btn-danger').attr('style', 'padding: 5px 10px; margin: -5px;').html("X")
      threadButton = $("<button />").attr('id', 'thread-btn-'+data["qe_id"]).attr('class', 'thread-btn btn btn-info').attr('style', 'padding: 5px 10px; margin: -5px 10px -5px -5px;').html("Thread")
       
      xButton.click(function() {
        App.oh.speak("dequeue", {"ohID": ohID, "qeID": data["qe_id"]})
      });
      threadButton.click(function() {
        card = $($($($(this).parent()[0]).parent()[0]).parent()[0])[0]
        ohID = $("#oh-input").val()  
        App.oh.speak("show_thread", {"windowID": windowID, "ohID": ohID, "qeID": parseInt($(card).attr("id").split("-")[1])})
      })
      $(newCard).attr("id", "qe-"+data["qe_id"])
      $(newCard.children()[0]).html(nameSpan)
      $(newCard.children()[0]).append(buttsSpan)
      $(buttsSpan).append(threadButton)

      if (data["creator"] == $('#enqueue-btn').data('session') || ($('#enqueue-btn').data('bool')  && (data["oh_user"] == $('#enqueue-btn').data('user')))) {
        $(buttsSpan).append(xButton)
      } 
      $($(newCard.children()[1]).children()[0]).html(str_pad_left(min, '0', 2) + ':' + str_pad_left(sec, '0', 2))
      $($(newCard.children()[1]).children()[1]).html(data['desc'])

      qeBox.append(newCard)
    } else if (data["op"] == "dequeue") {
      queueEntry = $("#qe-"+data["qeID"])
      if (queueEntry.length != 0) {
        $(queueEntry).remove()
      }
      if (data["qeID"] == currentQE) {

        $("#thread-tools").hide()
        chatBox = $("#chat-box")
        $(chatBox).children().slice(2).remove();
        $($(chatBox).children()[1]).show();
      }

    } else if (data["op"] == "show_thread") {
      if (data["windowID"] != windowID) {
        return
      }
      currentQE = data["qe"].id

      chatBox = $("#chat-box")
      $(chatBox).children().slice(2).remove();
      $($(chatBox).children()[1]).hide();
      opChat = $("<li />").attr('class', "list-group-item")
      opName = $("<span />").attr('class', 'bg-dark').attr('style', 'display: inline-block; color: white; padding: 0 5px 0 5px; margin-right: 5px').html(data["qe"].student)
      opDesc = $("<span />").attr('style', 'display:inline-block; word-break: break-word;').append(opName).append(data["qe"].description)
      opChat.append(opDesc)
      chatBox.append(opChat)
      $("#thread-tools").show()
      data["chats"].forEach(function(chat) {
        newChat = $("<li />").attr('class', "list-group-item")
        newChatName = $("<span />").attr('class', '').attr('style', 'background-color: #d6d8db; display: inline-block; color: black; padding: 0 5px 0 5px; margin-right: 5px').html(chat.name)
        newChatDesc = $("<span />").attr('style', 'display:inline-block; word-break: break-word;').append(newChatName).append(chat.msg)
        newChat.append(newChatDesc)
        chatBox.append(newChat)
      });
      currentQE = data["qe"].id
    } else if(data["op"] == "send_msg") {

      threadBtn = $('#thread-btn-'+data["qeID"])
      $(threadBtn).html("Thread (+"+data["num_chats"]+")")

      if (data["qeID"] != currentQE) {
        return;
      }

      chatBox = $("#chat-box")
      chat = data["chat"]
      newChat = $("<li />").attr('class', "list-group-item")
      newChatName = $("<span />").attr('class', '').attr('style', 'background-color: #d6d8db; display: inline-block; color: black; padding: 0 5px 0 5px; margin-right: 5px').html(chat.name)
      newChatDesc = $("<span />").attr('style', 'display:inline-block; word-break: break-word;').append(newChatName).append(chat.msg)
      newChat.append(newChatDesc)
      chatBox.append(newChat)

    } else {

    }
  },

  speak: function(op, args) {
    if (op == "enqueue") {
      return this.perform('speak', {"op": op, "ohID": args["ohID"], "name": args["name"], "desc": args["desc"], "sess": args["sess"]});
    } else if (op == "dequeue") {
      return this.perform('speak', {"op": op, "ohID": args["ohID"], "qeID": args["qeID"], "sess": args["sess"]})
    } else if (op == "refresh") {
      return this.perform('speak', {"op": op})
    } else if (op == "show_thread") {
      return this.perform('speak', {"op": op, "ohID": args["ohID"], "qeID": args["qeID"], "windowID": args["windowID"]})
    } else if (op == "send_msg") {
      return this.perform('speak', {"op": op, "ohID": args["ohID"], "qeID": args["qeID"], "name": args["name"], "msg": args["msg"]})
    } else {
      console.log("Unimplemented")
    }
  }
});

function channelInitialize() {
  $("#enqueue-btn").click(function() {
    nameInput = $("#name-input")
    if ($(nameInput).val() == "") {
      $(nameInput).attr("style", "border: 2px solid red;")
      $("#error-box").html("Name field is required!")
      return
    } else {
      $(nameInput).attr("style", "border: 0;")
      $("#error-box").html("")
    }
    descInput = $("#desc-input")
    ohInput = $("#oh-input")
    App.oh.speak("enqueue", {"ohID": ohInput.val(), "name": nameInput.val(), "desc": descInput.val()})
    nameInput.val("")
    descInput.val("")
  });

  $("#submit-btn-thread").click(function() {
    nameInput = $("#name-input-thread")
    if (!nameInput[0].checkValidity()) {
      $(nameInput).attr("style", "border: 2px solid red;")
      $("#error-box-thread").html("Name field is required!")
      return
    } else {
      $(nameInput).attr("style", "border: none;")
      $("#error-box-thread").html("")
    }
    descInput = $("#desc-input-thread")
    ohInput = $("#oh-input")
    App.oh.speak("send_msg", {"ohID": ohInput.val(), "name": nameInput.val(), "msg": descInput.val(), "qeID": currentQE})
    nameInput.val("")
    descInput.val("")
  });

  setInterval(function() {
    qeBox = $("#queue_entries")
    qeBox.children().each(function () {
      startTime = $(this).attr("start_time")
      // console.log(startTime)
      // console.log(new Date(startTime))
      seconds = (new Date() - Date.parse(startTime)) / 1000;
      min = Math.floor(seconds/60);
      sec = Math.floor(seconds % 60);

      $($($(this).children()[1]).children()[0]).html(str_pad_left(min, '0', 2) + ':' + str_pad_left(sec, '0', 2))

    });
  }, 500);

  $(".qe-btn").each(function () {
    $(this).click(function() {
      card = $($($($(this).parent()[0]).parent()[0]).parent()[0])[0]
      ohID = $("#oh-input").val()  
      App.oh.speak("dequeue", {"ohID": ohID, "qeID": parseInt($(card).attr("id").split("-")[1])})
    })
  });
  $(".thread-btn").each(function () {
    $(this).click(function() {
      card = $($($($(this).parent()[0]).parent()[0]).parent()[0])[0]
      ohID = $("#oh-input").val()  
      App.oh.speak("show_thread", {"windowID": windowID, "ohID": ohID, "qeID": parseInt($(card).attr("id").split("-")[1])})
    })
  });
}



