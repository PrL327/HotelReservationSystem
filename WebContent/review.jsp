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
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
</head>
<body>
<div class="container jumbotron align-self-center">
  <div id ="review_header">
    <h5> This is a review for:</h5>
    <label>Service/Breakfast/Room:/</label>
  </div>
  <div>
    <h6>Rating</h6>
    <div class=row>
      <label style="margin-left:3vw; margin-right:2vw;">Please rate this service from 1-10</label>
      <input class="form-control" type="number" id="review_rating" size="2" min=1 max=10 style="margin-bottom: 2vh">
    </div>
  </div>
  <div>
    <h6>Comments:</h6>
    <textarea  class="form-control" rows="5" id="review_description"></textarea>
  </div>
</div>
<button type="submit" class="btn btn-success" id="submit_review" style="margin-top:5vh;">Submit</button>
<div>
</body>
</html>