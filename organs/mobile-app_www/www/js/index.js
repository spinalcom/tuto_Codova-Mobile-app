/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
// cordova.js
  var app = {
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },
    // function called by the EventListener when the device is ready
    onDeviceReady: function() {
	console.log("onDeviceReady Start")
        // Connect to the Hub
        // Using Read/Write User ID: 644 | Password: 4YCSeYUzsDG8XSrjqXgkDPrdmJ3fQqHs
        // here the ip of the computer hosting the hub is 10.10.10.106, know your own ip address with 'ifconfig'
        var conn = spinalCore.connect("http://644:4YCSeYUzsDG8XSrjqXgkDPrdmJ3fQqHs@XX.XX.XX.XX:8888/__mobile_app__");
        var _app = this; // workaround to save the variable in the callback
        // load the model
        spinalCore.load(conn, "myButton", function (myButton) {
            // Load success then save the model in a variable
	    console.log("Load Sucess")
            _app.btnModel = myButton;
        }, function(error) { // load fail
            // create the model in a variable
            // then store the new model
	    console.log("Load Failed creating the model then store it")
            _app.btnModel = new BtnModel();
            spinalCore.store(conn, _app.btnModel, "myButton", function () {
		console.log("Store Success.");
	    });
        });
    },
    // function called on click of the button "Tap me!"
    onClick: function() {
        this.btnModel.pressed.set(true);  // set the model button to be pressed.
    }
};

app.initialize();
