<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>   

<%@page import="com.info.EditUser, com.info.EditProduct, com.info.Data"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hello</title>
    
    <link
	  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	  rel="stylesheet"
	/>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
  
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
  	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
	<style type="text/css">
.jumbotron {
   background-color: #7FB77E;
   text-align: center;
   font-size: 17px;
   color: white;
   margin-bottom: 0;
 }
.navbar {
   padding: 3px;
   background-color: #E8EAE6;
 }
.navbar a {
   font-size: 16px;
   font-weight: 400;
   text-decoration: none;
   color: #224B0C;
}
.navbar a:hover {
   font-weight: bold;
}
</style>
  </head>
  <body>
  
  	   <%
				//HERE WE GETTING THE ATTRIBUTE DECLARED IN VALIDATE.JSP AND CHECKING IF IT IS NULL, THE USER WILL BE REDIRECTED TO LOGIN PAGE
				String uid = (String)session.getAttribute("username");
      			String type = (String)session.getAttribute("type");
				if (session.getAttribute("type").equals("admin")|| uid == null)
				{
					%><!-- NOT A VALID USER, IF THE USER TRIES TO EXECUTE LOGGED IN PAGE DIRECTLY, ACCESS IS RESTRICTED -->
					 	<jsp:forward page="logout.jsp"/>
					<%	
				}
		%> 
    
<div class="jumbotron text-center p-4">	    
	<h1 align="center">Asian Technology Solutions</h1>
	<p align="center">Asian Technology Solutions was founded by IT Professionals and leaders from wide spectrum of industries to build IT business solutions.</p>
</div>
    <nav class="navbar navbar-expand-lg">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="/Project3">Home</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarNav">
	      <ul class="navbar-nav">
	       
	        <li class="nav-item">
	          <a class="nav-link" href="#">About Us</a>
	        </li>
	        
	        <li class="nav-item">
	          <a class="nav-link" href="#">Contact</a>
	        </li>
	        
	        <li class="nav-item">
	          <a class="nav-link" href="#">Detail</a>
	        </li>
	        
	        <li class="nav-item">
	          <a class="nav-link"  href="#">Service</a>
	        </li>
	        
	      </ul>
	    </div>	    
	    <!-- Right elements -->
	     
	    
    <div class="d-flex align-items-center">
				<!-- WE HAVE GIVEN LOGOUT.JSP FILE INORDER TO LOGOUT THE SESSION -->
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
				    	<li class="nav-item">
				        	<a class="nav-link" href="logout.jsp">Logout</a>
						</li>
					</ul>
				</div> 
    </div>
    <!-- Right elements -->
	  </div>
	</nav>
	<br>
	

	<%  
		String id=(String)session.getAttribute("id");  
		String product=(String)session.getAttribute("product");
		Data d=EditProduct.getRecordById(Integer.parseInt(id), product); 
	%>
			
	<%	
		out.println("&ensp; Welcome! " +uid);
	%>
		

<div class="card">
  <div class="card-body">
    <div class="container mb-5 mt-3">

      <div class="container">

        <div class="row my-2 mx-1 justify-content-center">

    	
    	<sql:setDataSource
	        var="myDS"
	        driver="com.mysql.jdbc.Driver"
	        url="jdbc:mysql://localhost:3306/myjavacode"
	        user="root" password="root"
   		/>
   		

   		

    	
    	<sql:query var="listUsers" dataSource="${myDS}">
       		SELECT * FROM <%= request.getParameter("product")%> WHERE id IN (<% 
									    		String checkedFood[] = request.getParameterValues("checkedfood");
   												String a = "";
										    	for(String f: checkedFood) {
													
													a+=f+",";
												}
										    	a = a.substring(0, a.length() -1);
												out.println(a);										    	
										    	
    										%>);
    	</sql:query>
    	
          <table class="table table-striped table-borderless">
            <thead style="background-color:#84B0CA ;" class="text-white">
              <tr>
              	<th scope="col">Name</th>
                <th scope="col">Order Date</th>
                <th scope="col">Cost</th>
              </tr>
            </thead>
            <tbody>
            	<c:set var="costTotal" value="${0}" />
            	<c:forEach var="user" items="${listUsers.rows}">
            		
	              <tr>
	                <td><c:out value="${user.name}" /> </td>
	                <td> <%= request.getParameter("date")%></td>
	                <td><c:out value="Rp ${user.cost}" /></td>
	                <c:set var="costTotal" value="${costTotal + user.cost}" />
	                
	              </tr>
	            </c:forEach>
            </tbody>

          </table>
        </div>
        <div class="row">
          <div class="col-xl-8">
            <p class="ms-3"></p>

          </div>
          <div class="col-xl-3">
            <p class="text-black float-start"><span class="text-black me-3"> Total Amount</span>
            <span style="font-size: 25px;">Rp ${costTotal}</span></p>
          </div>
        </div>
        <hr>
        <div class="row">
          <div class="col-xl-10">
            <p>Thank you for your purchase</p>
          </div>
          <div class="col-xl-2">
            <a class="btn btn-danger" onClick="window.print()"><i class="fa-solid fa-file-pdf"></i> Save to PDF</a>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>

    
    
   <br><br><br>

   <footer class="text-center text-lg-start mt-auto" style="background-color: #E8EAE6;color: #224B0C; padding-top: 15px;">
	  <!-- Grid container -->
	  <div class="container p-3">
	    <!--Grid row-->
	    <div class="row">
	      <!--Grid column-->
	      <div class="col-lg-6 mb-4 mb-md-0">	
	        <p>
	          <i class="fa-solid fa-envelope"></i> hijria.nanda@gmail.com <br>
	          <i class="fa-solid fa-phone"></i> 099999999 <br>
	          <i class="fa-solid fa-location-dot"></i> Jakarta
	        </p>
	      </div>
	      <!--Grid column-->
		 <div class="col-lg-3 mb-4 mb-md-0">
		 </div>
	      <!--Grid column-->
	      <div class="col-lg-3 mb-4 mb-md-0">
	        <p>
	          <a href='http://www.facebook.com/'><i class="fa-brands fa-facebook-f"></i> Facebook</a> <br>
	          <a href='http://www.twitter.com/'><i class="fa-brands fa-twitter"></i> Twitter</a> <br>
	          <a href='http://www.instagram.com/'><i class="fa-brands fa-instagram"></i> Instagram</a> <br>
	          
	        </p>
	      </div>
	      <!--Grid column-->
	    </div>
	    <!--Grid row-->
	  </div>
	  <!-- Grid container -->
	
	  <!-- Copyright -->
	  <div class="text-center p-3" style="background-color: #7FB77E;color: white;">
	    Bootcamp Batch 9 � 2022 Asian Technology Solutions
	  </div>
	  <!-- Copyright -->
	</footer>

  </body>
</html>