<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=alvcgg86ei&submodules=geocoder"></script>
	<style>
        #storePageMain * {
            box-sizing: border-box;
        }
        #storePageMain{
            max-width: 1200px;
            width: 100%;
        }
        #storePageMain>h1{
            font-size: 3em;
            text-align: center;
            margin-bottom: 50px;
        }
        #storeInfo{
	       padding: 10px;
        }
        
        
        
        #storeImage{
	        height: 500px;
	        overflow: hidden;
	        border-radius: 10px;
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        margin-bottom: 20px;
        }
        #storeInfo img{
	        width: 100%;
        }
        .underLine{
	        width: 100%;
	        height: 0;
	        border-bottom: 1px solid #93C759;
	        margin-bottom: 20px;
        }
        
        
        #storeDescription{
	        width: 100%;
	        display: flex;
        }
        #storeDescription>div{
	        width: 100%;
	        padding: 10px;
        }
        #storeDetails {
            width: 100%;
        }
        #storeDetails>*>*{
	        height: 40px;
	        line-height: 40px;
	        border-bottom: 1px solid #93C759;
        }
        #storeDetails td:first-child{
	        /*width: 25%;*/
	        text-align: center;
        }
        #storeDetails td{
            padding-left: 10px;
            padding-right: 10px;
        }
        
        #map{
            width: 100%;
	        height: 100%;
            margin-bottom: 20px;
        }
        #storeHello{
	        height: 250px;
	        display: flex;
	        flex-direction: column;
        }
        #storeHello>h3{
            width: 100%;
            height: 40px;
            line-height: 40px;
            font-size: 1.25em;
            font-weight: 500;
            text-align: center;
            border-bottom: 1px solid #93C759;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        #storeHello>div{
            width: 100%;
            height: 100%;
            padding: 10px;
	        flex-grow: 1;
        }
        
        
        /* 메뉴 리스트*/
        @media (max-width: 900px) {
            #menus{
                grid-template-columns: 1fr 1fr 1fr !important;
            }
        }
        @media (max-width: 800px) {
            #menus{
                grid-template-columns: 1fr 1fr !important;
            }
        }
        #menus{
            display: grid;
            grid-template-columns: 1fr 1fr 1fr 1fr;
            /*grid-template-rows: 1fr 1fr;*/
            justify-items: center;
            /*flex-direction: row;*/
            /*flex-wrap: wrap;*/
        }
        .menuList{
            max-width: 300px;
            min-width: 200px;
            /*width: 100%;*/
            height: 400px;
            margin: 10px;
            border: 1px solid #1ebee6;

        }
        .menuList>div{
            height: 100%;
            padding: 10px;
            display: grid;
            grid-template-rows: 200px 1fr;
            grid-template-columns: 1fr;
        }
        .imgView{
            width: 100%;
            height: 200px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 10px;
        }/* 이미지 */
        .menuList img{
            width: 100%;
        }
        .menuDescription{
            display: grid;
            grid-template-rows:  40px 1fr;
            grid-template-columns: 1fr;
            align-items: stretch;
        }
        .menuDescription>h3{
            font-weight: bold;
            font-size: 1.5em;
            text-align: center;
            line-height: 40px;
        }
        .menuDescription>div{
            padding: 10px;
        }
	</style>
</head>
<body>
<main id="storePageMain">
	
	<h1>[ ${vo.place} ]</h1>
	<div class="underLine"></div>
	<section id="storeInfo">
		<div id="storeImage">
			<img src="/resources/img/Store/${vo.UID}/${vo.imgPath}" onerror="this.src='/resources/main/menuNone.png'">
		</div>
		<div id="storeMapImg">
		
		</div>
		
		<div class="underLine" style="margin-bottom: 5px"></div>
		<div id="storeDescription">
			<div id="storeMessage">
				<div id="map"></div>
			</div>
			<div id="StoreAll">
				<table id="storeDetails">
					<thead>
					<tr>
						<th>설명</th>
						<th>상세</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td>사업자 번호</td>
						<td>${vo.bizno}</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>${vo.address}</td>
					</tr>
					<tr>
						<td>영업일</td>
						<td>${vo.date}</td>
					</tr>
					<tr>
						<td>영업시간</td>
						<td>${vo.time}</td>
					</tr>
					<tr>
						<td>최종 수정일</td>
						<td>${vo.lasttouch}</td>
					</tr>
					</tbody>
				</table>
				<div id="storeHello">
					<h3>상점 소개글</h3>
					<div>${vo.other}</div>
				</div>
			</div>
			
		</div>
		<div class="underLine" style="margin-top: 10px"></div>
	</section>
	<section id="menus">
		<c:forEach var="li" items="${list}">
			<article class="menuList">
				<div>
					<div class="imgView">
						<img src="${li.imgPath}" alt="" onerror="this.src='/resources/main/menuNone.png'">
					</div>
					<div class="menuDescription">
						<h3>${li.subject}</h3>
						<div>${li.content}</div>
					</div>
				</div>
			</article>
		</c:forEach>
	</section>

