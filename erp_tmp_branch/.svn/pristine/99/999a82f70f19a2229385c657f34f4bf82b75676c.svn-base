<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>请求频次分布图</title>
    <meta name="decorator" content="base"/>
    <script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/highcharts.js"></script>
    <script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/modules/heatmap.js"></script>
    <script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/modules/treemap.js"></script>
    <script type="text/javascript" src="${ctxPlugin }/lib/Highcharts/4.1.7/js/modules/exporting.js"></script>

    <style>
    </style>
</head>
<body style="height: 100%">
<div style="width: 100%;height: 100%;position: absolute;top: 0;left: 0;" id="container">
</div>

<script>
    $(function () {
        var data = [];
        <c:forEach items="${countmap}" var="item" varStatus="status">
            data.push({
                name: '${item.actionPath}',
                value: ${item.invokeTimesBetweens},
                colorValue: ${status.index+1}
            });
        </c:forEach>

        $('#container').highcharts({
            colorAxis: {
                minColor: '#FFFFFF',
                maxColor: Highcharts.getOptions().colors[0]
            },
            series: [{
                type: "treemap",
                layoutAlgorithm: 'squarified',
                turboThreshold: 2000,
                data: data
            }],
            title: {
                text: '频次分布图'
            }
        });
    });
</script>
</body>
</html>