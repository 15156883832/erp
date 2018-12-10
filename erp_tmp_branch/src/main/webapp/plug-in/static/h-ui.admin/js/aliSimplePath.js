/*
 * 高德地图的简单轨迹绘制
 */
function drawSimplePath(map, lineData, lngLatMinMax){
	AMapUI.load(['ui/misc/PathSimplifier', 'lib/$'], function(PathSimplifier, $) {
		if (!PathSimplifier.supportCanvas) {
			alert('当前环境不支持 Canvas！');
			return;
		}
		var pathSimplifierIns = new PathSimplifier({
			zIndex: 100,
			//autoSetFitView:false,
			map: map, //所属的地图实例
			getPath: function(pathData, pathIndex) {
				return pathData.path;
			},
			getHoverTitle: function(pathData, pathIndex, pointIndex) {
				/*if (pointIndex >= 0) {
					//point 
					return pathData.name + '，点：' + pointIndex + '/' + pathData.path.length;
				}*/
				//return pathData.name + '，点数量' + pathData.path.length;
				return "今日轨迹";
			},
			renderOptions: {
				renderAllPointsIfNumberBelow: 100 //绘制路线节点，如不需要可设置为-1
			}
		});
		
		var distanceUnit = 100;
		if(lngLatMinMax != null && lngLatMinMax != undefined && lngLatMinMax != ""){
			var lngLatMin = lngLatMinMax.split("_")[0];
			var lngLatMax = lngLatMinMax.split("_")[1]; 
			var lnglat = new AMap.LngLat(lngLatMin.split(",")[0]*1.0, lngLatMin.split(",")[1]*1.0);
			distanceUnit = lnglat.distance([lngLatMax.split(",")[0]*1.0, lngLatMax.split(",")[1]*1.0]); 
		}
		window.pathSimplifierIns = pathSimplifierIns;
		//设置数据
		pathSimplifierIns.setData([{
			name: '轨迹路线',
			path: lineData
				/*
				[
				[117.214119, 31.813645],
				[117.224119, 31.823645],
				[117.234119, 31.833645],
				[117.244119, 31.843645],
				[117.254119, 31.853645],
				[117.264119, 31.863645],
				[117.274119, 31.873645],
				[117.284119, 31.88645],
				[117.294119, 31.893645],
				[117.304119, 31.913645],
				[117.314119, 31.933645],
				[117.324119, 31.943645],//*
				[117.314119, 31.933645],
				[117.304119, 31.913645],
				[117.294119, 31.893645],
				[117.284119, 31.88645],
				[117.274119, 31.873645],
				[117.264119, 31.863645],
				[117.254119, 31.853645],
				[117.244119, 31.843645],
				[117.234119, 31.833645],
				[117.224119, 31.823645],
				[117.214119, 31.813645]
				]
				*/
		}]);
		//对第一条线路（即索引 0）创建一个巡航器
		var navg1 = pathSimplifierIns.createPathNavigator(0, {
			loop: true, //循环播放
			speed: distanceUnit*1.5 //巡航速度，单位千米/小时
		});
		navg1.start();
	});
}