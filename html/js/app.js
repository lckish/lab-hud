$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            //Inventory.Close();
            break;
    }
});

var moneyTimeout = null;
var CurrentProx = 0;

(() => {
    RCHud = {};

    RCHud.Open = function(data) {
        $(".money-cash").css("display", "block");
        // $(".money-bank").css("display", "block");
        $("#cash").html(data.cash);
        // $("#bank").html(data.bank);
    };

    RCHud.Close = function() {

    };

    RCHud.Show = function(data) {
        if(data.type == "cash") {
            $(".money-cash").fadeIn(150);
            $("#cash").html(data.cash);
            setTimeout(function() {
                $(".money-cash").fadeOut(750);
            }, 3500)
        } 
    };

    RCHud.ToggleSeatbelt = function(data) {
        if (data.seatbelt) {
            $("#beltColor path").css("fill", "rgb(22, 255, 1)")
        } else {
            $("#beltColor path").css("fill", "red")
        }
    };

    RCHud.Engine = function(data) {
        if (data.engine < 500) {
            $("#engineColor path").css("fill", "orange")
        } else {
            $("#engineColor path").css("fill", "white")
        }
    };


    RCHud.ToggleCruise = function(data) {
        if (data.cruise) {
            $("#cruise-icon path").css("fill", "green")
        } else {
            $("#cruise-icon path").css("fill", "red")
        }
    };

    RCHud.CarHud = function(data) {
        if (data.show) {
            $(".player-side").css({"display": "none"});     
            $(".vehicle-side").css({"display": "block"});          
     
        } else {
            $(".player-side").css({"display": "block"});     
            $(".vehicle-side").css({"display": "none"});   
            

        }
    };

    RCHud.HudBunny = function(data) {
        $(".hud").animate({
            // opacity: 0.25,
            top: "-=10",
            // height: "toggle"
          }, 300, function() {
            $(".hud").animate({
                // opacity: 0.25,
                top: "+=10",
                // height: "toggle"
              }, 250, function() {
                
              });

          });
    }

    RCHud.UpdateHud = function(data) {
        var Show = "block";
        if (data.show) {
            Show = "none";
            $(".hud").css("display", Show);
            return;
        }								
		
        $(".hud").css("display", Show);
        // console.log(data.hunger, data.health);
        // HP Bar

        // data.playerData.metadata.skills.strength.current.toFixed(1) +
        $(".health-status").css({"width": ""+ (data.health - 100) * 0.5  +"%"}); 

        // console.log(data.health - 100, 100 <= 50);
        if (data.health - 100 <= 61) {
            $(".health-status").css({"background-color": "#bce40c"}); 
        }else if (data.health - 100 <= 50){
            $(".health-status").css({"background-color": "red"});
        } else if (data.health - 100 >= 62) {
            $(".health-status").css({"background-color": "white"}); 
        }
        if (data.armor >= 1) {
            $(".armor-bar").css({"display": "block"}); 
            $(".armor-status").css({"width": ""+ data.armor * 0.5+"%"}); 

        } else {
            $(".armor-bar").css({"display": "none"}); 
        }
		
		
        Progress(data.thirst, '.progress-water')
        Progress(data.stress, '.progress-stress')
        Progress(data.hunger,'.progress-burger')
        Progress(data.oxygen,'.progress-oxygen')
		
		
		if (data.stamina == 3.5) {
			Progress(25,'.progress-stamina')
            Progress(25,'.veh-progress-stamina')

        }else if (data.stamina == 8){
			Progress(50,'.progress-stamina')
            Progress(50,'.veh-progress-stamina')

        }else if (data.stamina == 15){
			Progress(80,'.progress-stamina')
            Progress(80,'.veh-progress-stamina')
        }else if (data.stamina == 16){
			Progress(100,'.progress-stamina')
            Progress(100,'.veh-progress-stamina')         
        }	
		
		
		
        Progress(data.thirst, '.veh-progress-water')
        Progress(data.stress, '.veh-progress-stress')
        Progress(data.hunger,'.veh-progress-burger')
        Progress(data.oxygen,'.veh-progress-oxygen')
        if (data.incar) {
            
            $(".car-hud").css("display", "block");

            // $('fuel').fadeIn(450);
            // // console.log(data.fuel.toFixed(0))
            // if (data.fuel.toFixed(0) < 101 ) {
            //     $('#benzin-img').css({'background-image':'url("./img/benzin.png")'})
            // } 
            // if (data.fuel.toFixed(0) < 50 ) {
            //     $('#benzin-img').css({'background-image':'url("./img/benzinorta.png")'})
            // } 
            // if (data.fuel.toFixed(0) < 25) {
            //     $('#benzin-img').css({'background-image':'url("./img/benzinlow.png")'})
    
            // }
  
            $(".fuel-bar2-inside").css("width", "100%")
            $(".fuel-bar2-inside").css("background-color", "rgba(241, 241, 241, 0.568)") 

           

            $(".fuel-bar-inside").css("width", data.fuel+"%")
            if (data.fuel <= 20 ) {
                $(".fuel-bar-inside").css("background-color", "red") 
            } else if (data.fuel <= 50) {
                $(".fuel-bar-inside").css("background-color", "#ad2018") 
            } else if (data.fuel <= 100) {
                $(".fuel-bar-inside").css("background-color", "white") 
            }
            // Progress(data.fuel.toFixed(0), '.veh-progress-fuel');
            $(".kmh-number").html(data.speed)    
    
            if (data.engineHealth < 500) {
                $("#engineColor path").css("fill", "orange")
            } else {
                $("#engineColor path").css("fill", "white")
            }
        } else {
            $(".car-hud").css("display", "none");
        }
        // console.log()

        if (data.talking && data.radio) {
            $(".voice-block").css({"background-color": "#3467d4"}); 
        } else if (data.talking) {
            $(".voice-block").css({"background-color": "white"}); 
        } else {
            $(".voice-block").css({"background-color": "rgb(85, 85, 85)"}); 
        }

        if (data.togglehud) {
            $(".ui-container").css("display", 'block');
        } else {
            $(".ui-container").css("display", 'none');
        }
    };

    RCHud.UpdateProximity = function(data) {
        if (data.prova == 1.75) {
            Progress(25, '.progress-stamina')
            Progress(25, '.veh-progress-stamina')
        } else if (data.prova == 4.0) {
            Progress(50, '.progress-stamina')
            Progress(50, '.veh-progress-stamina')
        } else if (data.prova == 7.5) {
            Progress(75, '.progress-stamina')
            Progress(75, '.veh-progress-stamina')
        } else if (data.prova == 8.0) {
            Progress(100, '.progress-stamina')
            Progress(100, '.veh-progress-stamina')
        }
        CurrentProx = data.prova;
    }

    RCHud.SetTalkingState = function(data) {
        if (!data.IsTalking) {
            $(".voice-block").animate({"background-color": "rgb(255, 255, 255)"}, 150);
        } else {
            $(".voice-block").animate({"background-color": "#fc4e03"}, 150);
        }
    }

    RCHud.Update = function(data) {
        if(data.type == "cash") {
            $(".money-cash").css("display", "block");
            $("#cash").html(data.cash);
            if (data.minus) {
                $(".money-cash").append('<p class="moneyupdate minus">-<span id="cash-symbol">&euro;&nbsp;</span><span><span id="minus-changeamount">' + data.amount + '</span></span></p>')
                $(".minus").css("display", "block");
                setTimeout(function() {
                    $(".minus").fadeOut(750, function() {
                        $(".minus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            } else {
                $(".money-cash").append('<p class="moneyupdate plus">+<span id="cash-symbol">&euro;&nbsp;</span><span><span id="plus-changeamount">' + data.amount + '</span></span></p>')
                $(".plus").css("display", "block");
                setTimeout(function() {
                    $(".plus").fadeOut(750, function() {
                        $(".plus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            }
        }
    };

    function Progress(percent, element) {
        var circle = document.querySelector(element)
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;     
        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;
      
        const offset = circumference - ((-percent * 100) / 100 / 100) * circumference;
        circle.style.strokeDashoffset = -offset;
    }

    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case "open":
                    RCHud.Open(event.data);
                    break;
                case "car":
                    RCHud.CarHud(event.data)
                case "close":
                    RCHud.Close();
                    break;
                case "update":
                    RCHud.Update(event.data);
                    break;
                case "show":
                    RCHud.Show(event.data);
                    break;
                case "hudtick":
                    RCHud.UpdateHud(event.data);
                    break;
                case "bunny":
                    RCHud.HudBunny(event.data)        
                break
                case "seatbelt":
                    RCHud.ToggleSeatbelt(event.data);
                    break;
                case "engine":
                    RCHud.Engine(event.data);
                    break;
                case "cruise":
                    RCHud.ToggleCruise(event.data);
                    break;
                case "nitrous":
                    RCHud.UpdateNitrous(event.data);
                    break;
                case "UpdateProximity":
                    RCHud.UpdateProximity(event.data);
                    break;
                case "talking":
                    RCHud.SetTalkingState(event.data);
                    break;
            }
        })
    }

})();