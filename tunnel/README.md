注意事项
---

最新版本HomeAssistant中，需要在configuration.yaml中增加如下配置：  
```
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.30.33.0/24
```
