var sys = require('sys');
var express = require('express');
var app = express.createServer();
var smsified = require('smsified');

app.configure(function(){
    app.use(express.bodyParser());
});

app.post('/', function(req, res){

	var callerID = req.body['inboundSMSMessageNotification']['inboundSMSMessage']['senderAddress'];
	var message = req.body['inboundSMSMessageNotification']['inboundSMSMessage']['message'];
	var my_number = '8033603069';
	var complete_msg = "callerID: " + callerID + " said: " + message;

	var sms = new SMSified('gradus', 'bratya147');
	var options = {senderAddress: '8436363155', address: my_number, message: complete_msg};

	sms.sendMessage(options, function(result) {
		sys.puts(sys.inspect(result));
	});

	res.end();
});

app.listen(10085);
