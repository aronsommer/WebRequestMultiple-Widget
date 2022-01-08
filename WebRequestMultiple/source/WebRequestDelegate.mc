//
// Copyright 2016-2021 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

import Toybox.Communications;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.System;

//! Creates a web request on menu / select events
class WebRequestDelegate extends WatchUi.BehaviorDelegate {
    //private var _notify as Method(args as Dictionary or String or Null) as Void;
    private var _notify as Method(args as Dictionary or String or Null, dataNumber as Number) as Void;

    //! Set up the callback to the view
    //! @param handler Callback method for when data is received
    //public function initialize(handler as Method(args as Dictionary or String or Null) as Void) {
    public function initialize(handler as Method(args as Dictionary or String or Null, dataNumber as Number) as Void) {
        WatchUi.BehaviorDelegate.initialize();
        _notify = handler;
        // Make request at start
        makeRequest();
        return true;
    }

    //! On a menu event, make a web request
    //! @return true if handled, false otherwise
    public function onMenu() as Boolean {
        makeRequest();
        return true;
    }

    //! On a select event, make a web request
    //! @return true if handled, false otherwise
    public function onSelect() as Boolean {
        makeRequest();
        return true;
    }

    //! Make the web request
    private function makeRequest() as Void {
        _notify.invoke("Executing\nRequest", 1);

        var options = {
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
            :headers => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
            }
        };

        Communications.makeWebRequest(
            "https://jsonplaceholder.typicode.com/todos/115",
            {},
            options,
            method(:onReceive)
        );
    }

    //! Receive the data from the web request
    //! @param responseCode The server response code
    //! @param data Content from a successful request
    public function onReceive(responseCode as Number, data as Dictionary?) as Void {
        if (responseCode == 200) {
            _notify.invoke(data, 1);
            //System.println( "onReceive data "+data );
        } else {
            _notify.invoke("Failed to load 1\nError: " + responseCode.toString(), 1);
        }
        makeRequest2();
        return true;
    }

    //! Make the web request 2
    private function makeRequest2() as Void {
        _notify.invoke("Executing\nRequest", 2);

        var options = {
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
            :headers => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED
            }
        };

        Communications.makeWebRequest(
            "https://jsonplaceholder.typicode.com/todos/118",
            {},
            options,
            method(:onReceive2)
        );
    }

    //! Receive the data from the web request 2
    //! @param responseCode The server response code
    //! @param data Content from a successful request
    public function onReceive2(responseCode as Number, data as Dictionary?) as Void {
        if (responseCode == 200) {
            _notify.invoke(data, 2);
            //System.println( "onReceive2 data "+data );
        } else {
            _notify.invoke("Failed to load 2\nError: " + responseCode.toString(), 2);
        }
    }
}