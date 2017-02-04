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

var childLed = spawn('node', ['led.js'], {
    cwd: ocf_server_dir,
    env: process.env
});

var childGas = spawn('node', ['gas.js'], {
    cwd: ocf_server_dir,
    env: process.env
});

describe('multi_devices', function() {
    it('Multiple devices should be found', function(done) {

        // send HTTP request
        var req = http.request(options_d, function(res) {
            res.setEncoding('utf8');

            res.on('data', function (data) {
                var devices = JSON.parse(data);
                var devLedFound = false;
                var devGasFound = false;
                assert.equal(2, devices[0].length);

                devices.forEach(function(device) {
                    if (device['n'] === 'Smart Home LED') {
                        devLedFound = true;
                    }

                    if (device['n'] === 'Smart Home Gas Sensor') {
                        devGasFound = true;
                    }
                }, function allDone() {
                    assert(devLedFound);
                    assert(devGasFound);
                });
            });
        });
        req.end();
        done();     
    })
});

describe('one_platform', function() {
    it('Only one platform should be found', function(done) {

        // send HTTP request
        var req = http.request(options_p, function(res) {
            res.setEncoding('utf8');

            res.on('data', function (data) {
                console.log(data);
                var platforms = JSON.parse(data);
                assert.equal(1, platforms[0].length);
                assert.equal('Intel', platforms[0]['mnmn'])
            });
        });
        req.end();
        done();     
    })
});

describe('multi_resources', function() {
    it('Multiple resources should be found', function(done) {

        // send HTTP request
        var req = http.request(options_res, function(res) {
            res.setEncoding('utf8');

            res.on('data', function (data) {
                console.log(data);
                var resources = JSON.parse(data);
                var ledHrefNum = 0;
                var ledRt;
                var gasHrefNum = 0;
                var gasRt;

                resources.forEach(function (resource) {
                    if (resource.links[0]['href'] === '/a/led') {
                        ledHrefNum++;
                        ledRt = resource.links[0]['rt'];
                    }
                    if (resource.links[0]['href'] === '/a/gas') {
                        gasHrefNum++;
                        gasRt = resource.links[0]['rt'];
                    }                    
                }, function allDone(){
                    assert.equal(1, ledHrefNum);
                    assert.equal('oic.r.led', ledRt);
                    assert.equal(1, gasHrefNum);
                    assert.equal('oic.r.sensor.carbondioxide', gasRt);
                });
            });
        });
        req.end();
        childLed.kill('SIGINT');
        childGas.kill('SIGINT');
        done();
    })
});

