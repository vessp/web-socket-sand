# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(() ->
    debug = (str) -> $("#debug").append("<p>"+str+"</p>");

    ws = new WebSocket("ws://localhost:8090");

    ws.onmessage = (evt) ->
        $("#msg").append("<p>"+evt.data+"</p>");

    ws.onclose = () ->
        debug("socket closed");

    ws.onopen = () ->
        debug("connected...");
        ws.send("hello server");

    $("#sendButton").click(() ->
        ws.send("hey")
    )

);