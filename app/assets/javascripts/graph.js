$( document ).ready(function() {
  
  var daily_parameter = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=NDAQ&interval=15min&apikey=QWDLNLRUB7CZV7TO'
  var monthly_parameter = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=NDAQ&interval=15min&apikey=QWDLNLRUB7CZV7TO'
  var yearly_parameter = 'https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=NDAQ&apikey=QWDLNLRUB7CZV7TO'
  
  parameter_array = [daily_parameter, monthly_parameter, yearly_parameter]

  for(i = 0 ; i < 2 ; i++){
    makeApiCall(parameter_array[i])
  }

  function makeApiCall(parameter){
    fetch(parameter_array[i])
    .then(
      function(response) {
        if (response.status !== 200) {
          console.log('Looks like there was a problem. Status Code: ' +
            response.status);
          return;
        }
        response.json().then(function(data) {
          if(data["Meta Data"]["1. Information"].includes("Intraday")){
            passDataToGraph1(data) 
            
          }
          if(data["Meta Data"]["1. Information"].includes("Daily Prices")){
          passDataToGraph2(data)
          }
          if(data["Meta Data"]["1. Information"].includes("Monthly")){
            passDataToGraph3(data)
          }
        });
      }
    )
    .catch(function(err) {
      console.log('Fetch Error :-S', err);
    });
  }


  function passDataToGraph1(data){
    var symbol = data["Meta Data"]["2. Symbol"]
    var unit = "$"
    var hash = data["Time Series (15min)"]
    var row = [];
    var time = []; 
    for(var key in hash){
      var val_price = hash[key]["1. open"]
      var val_time = key
    row.push(parseFloat(val_price).toFixed(2))
    time.push(val_time)
    }

    today = time[0].split(" ")[0]
    time = time.filter( ti => ti.includes(today))
    time = time.map(ti => new Date(ti))
    row = ['Price of ' + symbol].concat(row)
    time =['x'].concat(time)
    var elementExists = document.getElementById('chart-title1')
    if(!!elementExists){
    document.getElementById('chart-title1').innerHTML = symbol + "for  " + today
    }else{
      return
    }

    var chart = c3.generate({
          bindto: '#chart1',
          data: {
            x: 'x',
            columns: [
              time,
              row
            ]
          },
          axis: {
            x: {
              type: 'timeseries',
                label: 'Date/Time',
                tick: {
                    format: '%Y-%m-%d %H:%M:%S',
                    rotate: 90
                }
            },
            y: {
              label: unit
          }    
        }  
      });
  }

  function passDataToGraph2(data){
    var symbol = data["Meta Data"]["2. Symbol"]
    var unit = "$"
    var hash = data["Time Series (Daily)"]
    var row = [];
    var time = []; 
    for(var key in hash){
      var val_price = hash[key]["1. open"]
      var val_date = key
    row.push(parseFloat(val_price).toFixed(2))
    time.push(val_date)
    }
    month = "Last 30 days"
    time = time.slice(0,30)
    row = row.slice(0,30)
    time = time.map(ti => new Date(ti))
    row = ['Price for the  ' + month].concat(row)
    time =['x'].concat(time)
    var elementExists = document.getElementById('chart-title2')
    if(!!elementExists){
    document.getElementById('chart-title2').innerHTML = symbol + " for  " + month
    }else{
      return
    }

    var chart = c3.generate({
          bindto: '#chart2',
          data: {
            x: 'x',
            columns: [
              time,
              row
            ]
          },
          axis: {
            x: {
              type: 'timeseries',
                label: 'Date',
                tick: {
                    format: '%Y-%m-%d',
                    rotate: 90
                }
            },
            y: {
              label: unit
          }    
        }  
      });
  }

  function passDataToGraph3(data){
    var symbol = data["Meta Data"]["2. Symbol"]
    var unit = "$"
    var hash = data["Monthly Time Series"]
    var row = [];
    var time = []; 
    for(var key in hash){
      var val_price = hash[key]["1. open"]
      var val_date = key
    row.push(parseFloat(val_price).toFixed(2))
    time.push(val_date)
    }

    year = "Last 52 Weeks"
    time = time.map(ti => new Date(ti))
    row = row.slice(0,12)
    time = time.slice(0,12)
    row = ['Price of ' + symbol].concat(row)
    time =['x'].concat(time)
    var elementExists = document.getElementById('chart-title3')
    if(!!elementExists){
    document.getElementById('chart-title3').innerHTML = symbol + " for  " + year
    }else{
      return
    }

    var chart = c3.generate({
          bindto: '#chart3',
          data: {
            x: 'x',
            columns: [
              time,
              row
            ]
          },
          axis: {
            x: {
              type: 'timeseries',
                label: 'Date',
                tick: {
                    format: '%Y-%m',
                    rotate: 90
                }
            },
            y: {
              label: unit
          }    
        }  
      });
  }
});