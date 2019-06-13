from sanic import Sanic
from sanic.response import json

app = Sanic()


@app.route('/')
async def print_hello(req):
    return json({'msg': 'hello'})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
