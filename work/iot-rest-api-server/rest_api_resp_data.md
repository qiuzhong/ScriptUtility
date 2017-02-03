# iot-rest-api-server response data

## Discover devices
```
# curl http://127.0.0.1:8000/api/oic/d  
[{"di":"63653237-3561-3632-2d64-3339622d3438","n":"Smart Home LED","icv":"1.0.0"}]
```

## Discover platforms
```
# curl http://127.0.0.1:8000/api/oic/p  
[{"pi":"ce275a62-d39b-48d3-8740-6c6ed414acc2","mnmn":"Intel","mndt":"2015-10-30T10:04:17.000Z","mnpv":"1.1.0","mnfv":"0.0.1"}]
```

## Discover resources
```
# curl http://127.0.0.1:8000/api/oic/res
[{"di":"63653237-3561-3632-2d64-3339622d3438","links":[{"href":"/oic/sec/doxm","rt":"oic.r.doxm","if":"oic.if.baseline"}]},{"di":"63653237-3561-3632-2d64-3339622d3438","links":[{"href":"/oic/sec/pstat","rt":"oic.r.pstat","if":"oic.if.baseline"}]},{"di":"63653237-3561-3632-2d64-3339622d3438","links":[{"href":"/oic/d","rt":"oic.wk.d","if":"oic.if.baseline"}]},{"di":"63653237-3561-3632-2d64-3339622d3438","links":[{"href":"/oic/p","rt":"oic.wk.p","if":"oic.if.baseline"}]},{"di":"63653237-3561-3632-2d64-3339622d3438","links":[{"href":"/a/led","rt":"oic.r.led","if":"oic.if.baseline"}]}]
```