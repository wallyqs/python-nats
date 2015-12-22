# coding: utf-8
import tornado.ioloop
import tornado.gen
import time
from nats.io.client import Client as NATS

@tornado.gen.coroutine
def main():
    nc = NATS()

    yield nc.connect()

    def subscriber(msg):
        print("Msg received on [{0}]: {1}".format(msg.subject, msg.data))

    yield nc.subscribe("foo.*.baz", "", subscriber)
    yield nc.subscribe("foo.bar.*", "", subscriber)
    yield nc.subscribe("foo.>", "", subscriber)
    yield nc.subscribe(">", "", subscriber)

    # Matches all of above
    yield nc.publish("foo.bar.baz", b"Hello World")
    yield tornado.gen.sleep(1)

if __name__ == '__main__':
    tornado.ioloop.IOLoop.instance().run_sync(main)
