<%@ page contentType="text/html;charset=UTF-8" %><%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=0.3,user-scalable=yes" />
	<title>超级管理员portal页</title>
	<!-- jquery 1.4 and jquery ui 1.8 -->
    <link rel="stylesheet" href="${ctxStatic}/jquery-portlet/lib/themes/1.10/start/jquery-ui-1.10.2.custom.min.css" />
    <link rel="stylesheet" href="${ctxStatic}/jquery-portlet/css/jquery.portlet.css?v=1.3.1" />
    <script src="${ctxStatic}/jquery-portlet/lib/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/jquery-portlet/lib/jquery-ui-1.10.2.custom.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/jquery-portlet/script/jquery.portlet.pack.js"></script>
    <link href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link href="${ctxStatic}/common/jeesite.min.css" type="text/css" rel="stylesheet" />
	<style>
    body {font-size: 13px;}
    .ui-widget-header {border: 0px;}
    .ui-corner-all, .ui-corner-bottom, .ui-corner-right, .ui-corner-br{border-bottom-right-radius:0px;border-bottom-left-radius:0px;}
    .ui-portlet-item{margin: 2px;}
    .ui-portlet-column{padding-bottom: 5px;}
    </style>
    <script>
    $(function() {
        $('#portlet').portlet({
            sortable: true,
            create: function() {
            },
            removeItem: function() {
            },
            columns: [{
                width: 400,
                portlets: [{
                    attrs: {
                        id: 'news'
                    },
                    title: 'jojowo crm 介绍',
                    beforeRefresh: function() {
                    },
                    afterRefresh: function(data) {
                    },
                    content: {
                        type: 'text',
                        style: {
                            height: '410'
                        },
                        text: function() {
                            return $('#newsTemplate').html();
                        }
                    }
                }]
            }, {
                width: 749,
                portlets: [{
                    title: '功能介绍',
                    content: {
                        type: 'text',
                        style: {
                            height: '182'
                        },
                        text: function() {
                            return $('#tableTemplate1').html();
                        }
                    }
                },{
                    title: '积分功能',
                    content: {
                        type: 'text',
                        style: {
                            height: '184'
                        },
                        text: function() {
                        	return $('#tableTemplate2').html();
                        }
                    }
                }]
            }]
        });
    });
    </script>
</head>
<body>
	<div style="height: 50px;z-index: 999999; "><ul class="breadcrumb" style="position:fixed;top: 0px;width: 100%;">
	  <li><a href="${ctx}/portal"><i class="icon-home icon-white"></i></a></li>
	</ul></div>
    <div id='portlet'></div>
	
    <!-- 模板 -->
    <div id="newsTemplate" style="display:none">
        <p class="text-success" style="text-indent:2em;line-height:2em;"> JOJOWO.NET,是国内首家O2O售后服务网络平台，我们的使命是通过构建国内最便捷、最人性化的服务平台，为亿万消费者提供全方位的智能服务保障和最佳的用户体验；为服务商朋友提供“最全面的网络服务订单获取能力+最专业的服务人才交流平台+最实用的维修必备教材+最完备的维修工具、主材、辅材及附件供应体系”。通过一站式电子商务服务生态系统，帮助每一个服务商实现运营环节的提效与增值。</p>
        <p class="text-info" style="text-indent:2em;line-height:2em;">回首过去，除售后服务行业之外的每一个行业，都在发生深刻复杂的变化。JOJOWO.NET，正是在这种情况下应运而生，顺势而为。作为连接用户和服务商不可或缺的重要纽带，JOJOWO.NET除在内容上提供最新最全的服务资讯外，还在积极的推动服务行业的转型、升级。</p>
    </div>

    <div id="tableTemplate1" style="display:none">
        <p  class="text-success" style="line-height:2em;">1.专属“家电管家”给您不一样的服务感受。</p>
		<p  class="text-info" style="line-height:2em;">2.整机及关键零部件即将到期之前的温馨提示且网站会员中心、微信公众平台皆可准确查询。</p>
		<p  class="text-warning" style="line-height:2em;">3.根据不同家电的使用特性，在特定时间提示您使用时的注意事项，让您的生活更加便捷。</p>
		<p  class="text-error" style="line-height:2em;">4.家电出现故障后，您只需轻轻一点，家电管家轻松帮你搞定，服务效果由您来评定。</p>
		<p  class="text-success" style="line-height:2em;">5.随时查询个人订单处理进度。</p>
		<p  class="text-info" style="line-height:2em;">6.留存产品历次维修记录，便于查询。</p>
		<p  class="text-warning" style="line-height:2em;">7.注册成为会员，体验一站式服务的同时还可获取相应的积分。更有机会获得家电的免费清洗活动的机会。</p>
    </div>
    <div id="tableTemplate2" style="display:none">
        <p  class="text-success" style="line-height:1.75em;">（一）个人用户<br/>
		 1. jojowo.net个人会员积分已达到某一兑换积分标准时，会员可将积分依照jojowo.net相应积分及兑换标准兑换相应的家电除味剂、清洗保养服务等，jojowo.net即时从会员积分中扣减相应积分。<br/>
		 2. 各回馈项目（包含除味剂、清洗保养服务等）及兑换标准、兑换规则均以兑换当时最新的回馈活动公告或目录为准。 <br/>
		（二）商家用户<br/>
		 1. jojowo.net商家会员积分已达到某一兑换积分标准时，会员可将积分依照jojowo.net相应积分及兑换标准兑换相应的维修工具、维修教材等，jojowo.net即时从会员积分中扣减相应积分。<br/>
		 2. 各回馈项目（包含维修教材、光盘资料、维修工具等）及兑换标准、兑换规则均以兑换当时最新的回馈活动公告或目录为准。
		 </p>
    </div>
    
    
    
</body>
</html>