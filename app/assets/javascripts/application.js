// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .


/* ==================================================
DECLARE GLOBAL VARS
================================================== */

let mapQuestKey = 'fGs90Xaz6Ar09AEHLz7wgjjwTWV7vFJz', //MapQuest API Key
    myMapQuestForm, //Var to hold a reference for the form taking care of geolocation
    myMapQuestButton, //Var to hold a reference for the Map Quest Button to submit data to API
    myMapQuestCloser, //Var to hold a reference for the button closing the map
    myMap, //Var to hold a refernce for the div holding the map
    myMapMarker, //Var to hold a reference for the MapQuest Markers
    mySelects, //Var to hold a reference for the different select form fields
    myFormGroup, //Var to hold a reference for the form group so we can populate its fileds according to changes on other DOM NODES
    myInputs, //Var to hold a reference for all the inputs containing user data
    myListTogglers, //Var to hold a reference for the <h6> DOM nodes toggling the list of dignities in show.html.erb
    mySubmitBtn; //Var to hold a reference for the Submit Button

const myMarkerIconOptions = {
  primaryColor: '#22407F',
  secondaryColor: '#3B5998',
  shadow: false,
  size: 'md'
}

/* ==================================================
LOCAL Fetching FUNCTION
================================================== */

class Fetch {
  async apiCall(_url, _data) {


    const call = await fetch(_url),
          data = await call.json();

    return data;
  }
}

const fetchC = new Fetch(); //Custom Fecth Class



/* ==================================================
UTILS FUNCTION
================================================== */

const leadingStringToZero = (_str) => {
  _str.length < 2 ? _str = '0' + _str : null;
  return _str;
},
insertAfter = (_newNode, _referenceNode) => {
    _referenceNode.parentNode.insertBefore(_newNode, _referenceNode.nextSibling);
}


/* ==================================================
MAPQUEST FUNCTION
================================================== */

const mapQuestCall = (_countryCode, _cityName) => {

  /*=================================================
  @params
  _countryCode -> String -> i.e: ES for Spain
  _cityName -> String -> i.e: Madrid for Madrid
  =================================================== */

  !_cityName.length  ? _cityName = 'a' : null;

  L.mapquest.key = mapQuestKey;

  myMap ? myMap.remove() : null; //Remove map if present

  L.mapquest.geocoding().geocode({city:_cityName, country:_countryCode}, (error, response) => {

    console.log(response);

    let location = response.results[0].locations[0],
        lat = location.latLng.lat,
        lng = location.latLng.lng;
        latLng = location.displayLatLng;


    myMap = L.mapquest.map('map_mq', {
      center: latLng,
      layers: L.mapquest.tileLayer('dark'),
      zoomControl : false,
      zoom: 12
    }).addEventListener('click', (e) => {
      console.info(e, 'clicked on map');

      myMap.removeLayer(myMapMarker);
      myMapMarker = new L.marker(e.latlng, {
        icon: L.mapquest.icons.marker(myMarkerIconOptions)
      }).addTo(myMap);

      setFormCoordinates(e.latlng.lat,e.latlng.lng);

    });

    myMapMarker = L.marker([lat,lng], {
       icon: L.mapquest.icons.marker(myMarkerIconOptions)
     }).addTo(myMap);


     setFormCoordinates(lat,lng);


  });




}

/* ==================================================
LOGIC FUNCTION
================================================== */

