# npm set proxy server configuration

You can use the following configuration to set proxy server for npm:

```
npm config set proxy http://<HTTP_PROXY_SERVER>:<HTTP_PORT>
npm config set https-proxy https://<HTTPS_PROXY_SERVER>:<HTTPS_PORT>
```

In Intel, we use the following configuration for npm

```
npm config proxy http://child-prc.intel.com:913
npm config https-proxy http://child-prc.intel.com:913
```

Reference:
[How to setup Node.js and Npm behind a corporate web proxy?](http://jjasonclark.com/how-to-setup-node-behind-web-proxy/)
