---
title: nextjs中添加GrowingIO代码
categories: "nextjs"
---

```
          <script
            type="text/javascript"
            dangerouslySetInnerHTML={{
              __html: `
<!-- GrowingIO Analytics code version 2.1 -->
<!-- Copyright 2015-2018 GrowingIO, Inc. More info available at http://www.growingio.com -->

  !function(e,t,n,g,i){e[i]=e[i]||function(){
    (e[i].q=e[i].q||[]).push(arguments)},n=t.createElement("script"),tag=t.getElementsByTagName("script")[0],
    n.async=1,n.src=('https:'==document.location.protocol?'https://':'http://')+g,tag.parentNode.insertBefore(n,tag)
  }
  (window,document,"script",
  "assets.giocdn.com/2.1/gio.js","gio");
  gio('init','xxxxxxxxx', {});

  //custom page code begin here

  //custom page code end here

  gio('send');

<!-- End GrowingIO Analytics code version: 2.1 -->
`
            }}
          />
```
