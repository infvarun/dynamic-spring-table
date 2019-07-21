<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


<style type="text/css">
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}
</style>
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
</style>

</head>
<body>
	<table id="t1">
		<thead>
			<tr>
				<th>ID</th>
				<th>Firstname</th>
				<th>Lastname</th>
				<th>Age</th>
			</tr>
		</thead>
		<tbody id="allRows"></tbody>
	</table>
	<!-- The Modal -->
	<div id="myModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">
			<span class="close">&times;</span>
			<form name="form1" id="form1">
				<table>
					<tr>
						<td>ID</td>
						<td><input type="text" name="n0" id="n0" disabled="disabled"/></td>
					</tr>
					<tr>
						<td>Firstname</td>
						<td><input type="text" name="n1" id="n1" /></td>
					</tr>
					<tr>
						<td>Lastname</td>
						<td><input type="text" name="n2" id="n2" /></td>
					</tr>
					<tr>
						<td>Age</td>
						<td><input type="text" name="n3" id="n3" /></td>
					</tr>
					<tr>
						<td><button id="save" onclick="updateTable()">Save</button></td>
						<td><span id="result"></span></td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<script>
	//Dialog Box script
	let id, fn, ln, ag;
	
		// Get the modal
		var modal = document.getElementById("myModal");
		
		// Get the button that opens the modal
		var btn = document.getElementById("myBtn");
		
		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];
		
		// When the user clicks the button, open the modal 
		function rowDialog(idnum, fname, lname, age) {
			console.log('Firstname: '+fname+' Lastname: '+lname+' age: '+age);
			id = idnum;
			fn = fname;
			ln = lname;
			ag = age;
		  modal.style.display = "block";
		  document.getElementById("n0").value = idnum;
		  document.getElementById("n1").value = fname;
		  document.getElementById("n2").value = lname;
		  document.getElementById("n3").value = age;
		}
		
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
		  modal.style.display = "none";
		}
		
		function updateTable() {
			id = document.getElementById("n0").value;
			fname = document.getElementById("n1").value;
			lname = document.getElementById("n2").value;
			age = document.getElementById("n3").value;
			init('http://localhost:8085/edit?id='+id+"&fname="+fname+"&lname="+lname+"&age="+age);
			modal.style.display = "none";
		}
	</script>

	<script>
	//Table row event handler
		init('http://localhost:8085/list');
	
		function init(url){
			$("#t1 > tbody").empty();
			$.getJSON(url, function(data) {
		        
		        console.log(data);
		        for(let i=0; i<data.length; i++) {
		        	var tableRef = document.getElementById('t1').getElementsByTagName('tbody')[0];

		        	// Insert a row in the table at the last row
		        	var newRow   = tableRef.insertRow();
		        	newRow.setAttribute('onclick', 'rowClickHandle(this)');
		        	
		        	//CREATE CELLS
		        	// Insert a cell in the row at index 0
		        	var idCell  = newRow.insertCell(0);
		        	// Append a text node to the cell
		        	var newText  = document.createTextNode(data[i].id);
		        	idCell.appendChild(newText);
		        	
		        	// Insert a cell in the row at index 1
		        	var fnCell  = newRow.insertCell(1);
		        	// Append a text node to the cell
		        	newText  = document.createTextNode(data[i].fname);
		        	fnCell.appendChild(newText);
		        	
		        	// Insert a cell in the row at index 2
		        	var lnCell  = newRow.insertCell(2);
		        	// Append a text node to the cell
		        	newText  = document.createTextNode(data[i].lname);
		        	lnCell.appendChild(newText);
		        	
		        	// Insert a cell in the row at index 3
		        	var ageCell  = newRow.insertCell(3);
		        	// Append a text node to the cell
		        	newText  = document.createTextNode(data[i].age);
		        	ageCell.appendChild(newText);
		        }
		    });
		}
		
		function rowClickHandle(rowref) {
			id = rowref.cells[0].innerText;
			fname = rowref.cells[1].innerText;
			lname = rowref.cells[2].innerText;
			age = rowref.cells[3].innerText;
			rowDialog(id, fname, lname, age);
		}
	</script>

</body>
</html>