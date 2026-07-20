
## think-trace 调试
用于ThinkPHP8.1的页面Trace扩展，支持Html页面和浏览器控制台两种方式输出。

基于版本 https://github.com/top-think/think-trace/tree/v2.0

文档地址 https://doc.thinkphp.cn/v8_0/trace.html

### 安装
~~~
composer require ibibicloud/think-trace
~~~

### 开启 Trace 调试 app/service.php
~~~
return [
	// 开启 Trace 调试
    '\think\trace\Service',
];
~~~

### 配置
安装后config目录下会自带trace.php配置文件。

type参数用于指定trace类型，支持html和console两种方式。