$(document).ready(function(){function t(){fetch(parameter_array[i]).then(function(t){200===t.status?t.json().then(function(t){t["Meta Data"]["1. Information"].includes("Intraday")&&e(t),t["Meta Data"]["1. Information"].includes("Daily Prices")&&a(t),t["Meta Data"]["1. Information"].includes("Monthly")&&n(t)}):console.log("Looks like there was a problem. Status Code: "+t.status)})["catch"](function(t){console.log("Fetch Error :-S",t)})}function e(t){var e=t["Meta Data"]["2. Symbol"],a="$",n=t["Time Series (15min)"],o=[],i=[];for(var r in n){var c=n[r]["1. open"],l=r;o.push(parseFloat(c).toFixed(2)),i.push(l)}if(today=i[0].split(" ")[0],i=(i=i.filter(t=>t.includes(today))).map(t=>new Date(t)),o=["Price of "+e].concat(o),i=["x"].concat(i),document.getElementById("chart-title1")){document.getElementById("chart-title1").innerHTML=e+"for  "+today;c3.generate({bindto:"#chart1",data:{x:"x",columns:[i,o]},axis:{x:{type:"timeseries",label:"Date/Time",tick:{format:"%Y-%m-%d %H:%M:%S",rotate:90}},y:{label:a}}})}}function a(t){var e=t["Meta Data"]["2. Symbol"],a="$",n=t["Time Series (Daily)"],o=[],i=[];for(var r in n){var c=n[r]["1. open"],l=r;o.push(parseFloat(c).toFixed(2)),i.push(l)}if(month="Last 30 days",i=i.slice(0,30),o=o.slice(0,30),i=i.map(t=>new Date(t)),o=["Price for the  "+month].concat(o),i=["x"].concat(i),document.getElementById("chart-title2")){document.getElementById("chart-title2").innerHTML=e+" for  "+month;c3.generate({bindto:"#chart2",data:{x:"x",columns:[i,o]},axis:{x:{type:"timeseries",label:"Date",tick:{format:"%Y-%m-%d",rotate:90}},y:{label:a}}})}}function n(t){var e=t["Meta Data"]["2. Symbol"],a="$",n=t["Monthly Time Series"],o=[],i=[];for(var r in n){var c=n[r]["1. open"],l=r;o.push(parseFloat(c).toFixed(2)),i.push(l)}if(year="Last 52 Weeks",i=i.map(t=>new Date(t)),o=o.slice(0,12),i=i.slice(0,12),o=["Price of "+e].concat(o),i=["x"].concat(i),document.getElementById("chart-title3")){document.getElementById("chart-title3").innerHTML=e+" for  "+year;c3.generate({bindto:"#chart3",data:{x:"x",columns:[i,o]},axis:{x:{type:"timeseries",label:"Date",tick:{format:"%Y-%m",rotate:90}},y:{label:a}}})}}for(parameter_array=["https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=NDAQ&interval=15min&apikey=QWDLNLRUB7CZV7TO","https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=NDAQ&interval=15min&apikey=QWDLNLRUB7CZV7TO","https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=NDAQ&apikey=QWDLNLRUB7CZV7TO"],i=0;i<2;i++)t(parameter_array[i])});