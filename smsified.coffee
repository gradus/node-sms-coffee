http = require 'http'
express = require 'express'
querystring = require 'querystring'
app = express.createServer()

app.configure( ->
  app.use express.bodyParser()
)

app.post('/', (req, res) ->
	post_data = querystring.stringify({
    'address' : '8033603069'
    'message': "callerID: #{req.body['inboundSMSMessageNotification']['inboundSMSMessage']['senderAddress']} said: #{req.body['inboundSMSMessageNotification']['inboundSMSMessage']['message']}"
  })
	post_options = {
		host: 'api.smsified.com'
		port: '80'
		path: '/v1/smsmessaging/outbound/8436363155/requests'
		method: 'POST'
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
			'Content-Length': post_data.length
			'Authorization':"Basic "+ new Buffer('gradus' + ":" + "bratya147").toString('base64')
		}
	}
	post_req = http.request(post_options, (res) ->
		res.setEncoding 'utf8'
  )
	post_req.write post_data 
	post_req.end()
	res.end()
)
app.listen(10085)
