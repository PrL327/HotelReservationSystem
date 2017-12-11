<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page session="true" %>
<html>
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
    <style>
    .loginPane {
        position: fixed;
        /*width: 300px;
        height: 200px;*/
        /*z-index: 15;*/
        margin-top: 10vh;
        margin-left: 50vh;
        /*margin: -100px 0 0 -150px;*/
        /*background: red;*/
      }
      body {
        background-image: url('photos/skyline.jpeg');
        background-size: 100% 100%;
      }
      .alert {
   		display:inline-block;
   		width:680px;
        margin-left: 12vw;   
	}
    </style>
    <link href="css/login.css" rel="stylesheet">
  </head>
  <body>
    <div class="container">
    <% try {
        			if(session.getAttribute("LOGIN_STATUS") == "invalid_login"){
        				out.println("<div class='alert alert-danger' role='alert'><strong>Invalid Login!</strong> Email/Password is inccorrect or account does not exsist.</div>");
        			}
        			
        } catch (Exception e){
        	
        }
        %>
      <div class="col-lg-4">
        <div class="jumbotron loginPane">
        	  <a href="HelloWorld.jsp">Go Home</a>
          <h4> Log in: </h4>
          <form method = "log_in" action = "verify-login.jsp">
            <div class="form-group">
              <input type="email" class="form-control" placeholder="Email" name = "email">
            </div>
            <div class="form-group">
              <input type="password" class="form-control" placeholder="Password" name ="password">
            </div>
            <button type="Submit" class="btn btn-primary form-control" style="margin-bottom:2vh;">Log in</button>
            No Account. <a href="account_register.jsp">Register Now</a>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>