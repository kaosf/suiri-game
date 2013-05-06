#
# Module dependencies.
#

express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
io = require 'socket.io'

app = express()

app.configure(->
  app.set('port', process.env.PORT || 3000)
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.locals.pretty = true
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router)
  app.use(express.static(path.join(__dirname, 'public')))
  return
)

app.configure('development', ->
  app.use(express.errorHandler())
  return
)

app.get('/', routes.index)

server = http.createServer(app).listen(app.get('port'), ->
  console.log("Express server listening on port " + app.get('port'))
  return
)

io = io.listen(server)

io.sockets.on('connection', (socket) ->
  io.sockets.emit('login', socket.id)
  socket.on('post', (data) ->
    io.sockets.emit('post', id: socket.id, post: data)
    return
  )
  return
)
