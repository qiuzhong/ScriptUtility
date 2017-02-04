#!/usr/bin/env node


var http = require('http');
var assert = require('assert');
var spawn = require('child_process').spawn;
var ocf_server_dir = '/home/root/SmartHome-Demo/ocf-servers/js-servers';
var serverDuration = 30;

var options_d = {
    host: '127.0.0.1',
    port: 8000,
    path: '/api/oic/d',
    method: 'GET',
    headers: {
        'Accept': 'text/json'
    }
};

var options_p = {
    host: '127.0.0.1',
    port: 8000,
    path: '/api/oic/d',
    method: 'GET',
    headers: {
        'Accept': 'text/json'
    }
};

var options_res = {
    host: '127.0.0.1',
    port: 8000,
    path: '/api/oic/res',
    method: 'GET',
    headers: {
        'Accept': 'text/json'
    }
};

var child = spawn('node', ['led.js'], {
    cwd: ocf_server_dir,
    env: process.env
});

describe('unique_led_device', function() {
    it('Only one LED device should be found', function(done) {

        // send HTTP request
        var req = http.request(options_d, function(res) {
            res.setEncoding('utf8');

            res.on('data', function (data) {
                var devices = JSON.parse(data);
                assert.equal(1, devices[0].length);
                assert.equal('Smart Home LED', devices[0]['n']);
            });
        });
        req.end();
        done();     
    })
});

describe('unique_led_platform', function() {
    it('Only one LED platform should be found', function(done) {

        // send HTTP request
        var req = http.request(options_p, function(res) {
            res.setEncoding('utf8');

            res.on('data', function (data) {
                var platforms = JSON.parse(data);
                assert.equal(1, platforms[0].length);
                assert.equal('Intel', platforms[0]['mnmn'])
            });
        });
        req.end();
        done();     
    })
});

describe('unique_led_resource', function() {
    it('Only one LED resource should be found', function(done) {

        // send HTTP request
        var req = http.request(options_res, function(res) {
            res.setEncoding('utf8');

            res.on('data', function (data) {
                var resources = JSON.parse(data);
                var ledHrefNum = 0;
                var ledRt;

                resources.forEach(function (resource) {
                    if (resource.links[0]['href'] === '/a/led') {
                        ledHrefNum++;
                        ledRt = resource.links[0]['rt'];
                    }
                }, function allDone(){
                    assert.equal(1, ledHrefNum);
                    assert.equal('oic.r.led', ledRt);
                });
            });
        });
        req.end();
        child.kill('SIGINT');
        done();
    })
});

