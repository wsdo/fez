---
order: 0
title:
  zh-CN: 订阅号列表
  en-US: List
---

````jsx
import { Card, Icon, Avatar } from 'antd';

const { Meta } = Card

const data = [
  {
    title: '前端探秘',
    desc: '前端探秘，探索前端你不知道的秘密',
    wechat: 'itxishu',
    qr:'https://open.weixin.qq.com/qr/code?username=frontshow'
  },
  {
    title: '前端之巅',
    desc: '关注前端发展，分享一线技术。不断学习，不断进步，登上前端之巅！',
    wechat: 'frontshow',
    qr:'https://open.weixin.qq.com/qr/code?username=frontshow'
  },
  {
    title: '技术最前线',
    desc: '「技术最前线」是伯乐头条的官方微信公众号，专注分享 IT 最新技术和业界动态。',
    wechat: 'TopITNews',
    qr:'http://open.weixin.qq.com/qr/code?username=TopITNews'
  },
  {
    title: '前端早读课',
    desc: '关注前端，产品设计。  每天5点半推送1篇相关文章到公众号，我们不创造内容，我们只是优秀内容的搬运者。  坚持每天阅读，每天进步一点点',
    wechat: 'FeZaoDuKe',
    qr:'http://open.weixin.qq.com/qr/code?username=FeZaoDuKe'
  },
  {
    title: 'Node全栈',
    desc: '一个全栈程序员的世界，关注最新开源技术架构，编程实践，敏捷开发，当然偶尔也会有我给朋友们的解惑文章，欢迎关注，欢迎提问',
    wechat: 'nodeonly',
    qr:'http://open.weixin.qq.com/qr/code?username=nodeonly'
  },
  {
    title: '前端外刊评论',
    desc: '最新、最前沿的前端资讯，最有深入、最干前端相关的技术译文。',
    wechat: 'FrontendMagazine',
    qr:'http://open.weixin.qq.com/qr/code?username=FrontendMagazine'
  },
  {
    title: 'DDFE',
    desc: '滴滴前端技术分享 - 推荐国内外前沿、优秀的技术内容，包含 Nodejs、工程自动化、编译器、新技术方向等',
    wechat: 'gh_24b9dae85adf',
    qr:'http://open.weixin.qq.com/qr/code?username=gh_24b9dae85adf'
  },
  {
    title: '奇舞周刊',
    desc: '《奇舞周刊》是由奇舞团维护的前端技术周刊。每周五向大家推送前端技术文章。',
    wechat: 'gh_ffb279ea1674',
    qr:'http://open.weixin.qq.com/qr/code?username=gh_ffb279ea1674'
  },
];
ReactDOM.render(
    <div className="resource-cards">
       {data.map(res=>{
      return   <Card
    className="resource"
    style={{ width: 300 }}
    cover={<img alt="example" src={res.qr} />}
    // actions={[<Icon type="setting" />, <Icon type="edit" />, <Icon type="ellipsis" />]}
  >
    <Meta
      // avatar={<Avatar src={res.logo} />}
      title={res.title}
      description={res.desc}
    />
  </Card>
    })}
  </div>,
  mountNode
);


````
<style>
.resource {
  margin:20px;
}
</style>

