App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    # Our event listener here is the id 'messages' set in the show.html.erb in the chatrooms folder
    $('#messages').append data['message']

    # message partial has a div class message and a span class content --> message_content
    $('#message_content').val ''

    scrollToBottom()
    return

  jQuery(document).on 'turbolinks:load', ->
    scrollToBottom()
    return
