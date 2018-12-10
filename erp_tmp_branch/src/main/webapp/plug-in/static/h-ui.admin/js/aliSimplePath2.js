/*
 * 高德地图的简单轨迹绘制
 */
var pathSimplifierLoaded = false;
var pathSimplifierLastMap = null;

function drawSimplePath(map, lineData, lngLatMinMax) {
    if (map !== pathSimplifierLastMap) {
        pathSimplifierLastMap = map;
        pathSimplifierLoaded = false;
    }

    if (pathSimplifierLoaded) {
        createNav(lineData, lngLatMinMax);
    }

    if (!pathSimplifierLoaded) {
        pathSimplifierLoaded = true;
        AMapUI.load(['ui/misc/PathSimplifier', 'lib/$'], function (PathSimplifier, $) {
            if (!PathSimplifier.supportCanvas) {
                alert('当前环境不支持 Canvas！');
                return;
            }
            window.pathSimplifierIns = new PathSimplifier({
                zIndex: 100,
                map: map, //所属的地图实例
                getPath: function (pathData, pathIndex) {
                    return pathData.path;
                },
                getHoverTitle: function (pathData, pathIndex, pointIndex) {
                    return "工程师轨迹";
                },
                renderOptions: {
                    renderAllPointsIfNumberBelow: 100 //绘制路线节点，如不需要可设置为-1
                }
            });
            createNav(lineData, lngLatMinMax);
        });
    }
}

function createNav(lineData, lngLatMinMax) {
    window.pathSimplifierIns.clearPathNavigators();
    var distanceUnit = 100;
    if (lngLatMinMax) {
        var lngLatMin = lngLatMinMax.split("_")[0];
        var lngLatMax = lngLatMinMax.split("_")[1];
        var lngLat = new AMap.LngLat(lngLatMin.split(",")[0] * 1.0, lngLatMin.split(",")[1] * 1.0);
        distanceUnit = lngLat.distance([lngLatMax.split(",")[0] * 1.0, lngLatMax.split(",")[1] * 1.0]);
    }
    //设置数据
    window.pathSimplifierIns.setData([{
        name: '轨迹路线',
        path: lineData
    }]);
    //对第一条线路（即索引 0）创建一个巡航器
    var navi = window.pathSimplifierIns.createPathNavigator(0, {
        loop: true, //循环播放
        speed: distanceUnit * 1.5 //巡航速度，单位千米/小时
    });
    navi.start();
}
