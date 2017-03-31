var spinalCore = require('spinalcore');
var path = require('path');
var fs = require('fs');
var vm = require('vm');

vm.runInThisContext(fs.readFileSync(path.join(__dirname, './config.js')));
vm.runInThisContext(fs.readFileSync(path.join(__dirname, './js-libraries/lib_cordova_btn/models.js')));

// Connect to the hub
var conn = spinalCore.connect('http://' + CONNECTION.user + ':' + CONNECTION.password + '@' + CONNECTION.host + ':' + CONNECTION.port + '/' + FOLDER);

// Get or create the button in the hub
spinalCore.load(conn, "myButton", function(myButton) {
    printNumber(myButton);
}, function() {
    myButton = new BtnModel();
    spinalCore.store(conn, myButton, "myButton", function () {
        printNumber(myButton);
    });
});

// Print button when pressed
function printNumber(button) {
    button.bind(function () {
        if (button.pressed.get() === true) {
            console.log("Button has been pressed!");
            button.pressed.set(false);
        }
    });
}
