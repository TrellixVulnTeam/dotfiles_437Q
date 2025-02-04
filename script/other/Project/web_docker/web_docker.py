#!/usr/bin/env python
#-*- coding: utf-8 -*-
# This is a docker web Tools

import docker
from flask import Flask, request, render_template

app = Flask(__name__)

@app.route('/')
def index():
    c = docker.Client(base_url='unix://var/run/docker.sock')
    return "<h1>Run.containers: %s</h1>" % c.containers()

@app.route('/images/')
def docker_image():
    c = docker.Client(base_url='unix://var/run/docker.sock')
    return "<h3>Docker_images: %s</h3>" % c.images()

if __name__ == '__main__':
    app.run(host='127.0.0.1',port=8989, debug=True)