</main>
<script>
    var map = new naver.maps.Map("map", {
        center: new naver.maps.LatLng(37.3595316, 127.1052133),
        zoom: 15,
        mapTypeControl: true
    });


    var infoWindow = new naver.maps.InfoWindow({
        anchorSkew: true
    });

    map.setCursor('pointer');

    function searchCoordinateToAddress(latlng) {

        infoWindow.close();

        naver.maps.Service.reverseGeocode({
            coords: latlng,
            orders: [
                naver.maps.Service.OrderType.ADDR,
                naver.maps.Service.OrderType.ROAD_ADDR
            ].join(',')
        }, function(status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                return alert('Something Wrong!');
            }

            var items = response.v2.results,
                address = '',
                htmlAddresses = [];

            for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
                item = items[i];
                address = makeAddress(item) || '';
                addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';

                htmlAddresses.push((i+1) +'. '+ addrType +' '+ address);
            }

            infoWindow.setContent([
                '<div style="padding:10px;min-width:200px;line-height:150%;">',
                '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
                htmlAddresses.join('<br />'),
                '</div>'
            ].join('\n'));

            infoWindow.open(map, latlng);
        });
    }

    function searchAddressToCoordinate(address) {
        naver.maps.Service.geocode({
            query: address
        }, function(status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
                return alert('Something Wrong!');
            }

            if (response.v2.meta.totalCount === 0) {
                return alert('totalCount' + response.v2.meta.totalCount);
            }

            var htmlAddresses = [],
                item = response.v2.addresses[0],
                point = new naver.maps.Point(item.x, item.y);

            if (item.roadAddress) {
                htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
            }

            if (item.jibunAddress) {
                htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
            }

            if (item.englishAddress) {
                htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
            }

            infoWindow.setContent([
                '<div style="padding:10px;min-width:200px;line-height:150%;">',
                '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
                htmlAddresses.join('<br />'),
                '</div>'
            ].join('\n'));

            map.setCenter(point);
            infoWindow.open(map, point);
        });
    }
    function initGeocoder() {
        map.addListener('click', function(e) {
            searchCoordinateToAddress(e.coord);
        });

        $('#address').on('keydown', function(e) {
            var keyCode = e.which;

            if (keyCode === 13) { // Enter Key
                searchAddressToCoordinate($('#address').val());
            }
        });

        $('#submit').on('click', function(e) {
            e.preventDefault();

            searchAddressToCoordinate($('#address').val());
        });

        searchAddressToCoordinate('${vo.address}');
    }
    function makeAddress(item) {
        if (!item) {
            return;
        }

        var name = item.name,
            region = item.region,
            land = item.land,
            isRoadAddress = name === 'roadaddr';

        var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';

        if (hasArea(region.area1)) {
            sido = region.area1.name;
        }

        if (hasArea(region.area2)) {
            sigugun = region.area2.name;
        }

        if (hasArea(region.area3)) {
            dongmyun = region.area3.name;
        }

        if (hasArea(region.area4)) {
            ri = region.area4.name;
        }

        if (land) {
            if (hasData(land.number1)) {
                if (hasData(land.type) && land.type === '2') {
                    rest += '산';
                }

                rest += land.number1;

                if (hasData(land.number2)) {
                    rest += ('-' + land.number2);
                }
            }

            if (isRoadAddress === true) {
                if (checkLastString(dongmyun, '면')) {
                    ri = land.name;
                } else {
                    dongmyun = land.name;
                    ri = '';
                }

                if (hasAddition(land.addition0)) {
                    rest += ' ' + land.addition0.value;
                }
            }
        }

        return [sido, sigugun, dongmyun, ri, rest].join(' ');
    }
    function hasArea(area) {
        return !!(area && area.name && area.name !== '');
    }
    function hasData(data) {
        return !!(data && data !== '');
    }
    function checkLastString (word, lastString) {
        return new RegExp(lastString + '$').test(word);
    }
    function hasAddition (addition) {
        return !!(addition && addition.value);
    }
    naver.maps.onJSContentLoaded = initGeocoder;
</script>
</body>