const setFormCoordinates = (_lat,_lng) => {
  document.getElementById('latitude').value = _lat;
  document.getElementById('longitude').value = _lng;

  // Experimental visual info for user once lat, long are set
  // L.mapquest.key = mapQuestKey;
  //
  // L.mapquest.geocoding().reverse({lat:_lat,lng:_lng}, (error, response) => {
  //   console.log('reverse response is ');
  //   console.dir(response);
  // });

  document.querySelector('input.msg-mq').value = 'Located at ' + _lat.toFixed(2) + ' lat, ' + _lng.toFixed(2) + ' lng';

  !document.querySelector('div.mq-ui--miniform').classList.contains('show-msg') ? document.querySelector('div.mq-ui--miniform').classList.add('show-msg') : null;

  isFormReady();

},
isFormReady = () => {
  let ready = true; //Var to keep track of the form readinees

  mySelects.map( (_obj) => {
    _obj.value == 'none' ? ready = false : null; //If there is any unset select set the form to not ready
  } );

  //if we are not showing the map locked message we do not have geo coordinates. Form is not ready

  //console.log(document.querySelector('div.mq-ui--miniform').classList);

  !document.querySelector('div.mq-ui--miniform').classList.contains('show-msg') ? ready = false : null;

  //Enable/Disable Submit button based on form readiness

  if(ready) {
    mySubmitBtn.classList.contains('disabled') ? mySubmitBtn.classList.remove('disabled') : null;
  }else {
    !mySubmitBtn.classList.contains('disabled') ? mySubmitBtn.classList.add('disabled') : null;
  }


},
toggleCityInput = () => {

  if(document.querySelector('select.country-mq').value != 'none'){

    document.querySelector('div.mq-ui').classList.contains('disabled') ? document.querySelector('div.mq-ui').classList.remove('disabled') : null;
  }else {
    !document.querySelector('div.mq-ui').classList.contains('disabled') ? document.querySelector('div.mq-ui').classList.add('disabled') : null;
  }

  //Reset the city input field on every country select change
  document.querySelector('input.city-mq').value = '';
  //Reset the city to accept new values
  document.querySelector('div.mq-ui--miniform').classList.contains('show-msg') ? document.querySelector('div.mq-ui--miniform').classList.remove('show-msg') : null;


},
onInputLeave = e => {

  mapQuestCall(myMapQuestForm.querySelector('select').value, myMapQuestForm.querySelector('input.city-mq').value);

},
addInteractions = () => {

  //Remove any alert if present sequentially by 2 second interval/delay

  if(document.querySelector('p.alert ')) {

      Array.from(document.querySelectorAll('p.alert')).forEach((el,i) => {
        setTimeout(() => {el.classList.add('faded')}, (i + 1) * 2000 );
      });
  }

  //Dropdown interaction - no external dependencies

  document.querySelector('a.dropdown-toggle').addEventListener('click', (e) => {
    e.target.parentNode.querySelector('div.dropdown-menu').style.display != 'block' ? e.target.parentNode.querySelector('div.dropdown-menu').style.display = 'block' : e.target.parentNode.querySelector('div.dropdown-menu').style.display = '';
    e.preventDefault();
  });

  //Only attempt to add interactions if we are on the new page (pathname agnostic)

  if(mySubmitBtn && mySelects.length > 0) {

    mySelects.map((_obj) => {
      _obj.addEventListener('change', (e) => {
        console.log(e, _obj.value);

        let mySelectedValue = _obj.value, //Store the value that just changed
            mySubmitFormTarget = _obj.classList[1]; //Get the last className from the select classList which will refer to the target in which we need to place the right values for submiting the form

        switch (mySubmitFormTarget) {
          case 'country-mq':
            toggleCityInput();
          break;
          case 'day':
            console.log('changed the day select');
            document.getElementById('day').value = _obj.value; //Set day to submit form
          break;
          case 'month':
            console.log('changed the month select');
            document.getElementById('month').value = _obj.value; //Set month to submit form
          break;
          case 'year':
            console.log('changed the year select');
            document.getElementById('year').value = _obj.value; //Set year to submit form
          break;
          case 'hour':
            console.log('changed the hour select');
            document.getElementById('hour').value = _obj.value + ' : ' + document.querySelector('select.form-control.minutes').value; //Set hour + minutes to submit form
          break;
          case 'minutes':
            console.log('changed the minutes select');
            document.getElementById('hour').value = document.querySelector('select.form-control.hour').value + ' : ' +  _obj.value ;//Set hour + minutes to submit form
          break;
          default:
            null;
          break;
        }

        isFormReady();

      });


    });




    myMapQuestButton.map( (_obj) => {

      _obj.addEventListener('click', (e) => {


      if(document.querySelector('select.country-mq').value == 'none'){

        let myAlert = document.createElement('p');

        myAlert.className = 'alert alert-danger';
        myAlert.innerHTML = 'Please, first select a Country to locate on Map';

        insertAfter(myAlert, document.querySelector('ul.nav')); //insert Alert on top of page

        setTimeout( () => {
          myAlert.classList.add('faded');
        }, 2000);


      }else {   //Open Map

        !document.body.classList.contains('has-map') ? document.body.classList.add('has-map') : null;

        console.log(myMapQuestForm.querySelector('input.city-mq').value.length);

        //Only make a blind call to API (no city) if there is no data in its input field and map is not already locked somewhere

        if(myMapQuestForm.querySelector('input.city-mq').value.length < 1 && !document.querySelector('div.mq-ui--miniform').classList.contains('show-msg')) {

          setTimeout(function () {
            mapQuestCall(myMapQuestForm.querySelector('select').value, myMapQuestForm.querySelector('input.city-mq').value);
          }, 1000); //Send the call with a one second delay so mapcan me reset properly when calling from on blur event as well


        }



      }

      });
    });




    myMapQuestCloser.addEventListener('click', (e) => {
      document.body.classList.contains('has-map') ? document.body.classList.remove('has-map') : null;
    });


    //Normalize SubmitButton

    // Catching =  false is not working on root?
    // config.action_controller.perform_caching  = false
    // on config/environments/development.rb

    !mySubmitBtn.classList.contains('disabled') ? mySubmitBtn.classList.add('disabled') : null;

    myInputs.map((_obj) => {
      _obj.addEventListener('blur', onInputLeave, false);
    });

  }else {

    /* Interactions for show.html.erb
    =================================================== */

    myListTogglers = Array.from(document.querySelectorAll('h6.heading:not(.total)')).map( (_obj) => {

      _obj.addEventListener('click', (e) => {
        !_obj.nextElementSibling.classList.contains('expanded') ? _obj.nextElementSibling.classList.add('expanded') : _obj.nextElementSibling.classList.remove('expanded');
      });

    });
  }

},
init = e => {



  document.removeEventListener('turbolinks:load', init, false);
  //Store/Assign DOM Elements
  myMapQuestForm = document.querySelector('div.formgroup.secondary');
  myMapQuestButton = Array.from(document.querySelectorAll('button.mq-btn'));
  myMapQuestCloser = document.getElementById('closer-mq');
  mySubmitBtn = document.getElementById('btn-submit');
  mySelects = Array.from(document.querySelectorAll('div.formgroup.secondary select'));
  myInputs = Array.from(document.querySelectorAll('div.formgroup.secondary input[type="text"]'));

  addInteractions();

}



// //Entry Point
document.addEventListener('DOMContentLoaded', init, false);
