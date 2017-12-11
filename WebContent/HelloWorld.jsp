<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../../../favicon.ico">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>

    <title>Cover Template for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="../../../../dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/cover.css" rel="stylesheet">
    <style>
    .page-select {
      width: 25vw !important;
      flex: none !important;
    }
    </style>
  </head>

  <body>
    <div class="site-wrapper">
      <div class="site-wrapper-inner">
        <div class="cover-container">
          <header class="masthead clearfix">
            <div class="inner">
              <h3 class="masthead-brand">Welcome</h3>
              <nav class="nav nav-masthead">
                <a class="nav-link active" href="#">Home</a>
                <a style="color:white;" class="nav-link" href="account_register.jsp">Create an Account</a>
                <a style="color:white;" class="nav-link" href="hotel_stats.jsp">Stats</a>
                <a style="color:white;" class="nav-link" href="login.jsp">Log In</a>
              </nav>
            </div>
          </header>
          <main role="main" class="inner cover">
            <h1 class="cover-heading">Travel. And Stay with the Best</h1>
            <p class="lead">We hope you enjoy your stay</p>
            <p class="lead">
              <a href="login.jsp" class="btn btn-lg btn-primary">Reserve Now</a>
            </p>
            <form method=HotelDetails action="HotelDetails.jsp">
              <h4> Find a Hotel and all its info:</h4>
              <div class="input-group" style="margin-left:6vw;">
                <select name = "Hotel" class="form-control page-select" style="margin-right: 2vw;">
                  <option value=88877741> The Nantucket Hotel & Resort </option>
                  <option value=654684664> The Inn at Lost Creek </option>
                  <option value=687564646> Stephanie Inn </option>
                  <option value=784512231> The Charmant Hotel </option>
                  <option value=894561654> The Oxford Hotel </option>
                </select>
                <span class="input-group">
                  <input class="btn btn-primary" value="Go" type="submit" style="padding-left:2vw; padding-right:2vw;">
                </span>
            </div>
            </p>
          </form>
          </main>
        </div>
      </div>
    </div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="../../../../assets/js/vendor/popper.min.js"></script>
    <script src="../../../../dist/js/bootstrap.min.js"></script>
  </body>
</html>