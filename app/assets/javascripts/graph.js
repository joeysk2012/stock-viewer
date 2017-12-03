
var parameter = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=SPX&interval=15min&apikey=QWDLNLRUB7CZV7TO'

fetch(parameter)
.then(
  function(response) {
    if (response.status !== 200) {
      console.log('Looks like there was a problem. Status Code: ' +
        response.status);
      return;
    }
    response.json().then(function(data) {
      passDataToGraph1(data)      
    });
  }
)
.catch(function(err) {
  console.log('Fetch Error :-S', err);
});

function passDataToGraph1(data){
  var symbol = data["Meta Data"]["2. Symbol"]
  var unit = "$"
  var hash = data["Time Series (15min)"]
  var row = [];
  var time = []; 
  for(var key in hash){
    var val_price = hash[key]["1. open"]
    var val_time = key
   row.push(parseInt(val_price))
   time.push(val_time)
  }

  today = time[0].split(" ")[0]
  time = time.filter( ti => ti.includes(today))
  time = time.map(ti => new Date(ti))
  row = ['Price of ' + symbol].concat(row)
  time =['x'].concat(time)
  var elementExists = document.getElementById('chart-title')
  if(!!elementExists){
  document.getElementById('chart-title').innerHTML = symbol + "for  " + today
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

