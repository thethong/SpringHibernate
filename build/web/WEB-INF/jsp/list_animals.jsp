<%-- 
    Document   : animals
    Created on : Aug 6, 2014, 2:55:40 PM
    Author     : user
--%>
<%--
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<TITLE>Crunchify - Spring MVC Example with AJAX call</TITLE>
 
<style type="text/css">
body {
    background-image:
        url('http://cdn3.crunchify.com/wp-content/uploads/2013/03/Crunchify.bg_.300.png');
}
</style>
<script type="text/javascript"
    src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script type="text/javascript">
    function crunchifyAjax() {
        $.ajax({
            url : 'ajaxtest.html',
            success : function(data) {
                $('#result').html(data);
            }
        });
    }
</script>
 
<script type="text/javascript">
    var intervalId = 0;
    intervalId = setInterval(crunchifyAjax, 3000);
</script>
</head>
 
<body>
    <div align="center">
        sxdcfghjkl
        <br> <br> ${message} <br> <br>
        <div id="result"></div>
        <br>
        <p>
            by <a href="http://crunchify.com">Crunchify.com</a>
        </p>
    </div>
</body>
</html>
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    </head>
    <body>
        <style type="text/css">
            table.myClass {
                    border: 1 solid blue;
            }
        </style>
        <input style="width:100px;height:30px" id="btnTest" type="button" value="TEST POST AJAX" />    
        <div>
            <h1>NAME:  </h1>
        </div>
        <div style="width:100%">
            <table style="width:100%">
                <tr>
                    <td align="center"><input style="width:100px;height:30px" id="btnSearchDog" type="button" value="Dog" /></td>
                    <td align="center"><input style="width:100px;height:30px" id="btnSearchCat" type="button" value="Cat" /></td>
                    <td align="center"><input style="width:100px;height:30px" id="btnSearchDogOrCat" type="button" value="Dog or Cat" />
                    </td>
                </tr>
            </table>
        </div>
        <div style="width:100%">
            <input align="center" style="width:100%;height:30px" id="btnRefresh" type="button" value="push to refresh" />
        </div>
        <div>
            <table id="tblInfo" style="border: 1px solid blue; border-collapse: collapse;">
                <c:forEach var = "lst" items="${lst}">
                    <tr>
			<td width="5%" style ="border:1px solid blue;"><img src="${lst.profileImageUrl}" alt="Smiley face" width="42" height="42"></td>
			<td style ="border:1px solid blue;">${lst.name}</td>
			<td style ="border:1px solid blue;">${lst.text}</td>
                    <tr>
                </c:forEach>
            </table>
        </div>
        <div class="modal"></div>
        <script type="text/javascript">

        $(document).ready(function(){
                  var statusDog = "NULL";
                  var statusCat = "NULL";
                  $("#btnRefresh").hide();
	
                  //event click search dog
                  $("#btnSearchDog").click(function(){
                          // set backgroud
                          $("#btnSearchDog").css('background-color', 'red');
                          $("#btnSearchCat").css('background-color', '');
                          $("#btnSearchDogOrCat").css('background-color', '');
		  
                          statusDog = "dog";
                          $("#btnRefresh").show();
                          search("dog","NULL");
                  });

                  //event click search cat
                  $("#btnSearchCat").click(function(){
                          $("#btnSearchDog").css('background-color', '');
                          $("#btnSearchCat").css('background-color', 'red');
                          $("#btnSearchDogOrCat").css('background-color', '');
		  
                          statusCat = "cat";
                          $("#btnRefresh").show();
                          search("cat","NULL");
                  });

                  //event click search dog or cat
                  $("#btnSearchDogOrCat").click(function(){
                          $("#btnSearchDog").css('background-color', '');
                          $("#btnSearchCat").css('background-color', '');
                          $("#btnSearchDogOrCat").css('background-color', 'red');
		  
                          statusDog = "dog";
                          statusCat = "cat";
                          $("#btnRefresh").show();
                          search("dog","cat");
                  });
	  
                  $("#btnRefresh").click(function(){
                          search(statusDog,statusCat);
                  });
                  
                  $("#btnTest").click(function(){
                        $.ajax({
                                type: "post",
                                url: "http://localhost:8084/SpringHibernate/animal/post.html",
                                cache: false,				
                                //data:'firstName=' + $("#firstName").val() + "&lastName=" + $("#lastName").val() + "&email=" + $("#email").val(),
                                success: function(response){
                                        var obj = JSON.parse(response);
                                        alert(obj);
                                },
                                error: function(){						
                                        alert('Error while request..');
                                }
                        });
                  });
                });

        function search(strDog,strCat)
        {
                $('body').addClass("loading");
                jQuery.ajax({
                    url: 'http://localhost:8084/SpringHibernate/animal/search', // url call controller at server (PHP)
                    type: "POST", // method transfer data
                    data: {DOG: strDog, CAT: strCat}, // data JSON need move to server 
                    success: function(response) {			// transfer succees
                        var result = JSON.parse(response);	// Convert data 
                        console.log(result);
                        var strHtml = "";
                        //get html add table
                        for (var i = 0; i < result.length; i++)
                        {
                            strHtml += '<tr>';
                            strHtml += '		<td width="5%" style ="border:1px solid blue;"><img src="' + result[i].profile_image_url + '" alt="Smiley face" width="42" height="42"></td>';
                            strHtml += '		<td style ="border:1px solid blue;">' + result[i].name + '</td>';
                            strHtml += '		<td style ="border:1px solid blue;">' + result[i].text + '</td>';
                            strHtml += '<tr>';
                        }
                        $("#tblInfo").html(strHtml);

                        $('body').removeClass("loading");
                    },
                    error: function(xhr, tStatus, e) {			//transfer unsuccess
                        $('body').removeClass("loading");
                        alert("Error");
                    }

                });
            }
        </script>

    </body>
</html>