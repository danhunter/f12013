function format_number(number) {
	var number_string = number + '';
	var x, x1, x2;
	x = number_string.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}

function countdown(date, laptime, driver){

  var difference;
  var seconds, minutes, hours, days;
  var remaining_seconds, remaining_minutes, remaining_hours;

  var race_date = new Date(date);

  setInterval(function(){
    difference = Math.abs(new Date() - race_date);

    seconds = Math.floor(difference / 1000);

    remaining_seconds = seconds % 60;
    minutes = Math.floor(seconds / 60);

    remaining_minutes = minutes % 60;  
    hours = Math.floor(minutes / 60);

    remaining_hours = hours % 24;
    days = Math.floor(hours / 24);
    
    var dayshrs = "";
    
    if (days > 0) {
      
      dayshrs += (days != 1) ? days + " DAYS, " : days + " DAY, ";
    }
    
    dayshrs += (remaining_hours != 1) ? remaining_hours + " HOURS" : remaining_hours + " HOUR";
    
    var minssecs = "";
    
    minssecs += (remaining_minutes != 1) ? remaining_minutes + " MINUTES, " : remaining_minutes + " MINUTE ";
    minssecs += (remaining_seconds != 1) ? remaining_seconds + " SECONDS" : remaining_seconds + " SECOND";
    
    document.getElementById("dayshrs").innerHTML = dayshrs;
    document.getElementById("minssecs").innerHTML = minssecs;
    
    var laps = format_number(Math.ceil(difference / laptime));
    
    var lap_string = "";
    
    if (laps == 1) {
      lap_string = laps + " lap";
    } else if (laps < 1) {
      lap_string = "less than a lap";
    }else {
      lap_string = laps + " laps";
    }
      
    
    document.getElementById("laps").innerHTML = "(or " + lap_string + ", based on " + driver +   "'s 2010 fastest lap)";
  }, 100);
}