<!--
    https://stackoverflow.com/questions/12686465/how-to-use-property-file-in-jsp
-->

<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "java.net.InetAddress" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<!doctype html>
<html>
<head>
<title>JSP Test</title>

<%
FileInputStream fis = new FileInputStream("webapps/demo.properties");
Properties prop = new Properties();
prop.load(fis);
String user_name = prop.getProperty("db_user_name");
String user_password = prop.getProperty("db_user_password");
String db_server = prop.getProperty("db_server_ip");
String db_url = "jdbc:postgresql://" + db_server + "/movies";
%>

</head>
<body>

<sql:setDataSource var = "snapshot" driver = "org.postgresql.Driver"
         url = "<%= db_url%>"
         user = "<%= user_name%>"  
         password = "<%= user_password %>"/>

<sql:query dataSource = "${snapshot}" var = "result">
 SELECT * from superheroes;
</sql:query>

      <table border = "1" width = "50%">
         <tr bgcolor="#bbffbb">
            <th>Superheroe's name: </th>
         </tr>
         
         <c:forEach var = "row" items = "${result.rows}">
            <tr>
               <td align="center"><c:out value = "${row.name}"/></td>
            </tr>
         </c:forEach>
      </table>

<hr>

<%
String ip = "";
InetAddress inetAddress = InetAddress.getLocalHost();
ip = inetAddress.getHostAddress();
out.println("Server Host Name :: "+inetAddress.getHostName() + "<br>");
out.println("Server IP Address :: "+ip + "<br>");
out.println("Server date/time :: "+new java.util.Date() + "<br>"); 
out.println("---"  + "<br>");
%>

<%
String home = System.getProperty("user.home");
out.println("USER.HOME :: "+home + "<br>");
out.println("JAVA.DIR :: "+System.getProperty("user.dir") + "<br>");
out.println("JAVA.VENDOR :: "+System.getProperty("java.vendor") + "<br>");
out.println("JAVA.VERSION :: "+System.getProperty("java.version") + "<br>");
%>

</body>
</html>
