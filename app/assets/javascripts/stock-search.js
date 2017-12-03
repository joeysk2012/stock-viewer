$( document ).ready(function() {
  console.log("loaded")
  $('#get-symbol').click(function(e) {
    e.preventDefault()
    var symbol = $('#search-field').val()
    console.log(symbol)
    var parameter = 'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=' + symbol + '&interval=15min&apikey=QWDLNLRUB7CZV7TO'
    $.ajax({
      url: parameter,
      type: "GET",
      success: function (data) { 
        console.log(data)
          setData(data)
      }
      });
});

function setData(product){
  var tracker = product["Meta Data"]["2. Symbol"]
  var unit = "$"
  var hash = product["Time Series (15min)"]
  var row = []
  for(var key in hash){
    var val_price = hash[key]["1. open"]
   row.push(parseInt(val_price))
  }
  $('#display-tracker').html(tracker)
  $('#display-price').html(row[0])
  $('#symbol-text').val(tracker)
  $('#buy-price').val(row[0])
  $('#current-price').val(row[0])

}

});
