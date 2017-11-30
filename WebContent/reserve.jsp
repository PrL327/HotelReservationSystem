<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="js/reserve.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
  <style>
    .hidden {
      visibility: hidden;
    }
  </style>
</head>

<body>
  <form class="jumbotron">
    <div>
      <h2>Make Your Reservation</h2>
    </div>
    <div class="form-group col-2 ">
      <label for="exampleSelect1">Hotel</label>
      <select class="form-control" id="exampleSelect1" placeholder="Hotel..">
        <option selected="selected">Select a Hotel</option>
        <option>Temp1</option>
        <option>Temp2</option>
        <option>Temp3</option>
        <option>Temp4</option>
        <option>Temp5</option>
      </select>
    </div>
    <h4>Room Reservation Details:<Small> Reserve up to 3 Rooms</small> </h4>
    <a href="">View Hotel Rooms</a>
    <div id="RoomReservation_" style="margin-bottom:2vh; margin-top:1vh;">
      <div class="Room_">
        <fieldset class="appear">
          <h6>Room Details</h6>
          <div class="row">
            <div class="col-2">
              <div class="form-group ">
                <label for="exampleSelect1">Room</label>
                <select class="form-control" id="exampleSelect1" placeholder="Hotel..">
            <option selected="selected">Pick a Room</option>
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
          </select>
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>Numer of Guests in Room:</label>
                <input type=text class="form-control">
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>From:</label>
                <input type=date class="form-control">
              </div>
            </div>
            <div class="col-2">
              <div class="form-group">
                <label>To:</label>
                <input type=date class="form-control">
              </div>
            </div>
          </div>
        </fieldset>
        <fieldset>
          <h6>Breakfast & Services:</h6>
          <div class="col-sm-4" style="margin-left:2vw; margin-top:1vh;">
            <div class="row" style="margin-right:2vw;" id="BreakfastOption_1">
              <div class="breakfasts col">
              <div class="form-row">
                <div class="col">
                  <div class="form-group">
                    <label for="exampleSelect1">Breakfast</label>
                    <select class="form-control" id="exampleSelect1" placeholder="Hotel..">
                      <option selected="selected">Choose a Breakfast</option>
                      <option>American</option>
                      <option>British</option>
                      <option>Mexican</option>
                      <option>Dutch</option>
                    </select>
                  </div>
                </div>
                <div class="col">
                  <div class="form-group">
                    <label for="exampleSelect1">Quantity</label>
                    <input class="form-control" size=2>
                  </div>
                </div>
              </div>
              </div>
              </div>
            <div class="col-sm-6" id="ServicesOption_">
              <div class="services form-group">
                <label for="Services_">Services</label>
                <select class="form-control" id="Services_" placeholder="Hotel..">
                  <option selected="selected">Choose a Service</option>
                  <option>Spa</option>
                  <option>Parking</option>
                  <option>Conference</option>
                  <option>Shuttle</option>
                </select>
              </div>
            </div>
          </div>
          <div class="form-row">
            <div class="col-sm-2">
              <a href="#" class="addservices">Add another Service</a>
            </div>
            <div class="col">
              <a href="#" class="addbreakfast">Add another Breakfast</a>
            </div>
          </div>
        </fieldset>
      </div>
    </div>
    <div class="form-row">
      <div class="col-sm-2">
        <button href="#" class='btn btn-primary addsection'>Add Another Room</button>
      </div>
      <div class="col">
        <button type="Button" href="#" id="next" class='next btn btn-success'>Next</button>
      </div>
    </div>
    <div id="Payment_info" class="hidden">
    <fieldset style="margin-top:3vh;">
      <h4>Payment Info</h4>
      <div class='row'>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Card Number</label>
            <input class='form-control' type='text'>
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Card Type</label>
            <select class="form-control" id="exampleSelect1" placeholder="Hotel..">
            <option selected="selected">Card Type</option>
            <option>Visa</option>
            <option>MasterCard</option>
            <option>Amex</option>
            <option>Discover</option>
          </select>
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>CVC Num</label>
            <input class='form-control' type='text' size=3 placeholder="CVC">
          </div>
        </div>
      </div>
      <div class='row'>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Name on Card</label>
            <input class='form-control' type='text'>
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Exp Date</label>
            <input class='form-control' type='month'>
          </div>
        </div>
        <div class="col-2">
          <div class='form-group required'>
            <label class='control-label'>Billing Address</label>
            <input class='form-control' type='text' size=3 placeholder="CVC">
          </div>
        </div>
      </div>
    </fieldset>
    <button type="add" class="btn btn-primary btn-lg">Submit</button>
  </div>
  </form>
</body>
</html>