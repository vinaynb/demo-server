const http = require('http')
const port = 3000

const requestHandler = (request, response) => {
  console.log(request.url)
  foo()
  if (request.url == '/abt') {
  	console.log(port.number.url);
  }
  response.end('Hello Node.js Server on 3000 port! WTF')
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on ${port}`)
})

Object.defineProperty(global, '__stack', {
get: function() {
        var orig = Error.prepareStackTrace;
        Error.prepareStackTrace = function(_, stack) {
            return stack;
        };
        var err = new Error;
        Error.captureStackTrace(err, arguments.callee);
        var stack = err.stack;
        Error.prepareStackTrace = orig;
        return stack;
    }
});

Object.defineProperty(global, '__line', {
get: function() {
        return __stack[1].getLineNumber();
    }
});

Object.defineProperty(global, '__function', {
get: function() {
        return __stack[1].getFunctionName();
    }
});

Object.defineProperty(global, '__fileName', {
get: function() {
        return __stack[1].getFileName();
    }
});

function foo() {
    console.log(__line);
    console.log(__function);
    console.log(__fileName);
}
